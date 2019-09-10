#ifndef __USER_ATCMD_H__
#define __USER_ATCMD_H__



/***********************************************************************************/
//#define ANION								"anionOnOff"			//负离子
#define ULTRAVIOLET							"ultravioletOnOff"		//消毒
#define AIR_DRYING							"airDryOnOff"			//风干
#define DRYING								"drying"				//烘干
#define ILLUMINATION						"illumination"			//照明
#define UP_DOWN								"motorControl"			//上升或下降



#define CMD_SET_END_CODE					0x69
#define CMD_SET_RESERVE_CODE				0xB4
#define CMD_SET_USER_CODE					0x10
#define CMD_SET_APP_VERSION					0x01

#define APP_UART_BUF_MAX					512
#define APP_UART_RX_TIMEOUT					50



/***********************************************************************************/
typedef struct {
	uint8_t lightStatus;
	uint8_t posationStatus;
	uint8_t functionStatus;
	uint8_t voiceStatus;
}deviceProperty_t;

typedef struct {
	uint8_t anionOnOff;
	uint8_t ultravioletOnOff;
	uint8_t airDryOnOff;
	uint8_t drying;
	uint8_t illumination;
	uint8_t motorControl;
}deviceStatus_t;

typedef struct
{
   uint8_t useFlag;
   uint8_t buf[APP_UART_BUF_MAX+1];
   uint32_t recvLen;
}appUartRx_t;






/***********************************************************************************/
void server_cmd_process(char* str);
void app_components_init(void);
uint8_t user_pub_msg(char*, uint16_t);































#endif

