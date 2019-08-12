#include <string.h>
//#include "FreeRTOS.h"
#include "osal.h"
//#include "task.h"
//#include "hsuart/hal_hsuart.h"
#include "drv_hsuart.h"
//#include "user_log.h"
#include "user_atcmd.h"






/***********************************************************************************/
#define ANION								"anionOnOff"			//负离子
#define ULTRAVIOLET							"ultravioletOnOff"		//消毒
#define AIR_DRYING							"airDryOnOff"			//风干
#define DRYING								"drying"				//烘干
#define ILLUMINATION						"illumination"			//照明
#define UP_DOWN								"motorControl"			//上升或下降

#define APP_UART_BAUD						9600

#define STATUS_ON							0x01
#define STATUS_OFF							0x00
#define CLOTHES_POLE_UP						0x00
#define CLOTHES_POLE_DOWN					0x3F
#define CLOTHES_POLE_STOP					0xF0
#define CLOTHES_POLE_BRIGHTNESS_100			0x0F

#define MCU_ACK_PACKET_LEN					10
#define MCU_ACK_PACKET_END_CODE				0x96
#define MCU_ACK_TIMEOUT						3000

#define APP_EVENT_ULTRAVIOLET				0x0001
#define APP_EVENT_AIR_DRYING				0x0002
#define APP_EVENT_DRYING					0x0004
#define APP_EVENT_ILLUMINATION				0x0008
#define APP_EVENT_UP_DOWN					0x0010
#define APP_EVENT_ANION						0x0020

#define APP_EVENT_ALL						APP_EVENT_ULTRAVIOLET |\
											APP_EVENT_AIR_DRYING |\
											APP_EVENT_DRYING |\
											APP_EVENT_ILLUMINATION |\
											APP_EVENT_UP_DOWN |\
											APP_EVENT_ANION

/***********************************************************************************/
appUartRx_t appUartRx;
OsSemaphore appUartRxSem = NULL;
deviceProperty_t deviceProperty;
deviceStatus_t deviceStatus;
OsTimer ackTimeOut = NULL;
//EventGroupHandle_t cmdEventGroup;
OsMsgQ cmdMsgQ;




/***********************************************************************************/
void app_uart_init(unsigned int);
void app_uart_isr(void);
void app_uart_rx_task(void *);
void app_post_msg_task(void *);
void cmd_ack_timerout(void);
uint8_t data_is_cmd(char* str,uint16_t strLen);
void uart_cmd_process(char* str,uint16_t strLen);
uint8_t* app_cmd_set_packet(deviceProperty_t deviceParams);
void update_dev_local_status(void);





/***********************************************************************************/
void app_components_init(void)
{
	app_uart_init(APP_UART_BAUD);
	app_timer_init();
	OS_TaskCreate(app_post_msg_task, "app post msg task", 1024, NULL, 2, NULL);
}

void app_timer_init(void)
{
	if (OS_TimerCreate(&ackTimeOut,MCU_ACK_TIMEOUT, (unsigned char)0, NULL,\
		(OsTimerHandler)cmd_ack_timerout) != OS_SUCCESS) {
         printf("command timer create error!\n");
    }
}

void cmd_ack_timerout(void)
{
	printf("MCU response timeout!\n");
}

void app_uart_init(unsigned int bps)
{
    drv_hsuart_init ();
    drv_hsuart_sw_rst ();
    drv_hsuart_set_fifo (HSUART_INT_RX_FIFO_TRIG_LV_16);
    drv_hsuart_set_hardware_flow_control (16, 24);

    drv_hsuart_set_format(bps, HSUART_WLS_8,HSUART_STB_1 , HSUART_PARITY_DISABLE);

	drv_hsuart_register_isr(HSUART_RX_DATA_READY_IE, app_uart_isr);
	if (OS_SemInit(&appUartRxSem, 1, 0) == OS_SUCCESS) {
        OS_TaskCreate(app_uart_rx_task, "app uart rx task", 768, NULL, 2, NULL);
	}
}

void app_uart_isr(void)
{
    uint32_t len;

    len = drv_hsuart_read_fifo(&appUartRx.buf[appUartRx.recvLen], (APP_UART_BUF_MAX - appUartRx.recvLen), HSUART_NON_BLOCKING);
	if (len > 0) {
	   appUartRx.recvLen += len;
	   if (appUartRx.recvLen >= APP_UART_BUF_MAX) {
          OS_SemSignal(appUartRxSem);
	   }
	} else {
       printf("uart isr buffer is NULL!\n");
	}
}

void app_uart_rx_task(void *param)
{
   	OS_STATUS ret;
    app_uart_send("device ready\r\n",strlen("device ready\r\n"));
	
   	while (1) {
      	ret = OS_SemWait(appUartRxSem, APP_UART_RX_TIMEOUT/OS_TICK_RATE_MS);
      	if (ret == OS_TIMEOUT) {
         	if (appUartRx.recvLen > 0) {
				if (data_is_cmd(appUartRx.buf,appUartRx.recvLen)) {
					uart_cmd_process(appUartRx.buf,appUartRx.recvLen);
				} else {
					//APP_PRINT("data is not command!\n");
					app_uart_send(appUartRx.buf,appUartRx.recvLen);
				} 
				appUartRx.recvLen = 0;
		 	}
      	} else if (ret = OS_SUCCESS) {
      		if (data_is_cmd(appUartRx.buf,appUartRx.recvLen)) {
				uart_cmd_process(appUartRx.buf,appUartRx.recvLen);
			} else {
				//APP_PRINT("data is not command!\n");
				app_uart_send(appUartRx.buf,appUartRx.recvLen);
			} 
			appUartRx.recvLen = 0;
	  	}
   	}
	OS_TaskDelete(NULL);
}

void app_uart_send(char* str,uint16_t strLen)
{
	drv_hsuart_write_fifo(str,strLen, HSUART_BLOCKING);
}

uint8_t data_is_cmd(char* str,uint16_t strLen)
{
	uint8_t ret = 0;
	if ((strLen == MCU_ACK_PACKET_LEN) && ((uint8_t)(*(str + strLen - 1)) == MCU_ACK_PACKET_END_CODE)) {
		ret = 1;
	}
	return ret;
}

void update_dev_local_status(void)
{
	deviceProperty.functionStatus &= 0x7F;
	deviceProperty.functionStatus |= (deviceStatus.ultravioletOnOff)<<7;
	
	deviceProperty.functionStatus &= 0xBF;
	deviceProperty.functionStatus |= (deviceStatus.airDryOnOff)<<6;

	deviceProperty.functionStatus &= 0xDF;
	deviceProperty.functionStatus |= (deviceStatus.drying)<<5;
	
	deviceProperty.lightStatus	  &= 0x7F;
	deviceProperty.lightStatus	  |= (deviceStatus.illumination)<<7;
	
	deviceProperty.posationStatus = deviceStatus.motorControl;
}

//publish msg should be in task not here
void do_awss_reset();
void uart_cmd_process(char* str,uint16_t strLen)
{
	OsMsgQEntry msg_evt;
	if ((ackTimeOut) && (OS_TimerIsActive(ackTimeOut))) {
		OS_TimerStop(ackTimeOut);
	}
	if (*(str) < 0x10) {
		app_uart_send("client code(heade) error!\n",strlen("client code(heade) error!\n"));
	} else {
		if (*(str+2) & 0x80) {
			if (deviceStatus.illumination != STATUS_ON) {
				deviceStatus.illumination = STATUS_ON;
				msg_evt.MsgCmd = APP_EVENT_ILLUMINATION;
				OS_MsgQEnqueue(cmdMsgQ,&msg_evt);
			}
		} else {
			if (deviceStatus.illumination != STATUS_OFF) {
				deviceStatus.illumination = STATUS_OFF;
				//xEventGroupSetBits(cmdEventGroup,APP_EVENT_ILLUMINATION);
				msg_evt.MsgCmd = APP_EVENT_ILLUMINATION;
				OS_MsgQEnqueue(cmdMsgQ,&msg_evt);
			}
		}
		if (*(str+4) & 0x80) {
			if (deviceStatus.ultravioletOnOff != STATUS_ON) {
				deviceStatus.ultravioletOnOff = STATUS_ON;
				//xEventGroupSetBits(cmdEventGroup,APP_EVENT_ULTRAVIOLET);
				msg_evt.MsgCmd = APP_EVENT_ULTRAVIOLET;
				OS_MsgQEnqueue(cmdMsgQ,&msg_evt);
			}
		} else {
			if (deviceStatus.ultravioletOnOff != STATUS_OFF) {
				deviceStatus.ultravioletOnOff = STATUS_OFF;
				//xEventGroupSetBits(cmdEventGroup,APP_EVENT_ULTRAVIOLET);
				msg_evt.MsgCmd = APP_EVENT_ULTRAVIOLET;
				OS_MsgQEnqueue(cmdMsgQ,&msg_evt);
			}
		}
		if (*(str+4) & 0x40) {
			if (deviceStatus.airDryOnOff != STATUS_ON) {
				deviceStatus.airDryOnOff = STATUS_ON;
				//xEventGroupSetBits(cmdEventGroup,APP_EVENT_AIR_DRYING);
				msg_evt.MsgCmd = APP_EVENT_AIR_DRYING;
				OS_MsgQEnqueue(cmdMsgQ,&msg_evt);
			}
		} else {
			if (deviceStatus.airDryOnOff != STATUS_OFF) {
				deviceStatus.airDryOnOff = STATUS_OFF;
				//xEventGroupSetBits(cmdEventGroup,APP_EVENT_AIR_DRYING);
				msg_evt.MsgCmd = APP_EVENT_AIR_DRYING;
				OS_MsgQEnqueue(cmdMsgQ,&msg_evt);
			}
		}
		if (*(str+4) & 0x20) {
			if (deviceStatus.drying != STATUS_ON) {
				deviceStatus.drying = STATUS_ON;
				//xEventGroupSetBits(cmdEventGroup,APP_EVENT_DRYING);
				msg_evt.MsgCmd = APP_EVENT_DRYING;
				OS_MsgQEnqueue(cmdMsgQ,&msg_evt);
			}
		} else {
			if (deviceStatus.drying != STATUS_OFF) {
				deviceStatus.drying = STATUS_OFF;
				//xEventGroupSetBits(cmdEventGroup,APP_EVENT_DRYING);
				msg_evt.MsgCmd = APP_EVENT_DRYING;
				OS_MsgQEnqueue(cmdMsgQ,&msg_evt);
			}
		}
		if ((*(str+4) & 0x01) == 0x01) {
			if (deviceStatus.motorControl != CLOTHES_POLE_UP) {
				deviceStatus.motorControl = CLOTHES_POLE_UP;
				//xEventGroupSetBits(cmdEventGroup,APP_EVENT_UP_DOWN);
				msg_evt.MsgCmd = APP_EVENT_UP_DOWN;
				OS_MsgQEnqueue(cmdMsgQ,&msg_evt);
			}
		} else if ((*(str+4) & 0x02) == 0x10) {
			if (deviceStatus.motorControl != CLOTHES_POLE_DOWN) {
				deviceStatus.motorControl = CLOTHES_POLE_DOWN;
				//xEventGroupSetBits(cmdEventGroup,APP_EVENT_UP_DOWN);
				msg_evt.MsgCmd = APP_EVENT_UP_DOWN;
				OS_MsgQEnqueue(cmdMsgQ,&msg_evt);
			}
		} else if ((*(str+4) | 0xFC) == 0xFC) {
			if (deviceStatus.motorControl != CLOTHES_POLE_STOP) {
				deviceStatus.motorControl = CLOTHES_POLE_STOP;
				//xEventGroupSetBits(cmdEventGroup,APP_EVENT_UP_DOWN);
				msg_evt.MsgCmd = APP_EVENT_UP_DOWN;
				OS_MsgQEnqueue(cmdMsgQ,&msg_evt);
			}
		}
		if ((*(str+6) & 0x08) == 0x08) {
			//aick_osal_factory_reset();
			do_awss_reset();
		}
		update_dev_local_status();
	}
}

void server_cmd_process(char* str)
{
	uint8_t *cmdPacket = NULL;
	uint8_t value = 0;
	char *pos = NULL;

	pos = strchr(str,':');
	if (pos != NULL) {
		value = *(pos + 1) - '0';
	}
	deviceProperty.posationStatus = 0xFF;
	
	if (strstr(str,ANION) != NULL) {
		deviceStatus.anionOnOff = value;
	} else if (strstr(str,ULTRAVIOLET) != NULL) {
		deviceProperty.functionStatus &= 0x7F;
		deviceProperty.functionStatus |= value<<7;
		deviceStatus.ultravioletOnOff = value;
	} else if (strstr(str,AIR_DRYING) != NULL) {
		deviceProperty.functionStatus &= 0xBF;
		if (value == 1) {
			deviceProperty.functionStatus &= 0xDF;
		}
		deviceProperty.functionStatus |= value<<6;
		deviceStatus.airDryOnOff = value;
	} else if (strstr(str,DRYING) != NULL) {
		deviceProperty.functionStatus &= 0xDF;
		if (value == 1) {
			deviceProperty.functionStatus &= 0xBF;
		}
		deviceProperty.functionStatus |= value<<5;
		deviceStatus.drying = value;
	} else if (strstr(str,ILLUMINATION) != NULL) {
		deviceProperty.lightStatus &= 0x7F;
		deviceProperty.lightStatus |= value<<7;
		//亮度这里需要再考虑下
		//deviceProperty.lightStatus |= CLOTHES_POLE_BRIGHTNESS_100;
		deviceStatus.illumination = value;
	} else if (strstr(str,UP_DOWN) != NULL) {
		if (value == 0) {
			deviceProperty.posationStatus = CLOTHES_POLE_STOP;
			deviceStatus.motorControl = CLOTHES_POLE_STOP;
		} else if (value == 1) {
			deviceProperty.posationStatus = CLOTHES_POLE_UP;
			deviceStatus.motorControl = CLOTHES_POLE_UP;
		} else if (value == 2) {
			deviceProperty.posationStatus = CLOTHES_POLE_DOWN;
			deviceStatus.motorControl = CLOTHES_POLE_DOWN;
		}
	} else {
		printf("str:%s\n",str);
		return;
	}
	
	cmdPacket = app_cmd_set_packet(deviceProperty);
	app_uart_send((char*)cmdPacket,8);
	if ((ackTimeOut) && (OS_TimerIsActive(ackTimeOut) != 1)) {
		OS_TimerSet(ackTimeOut, MCU_ACK_TIMEOUT,0,NULL);
        OS_TimerStart(ackTimeOut);
	} else {
		printf("ack timer handle is NULL or is active!\n");
	}
}

uint8_t* app_cmd_set_packet(deviceProperty_t deviceParams)
{
	static uint8_t cmdPacket[9] = {0};
	
	cmdPacket[0] = CMD_SET_USER_CODE;
	cmdPacket[1] = CMD_SET_RESERVE_CODE;
	cmdPacket[2] = deviceParams.lightStatus;
	cmdPacket[3] = deviceParams.posationStatus;
	cmdPacket[4] = deviceParams.functionStatus;
	cmdPacket[5] = deviceParams.voiceStatus;
	cmdPacket[6] = CMD_SET_APP_VERSION;
	cmdPacket[7] = CMD_SET_END_CODE;
	
	return cmdPacket;
}

void app_post_msg_task(void *arg)
{
	OsMsgQEntry appMsgEvt;
	
	if (OS_MsgQCreate(&cmdMsgQ,10) != OS_SUCCESS) {
		printf("cmd msg Q create failure!\n");
		OS_TaskDelete(NULL);
	}
	
	while(1) {
		if(OS_MsgQDequeue(cmdMsgQ,&appMsgEvt,portMAX_DELAY) == OS_SUCCESS);
		{
			switch(appMsgEvt.MsgCmd)
			{
				case APP_EVENT_ULTRAVIOLET:
					if (deviceStatus.ultravioletOnOff == STATUS_ON) 
					{
						//user_pub_msg(ULTRAVIOLET,1);
					} 
					else 
					{
						//user_pub_msg(ULTRAVIOLET,0);
			        }
					printf("cmdEvent ULTRAVIOLET!\n");
				break;

				case APP_EVENT_AIR_DRYING:
					if (deviceStatus.airDryOnOff == STATUS_ON) 
					{
						//user_pub_msg(AIR_DRYING,1);
					} 
					else 
					{
						//user_pub_msg(AIR_DRYING,0);
					}
					printf("cmdEvent AIR_DRYING!\n");
				break;

				case APP_EVENT_ANION:
					if (deviceStatus.anionOnOff == STATUS_ON) 
					{
						//user_pub_msg(ANION,1);
					} 
					else 
					{
						//user_pub_msg(ANION,0);
					}
					printf("cmdEvent ANION!\n");
				break;

				case APP_EVENT_DRYING:
					if (deviceStatus.drying == STATUS_ON) 
					{
						//user_pub_msg(DRYING,1);
					} 
					else 
					{
						//user_pub_msg(DRYING,0);
					}
					printf("cmdEvent DRYING!\n");
				break;

				case APP_EVENT_ILLUMINATION:
					if (deviceStatus.illumination == STATUS_ON) 
					{
						//user_pub_msg(ILLUMINATION,1);
					} 
					else 
					{
						//user_pub_msg(ILLUMINATION,0);
					}
					printf("cmdEvent ILLUMINATION!\n");
				break;

				case APP_EVENT_UP_DOWN:
					if (deviceStatus.motorControl == CLOTHES_POLE_UP) 
					{
						//user_pub_msg(UP_DOWN,1);
					} 
					else if (deviceStatus.motorControl == CLOTHES_POLE_DOWN) 
					{
						//user_pub_msg(UP_DOWN,2);
					} 
					else if (deviceStatus.motorControl == CLOTHES_POLE_STOP) 
					{
						//user_pub_msg(UP_DOWN,0);
					}
					printf("cmdEvent UP_DOWN!\n");
				break;

				default:
				break;
			}
		}
	}
	OS_TaskDelete(NULL);
}





































