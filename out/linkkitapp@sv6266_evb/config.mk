AOS_SDK_MAKEFILES           		+= ./example/linkkitapp/linkkitapp.mk ./board/sv6266_evb/sv6266_evb.mk ././platform/mcu/sv6266/sv6266.mk ./kernel/vcall/vcall.mk ./kernel/init/init.mk ./out/linkkitapp@sv6266_evb/auto_component/auto_component.mk ././framework/protocol/linkkit/sdk/sdk.mk ././framework/protocol/linkkit/hal/hal.mk ././framework/netmgr/netmgr.mk ././framework/common/common.mk ././utility/cjson/cjson.mk ././framework/uOTA/uOTA.mk ./tools/cli/cli.mk ./kernel/rhino/rhino.mk ./utility/digest_algorithm/digest_algorithm.mk ./security/alicrypto/alicrypto.mk ./kernel/protocols/net/net.mk ./utility/libc/libc.mk ././platform/mcu/sv6266/sdk/components/bsp/soc/soc_init/soc_init.mk ././platform/mcu/sv6266/osal/osal.mk ././platform/mcu/sv6266/cfg/cfg.mk ././utility/log/log.mk ./framework/activation/activation.mk ./utility/chip_code/chip_code.mk ././security/imbedtls/imbedtls.mk ./kernel/modules/fs/kv/kv.mk ./kernel/yloop/yloop.mk ././kernel/hal/hal.mk ././framework/uOTA/hal/hal.mk ././framework/uOTA/src/transport/transport.mk ././framework/uOTA/src/download/download.mk ././framework/uOTA/src/verify/verify.mk ./kernel/vfs/vfs.mk ./utility/base64/base64.mk ././kernel/vfs/device/device.mk
TOOLCHAIN_NAME            		:= GCC
AOS_SDK_LDFLAGS             		+= -Wl,--gc-sections -Wl,--cref -L .//board/sv6266_evb -nostartfiles --specs=nosys.specs -mcmodel=large platform/mcu/sv6266/do_printf.o
AOS_SDK_LDS_FILES                     += platform/mcu/sv6266/ld/flash.lds.S
AOS_SDK_LDS_INCLUDES                  += 
AOS_SDK_IMG1_XIP1_LD_FILE                 += 
AOS_SDK_IMG2_XIP2_LD_FILE                 += 
RESOURCE_CFLAGS					+= -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks -DSYSINFO_APP_VERSION=\"app-1.1.0\" -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\" -DLOG_SIMPLE
AOS_SDK_LINK_SCRIPT         		+= 
AOS_SDK_LINK_SCRIPT_CMD    	 	+= 
AOS_SDK_PREBUILT_LIBRARIES 	 	+= ././platform/mcu/sv6266/lib/bootloader.a ././platform/mcu/sv6266/lib/rf_api.a ././platform/mcu/sv6266/lib/crypto.a ././platform/mcu/sv6266/lib/n10.a ././platform/mcu/sv6266/lib/sys.a ././platform/mcu/sv6266/lib/timer.a ././platform/mcu/sv6266/lib/common.a ././platform/mcu/sv6266/lib/idmanage.a ././platform/mcu/sv6266/lib/mbox.a ././platform/mcu/sv6266/lib/hwmac.a ././platform/mcu/sv6266/lib/phy.a ././platform/mcu/sv6266/lib/security.a ././platform/mcu/sv6266/lib/softmac.a ././platform/mcu/sv6266/lib/iotapi.a ././platform/mcu/sv6266/lib/udhcp.a ././platform/mcu/sv6266/lib/wdt.a ././platform/mcu/sv6266/lib/pinmux.a ././platform/mcu/sv6266/lib/netstack_wrapper.a ././platform/mcu/sv6266/lib/ali_port.a ././platform/mcu/sv6266/lib/efuseapi.a ././platform/mcu/sv6266/lib/efuse.a ././platform/mcu/sv6266/lib/tmr.a ././platform/mcu/sv6266/lib/gpio.a ././platform/mcu/sv6266/lib/drv_uart.a ././platform/mcu/sv6266/lib/lowpower.a ././platform/mcu/sv6266/lib/pwm.a ././platform/mcu/sv6266/lib/adc.a ././platform/mcu/sv6266/lib/libhsuart.a
AOS_SDK_CERTIFICATES       	 	+= 
AOS_SDK_PRE_APP_BUILDS      		+= 
AOS_SDK_LINK_FILES          		+=                                                                      
AOS_SDK_INCLUDES           	 	+=                                                                                   -I./example/linkkitapp/../../../../framework/protocol/linkkit/include -I./example/linkkitapp/../../../../framework/protocol/linkkit/include/imports -I./example/linkkitapp/../../../../framework/protocol/linkkit/include/exports -I./example/linkkitapp/./ -I./board/sv6266_evb/. -I././platform/mcu/sv6266/port -I././platform/mcu/sv6266/sdk/components/bsp/mcu/ANDES_N10 -I././platform/mcu/sv6266/sdk/components/bsp/soc/ssv6006/ASICv2 -I././platform/mcu/sv6266/sdk/components/bsp/soc/ssv6006 -I././platform/mcu/sv6266/sdk/components/osal -I././platform/mcu/sv6266/sdk/components/inc -I././platform/mcu/sv6266/sdk/components -I././platform/mcu/sv6266/sdk/components/tools/atcmd -I././platform/mcu/sv6266/sdk/components/drv/hsuart -I././platform/mcu/sv6266/sdk/components/inc/crypto -I././platform/mcu/sv6266/sdk/components/softmac -I././platform/mcu/sv6266/sdk/components/iotapi -I././platform/mcu/sv6266/sdk/components/netstack_wrapper -I././platform/mcu/sv6266/../../../kernel/protocols/net/include -I././platform/mcu/sv6266/../../../kernel/protocols/net/port/include -I././platform/mcu/sv6266/inc -I././platform/mcu/sv6266/../../../tools/cli/ -I././platform/mcu/sv6266/sdk/components/drv/rf/ -I././platform/mcu/sv6266/cfg -I././platform/mcu/sv6266/inc/custom -I./kernel/vcall/./mico/include -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/src/sdk-impl -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/src/infra/utils/digest -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/src/infra/utils -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/src/infra/utils/misc -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/src/infra/log -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/include/exports -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/include/imports -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/include -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/src/protocol/alcs -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/src/services/linkkit/dm -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/src/services/linkkit/cm -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/src/utils/misc -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/src/protocol/mqtt/Link-MQTT -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/src/protocol/mqtt -I././framework/protocol/linkkit/sdk/iotx-sdk-c_clone/src/protocol/mqtt/client -I././framework/netmgr/include -I././framework/netmgr/../protocol/alink/os/platform/ -I././utility/cjson/include -I././framework/uOTA/inc -I./tools/cli/include -I./kernel/rhino/core/include -I./kernel/rhino/uspace/include -I./kernel/rhino/debug/include -I./kernel/rhino/hal/soc -I./kernel/rhino/./ -I./utility/digest_algorithm/. -I./security/alicrypto/./libalicrypto/inc -I./kernel/protocols/net/include -I./kernel/protocols/net/port/include -I./framework/activation/. -I./utility/chip_code/. -I././security/imbedtls/include -I./kernel/modules/fs/kv/include -I././framework/uOTA/hal/. -I././framework/uOTA/hal/../inc -I././framework/uOTA/hal/../src/verify/crc -I././framework/uOTA/hal/../src/2nd_boot -I././framework/uOTA/src/transport/. -I././framework/uOTA/src/transport/../../inc -I././framework/uOTA/src/transport/../../hal -I././framework/uOTA/src/transport/../verify -I././framework/uOTA/src/transport/../verify/base64 -I././framework/uOTA/src/transport/../verify/hash -I././framework/uOTA/src/transport/../verify/rsa -I././framework/uOTA/src/download/. -I././framework/uOTA/src/download/../../inc -I././framework/uOTA/src/download/../../hal -I././framework/uOTA/src/download/../verify -I././framework/uOTA/src/verify/. -I././framework/uOTA/src/verify/../../inc -I././framework/uOTA/src/verify/../../hal -I././framework/uOTA/src/verify/../verify -I./kernel/vfs/include -I./utility/base64/. -I./include -I./example/linkkitapp
AOS_SDK_DEFINES             		+=                                                   -DBUILD_BIN -DCONFIG_AOS_CLI -DMQTT_COMM_ENABLED -DALCS_ENABLED -DMQTT_DIRECT -DDEVICE_MODEL_ENABLED -DDEV_BIND_ENABLED -DWIFI_PROVISION_ENABLED -DAWSS_SUPPORT_SMARTCONFIG -DAWSS_SUPPORT_ZEROCONFIG -DAWSS_SUPPORT_PHONEASAP -DAWSS_SUPPORT_DEV_AP -DOTA_ENABLED -DSV6266 -DXIP_MODE -DNO_ROM -DASICv2 -DCONFIG_CACHE_SUPPORT -DCONFIG_ENABLE_WDT -DSUPPORT_PARTITION_MP_TABLE -DSUPPORT_PARTITION_CFG_TABLE -DSUPPORT_PARTITION_USER_RAW -DFLASH_CTL_v2 -DCONFIG_OS_RHINO -DXTAL=40 -DSYS_BUS_SPEED=80 -DXIP_BIT=4 -DSETTING_PARTITION_MAIN_SIZE=820K -DSETTING_FLASH_TOTAL_SIZE=2M -DSETTING_PSRAM_HEAP_BASE=0 -DSETTING_PSRAM_HEAP_SIZE=0 -DCONFIG_AOS_KV_BUFFER_SIZE=8192 -DVCALL_RHINO -DAOS_NETMGR -DAOS_FRAMEWORK_COMMON -DOTA_ALIOS -DOTA_WITH_LINKKIT -DOTA_SIGNAL_CHANNEL=1 -DHAVE_NOT_ADVANCED_FORMATE -DCONFIG_ALICRYPTO -DWITH_LWIP -DCONFIG_NET_LWIP -DAOS_KV -DAOS_LOOP -DAOS_HAL -DAOS_VFS -DMCU_FAMILY=\"sv6266\"
COMPONENTS                		:= linkkitapp board_sv6266_evb sv6266 vcall kernel_init auto_component linkkit_sdk iotx-hal netmgr framework cjson ota cli rhino digest_algorithm alicrypto net newlib_stub soc_init osal cfg log activation chip_code imbedtls kv yloop hal ota_hal ota_transport ota_download ota_verify vfs base64 vfs_device
PLATFORM_DIRECTORY        		:= sv6266_evb
APP_FULL                  		:= linkkitapp
PLATFORM                  		:= sv6266_evb
HOST_MCU_FAMILY                  	:= sv6266
SUPPORT_BINS                          := no
APP                       		:= linkkitapp
HOST_OPENOCD              		:= ICEman
JTAG              		        := ICEman
HOST_ARCH                 		:= ANDES_N10
NO_BUILD_BOOTLOADER           	:= 
NO_BOOTLOADER_REQUIRED         	:= 
linkkitapp_LOCATION         := ./example/linkkitapp/
board_sv6266_evb_LOCATION         := ./board/sv6266_evb/
sv6266_LOCATION         := ././platform/mcu/sv6266/
vcall_LOCATION         := ./kernel/vcall/
kernel_init_LOCATION         := ./kernel/init/
auto_component_LOCATION         := ./out/linkkitapp@sv6266_evb/auto_component/
linkkit_sdk_LOCATION         := ././framework/protocol/linkkit/sdk/
iotx-hal_LOCATION         := ././framework/protocol/linkkit/hal/
netmgr_LOCATION         := ././framework/netmgr/
framework_LOCATION         := ././framework/common/
cjson_LOCATION         := ././utility/cjson/
ota_LOCATION         := ././framework/uOTA/
cli_LOCATION         := ./tools/cli/
rhino_LOCATION         := ./kernel/rhino/
digest_algorithm_LOCATION         := ./utility/digest_algorithm/
alicrypto_LOCATION         := ./security/alicrypto/
net_LOCATION         := ./kernel/protocols/net/
newlib_stub_LOCATION         := ./utility/libc/
soc_init_LOCATION         := ././platform/mcu/sv6266/sdk/components/bsp/soc/soc_init/
osal_LOCATION         := ././platform/mcu/sv6266/osal/
cfg_LOCATION         := ././platform/mcu/sv6266/cfg/
log_LOCATION         := ././utility/log/
activation_LOCATION         := ./framework/activation/
chip_code_LOCATION         := ./utility/chip_code/
imbedtls_LOCATION         := ././security/imbedtls/
kv_LOCATION         := ./kernel/modules/fs/kv/
yloop_LOCATION         := ./kernel/yloop/
hal_LOCATION         := ././kernel/hal/
ota_hal_LOCATION         := ././framework/uOTA/hal/
ota_transport_LOCATION         := ././framework/uOTA/src/transport/
ota_download_LOCATION         := ././framework/uOTA/src/download/
ota_verify_LOCATION         := ././framework/uOTA/src/verify/
vfs_LOCATION         := ./kernel/vfs/
base64_LOCATION         := ./utility/base64/
vfs_device_LOCATION         := ././kernel/vfs/device/
linkkitapp_SOURCES          += app_entry.c linkkit_example_solo.c 
board_sv6266_evb_SOURCES          += board.c 
sv6266_SOURCES          += aos.c hal/adc.c hal/flash_port.c hal/gpio.c hal/hw.c hal/i2c.c hal/pwm.c hal/rf_cmd.c hal/spi.c hal/uart.c hal/wifi_port.c libc_patch.c port/port_tick.c port/soc_impl.c sdk/components/net/tcpip/lwip-1.4.0/src/netif/ethernetif.c user_atcmd.c 
vcall_SOURCES          += aos/aos_rhino.c 
kernel_init_SOURCES          += aos_init.c 
auto_component_SOURCES          +=  component_init.c testcase_register.c
linkkit_sdk_SOURCES          += 
iotx-hal_SOURCES          += HAL_AWSS_rhino.c HAL_Crypt_rhino.c HAL_DTLS_mbedtls.c HAL_OS_rhino.c HAL_PRODUCT_rhino.c HAL_TCP_rhino.c HAL_TLS_mbedtls.c HAL_UDP_rhino.c infra_aes.c 
netmgr_SOURCES          += netmgr.c 
framework_SOURCES          += main.c version.c 
cjson_SOURCES          += cJSON.c cJSON_Utils.c 
ota_SOURCES          += ota_service.c 
cli_SOURCES          += cli.c dumpsys.c 
rhino_SOURCES          += common/k_fifo.c common/k_trace.c core/k_buf_queue.c core/k_dyn_mem_proc.c core/k_err.c core/k_event.c core/k_idle.c core/k_mm.c core/k_mm_blk.c core/k_mm_debug.c core/k_mutex.c core/k_obj.c core/k_pend.c core/k_queue.c core/k_ringbuf.c core/k_sched.c core/k_sem.c core/k_stats.c core/k_sys.c core/k_task.c core/k_task_sem.c core/k_tick.c core/k_time.c core/k_timer.c core/k_workqueue.c debug/k_backtrace.c debug/k_infoget.c debug/k_overview.c debug/k_panic.c 
digest_algorithm_SOURCES          += CheckSumUtils.c crc.c digest_algorithm.c md5.c 
alicrypto_SOURCES          += ./libalicrypto/ali_crypto.c ./libalicrypto/mbed/asym/rsa.c ./libalicrypto/mbed/cipher/aes.c ./libalicrypto/mbed/hash/hash.c ./libalicrypto/mbed/mac/hmac.c ./libalicrypto/sw/ali_crypto_rand.c ./mbedtls/library/aes.c ./mbedtls/library/asn1parse.c ./mbedtls/library/bignum.c ./mbedtls/library/hash_wrap.c ./mbedtls/library/hmac.c ./mbedtls/library/mbedtls_alt.c ./mbedtls/library/md5.c ./mbedtls/library/oid.c ./mbedtls/library/rsa.c ./mbedtls/library/sha1.c ./mbedtls/library/sha256.c ./mbedtls/library/threading.c 
net_SOURCES          += api/api_lib.c api/api_msg.c api/err.c api/netbuf.c api/netdb.c api/netifapi.c api/sockets.c api/tcpip.c apps/tftp/tftp_client.c apps/tftp/tftp_common.c apps/tftp/tftp_ota.c apps/tftp/tftp_server.c core/def.c core/dns.c core/inet_chksum.c core/init.c core/ip.c core/ipv4/autoip.c core/ipv4/dhcp.c core/ipv4/etharp.c core/ipv4/icmp.c core/ipv4/igmp.c core/ipv4/ip4.c core/ipv4/ip4_addr.c core/ipv4/ip4_frag.c core/ipv6/dhcp6.c core/ipv6/ethip6.c core/ipv6/icmp6.c core/ipv6/inet6.c core/ipv6/ip6.c core/ipv6/ip6_addr.c core/ipv6/ip6_frag.c core/ipv6/mld6.c core/ipv6/nd6.c core/mem.c core/memp.c core/netif.c core/pbuf.c core/raw.c core/stats.c core/sys.c core/tcp.c core/tcp_in.c core/tcp_out.c core/timeouts.c core/udp.c netif/ethernet.c netif/slipif.c port/sys_arch.c 
newlib_stub_SOURCES          += newlib_stub.c 
soc_init_SOURCES          += init_mem.c soc_init.c 
osal_SOURCES          += osal_rhino.c 
cfg_SOURCES          += mac_cfg.c sa_cfg.c user_cfg.c 
log_SOURCES          += log.c 
activation_SOURCES          += activation.c 
chip_code_SOURCES          += chip_code.c 
imbedtls_SOURCES          += src/aes.c src/aesni.c src/arc4.c src/asn1write.c src/base64.c src/bignum.c src/blowfish.c src/camellia.c src/ccm.c src/cipher.c src/cipher_wrap.c src/cmac.c src/ctr_drbg.c src/debug.c src/des.c src/dhm.c src/ecdh.c src/ecdsa.c src/ecjpake.c src/ecp.c src/ecp_curves.c src/entropy.c src/entropy_poll.c src/error.c src/gcm.c src/havege.c src/hmac_drbg.c src/mbedtls_alt.c src/mbedtls_net.c src/mbedtls_ssl.c src/md.c src/md2.c src/md4.c src/md_wrap.c src/memory_buffer_alloc.c src/net_sockets.c src/oid.c src/padlock.c src/pem.c src/pk.c src/pk_wrap.c src/pkcs11.c src/pkcs12.c src/pkcs5.c src/pkparse.c src/pkwrite.c src/platform.c src/ripemd160.c src/rsa.c src/sha512.c src/ssl_cache.c src/ssl_ciphersuites.c src/ssl_cli.c src/ssl_cookie.c src/ssl_srv.c src/ssl_ticket.c src/ssl_tls.c src/timing.c src/version.c src/version_features.c src/x509.c src/x509_create.c src/x509_crl.c src/x509_crt.c src/x509_csr.c src/x509write_crt.c src/x509write_csr.c src/xtea.c 
kv_SOURCES          += kvmgr.c 
yloop_SOURCES          += local_event.c yloop.c 
hal_SOURCES          += ota.c wifi.c 
ota_hal_SOURCES          += ota_hal_module.c ota_hal_os.c ota_hal_plat.c 
ota_transport_SOURCES          += ota_transport_mqtt.c 
ota_download_SOURCES          += ota_download_http.c 
ota_verify_SOURCES          += ota_hash.c ota_sign.c 
vfs_SOURCES          += device.c select.c vfs.c vfs_file.c vfs_inode.c vfs_register.c 
base64_SOURCES          += base64.c 
vfs_device_SOURCES          += vfs_adc.c vfs_gpio.c vfs_i2c.c vfs_pwm.c vfs_rtc.c vfs_spi.c vfs_uart.c vfs_wdg.c 
linkkitapp_CHECK_HEADERS    += 
board_sv6266_evb_CHECK_HEADERS    += 
sv6266_CHECK_HEADERS    += 
vcall_CHECK_HEADERS    += 
kernel_init_CHECK_HEADERS    += 
auto_component_CHECK_HEADERS    += 
linkkit_sdk_CHECK_HEADERS    += 
iotx-hal_CHECK_HEADERS    += 
netmgr_CHECK_HEADERS    += 
framework_CHECK_HEADERS    += 
cjson_CHECK_HEADERS    += 
ota_CHECK_HEADERS    += 
cli_CHECK_HEADERS    += 
rhino_CHECK_HEADERS    += 
digest_algorithm_CHECK_HEADERS    += 
alicrypto_CHECK_HEADERS    += 
net_CHECK_HEADERS    += 
newlib_stub_CHECK_HEADERS    += 
soc_init_CHECK_HEADERS    += 
osal_CHECK_HEADERS    += 
cfg_CHECK_HEADERS    += 
log_CHECK_HEADERS    += 
activation_CHECK_HEADERS    += 
chip_code_CHECK_HEADERS    += 
imbedtls_CHECK_HEADERS    += 
kv_CHECK_HEADERS    += 
yloop_CHECK_HEADERS    += 
hal_CHECK_HEADERS    += 
ota_hal_CHECK_HEADERS    += 
ota_transport_CHECK_HEADERS    += 
ota_download_CHECK_HEADERS    += 
ota_verify_CHECK_HEADERS    += 
vfs_CHECK_HEADERS    += 
base64_CHECK_HEADERS    += 
vfs_device_CHECK_HEADERS    += 
linkkitapp_INCLUDES         := 
board_sv6266_evb_INCLUDES         := 
sv6266_INCLUDES         := -I././platform/mcu/sv6266/sdk/components/drv
vcall_INCLUDES         := 
kernel_init_INCLUDES         := 
auto_component_INCLUDES         := 
linkkit_sdk_INCLUDES         := 
iotx-hal_INCLUDES         := 
netmgr_INCLUDES         := 
framework_INCLUDES         := 
cjson_INCLUDES         := 
ota_INCLUDES         := 
cli_INCLUDES         := 
rhino_INCLUDES         := 
digest_algorithm_INCLUDES         := 
alicrypto_INCLUDES         := -I./security/alicrypto/./mbedtls/include/mbedtls -I./security/alicrypto/./libalicrypto/mbed/inc -I./security/alicrypto/./libalicrypto/sw -I./security/alicrypto/./mbedtls/include -I./security/alicrypto/./mbedtls/include/mbedtls -I./security/alicrypto/./libalicrypto/mbed/inc -I./security/alicrypto/./libalicrypto/sw -I./security/alicrypto/./mbedtls/include
net_INCLUDES         := -I./kernel/protocols/net/port/include -I./kernel/protocols/net/port/include
newlib_stub_INCLUDES         := 
soc_init_INCLUDES         := -I././platform/mcu/sv6266/sdk/components/bsp/soc/soc_init/../../../drv -I././platform/mcu/sv6266/sdk/components/bsp/soc/soc_init/../../../drv
osal_INCLUDES         := 
cfg_INCLUDES         := -I././platform/mcu/sv6266/cfg/../sdk/components/third_party/cJSON -I././platform/mcu/sv6266/cfg/../sdk/components/sys -I././platform/mcu/sv6266/cfg/../sdk/components/drv -I././platform/mcu/sv6266/cfg/../sdk/components/tools/atcmd -I././platform/mcu/sv6266/cfg/../sdk/components/third_party/cJSON -I././platform/mcu/sv6266/cfg/../sdk/components/sys -I././platform/mcu/sv6266/cfg/../sdk/components/drv -I././platform/mcu/sv6266/cfg/../sdk/components/tools/atcmd
log_INCLUDES         := 
activation_INCLUDES         := 
chip_code_INCLUDES         := 
imbedtls_INCLUDES         := 
kv_INCLUDES         := 
yloop_INCLUDES         := 
hal_INCLUDES         := 
ota_hal_INCLUDES         := 
ota_transport_INCLUDES         := 
ota_download_INCLUDES         := 
ota_verify_INCLUDES         := 
vfs_INCLUDES         := 
base64_INCLUDES         := 
vfs_device_INCLUDES         := -I././kernel/vfs/device/../include/device/ -I././kernel/vfs/device/../include/ -I././kernel/vfs/device/../../hal/soc/ -I././kernel/vfs/device/../include/device/ -I././kernel/vfs/device/../include/ -I././kernel/vfs/device/../../hal/soc/
linkkitapp_DEFINES          := 
board_sv6266_evb_DEFINES          := 
sv6266_DEFINES          := 
vcall_DEFINES          := 
kernel_init_DEFINES          := 
auto_component_DEFINES          := 
linkkit_sdk_DEFINES          := 
iotx-hal_DEFINES          := -DINFRA_AES -DINFRA_AES_ROM_TABLES -DINFRA_AES -DINFRA_AES_ROM_TABLES
netmgr_DEFINES          := 
framework_DEFINES          := 
cjson_DEFINES          := 
ota_DEFINES          := 
cli_DEFINES          := 
rhino_DEFINES          := 
digest_algorithm_DEFINES          := 
alicrypto_DEFINES          := 
net_DEFINES          := 
newlib_stub_DEFINES          := 
soc_init_DEFINES          := 
osal_DEFINES          := 
cfg_DEFINES          := 
log_DEFINES          := 
activation_DEFINES          := 
chip_code_DEFINES          := 
imbedtls_DEFINES          := -DLWIP_ENABLED -DLWIP_ENABLED
kv_DEFINES          := 
yloop_DEFINES          := 
hal_DEFINES          := 
ota_hal_DEFINES          := 
ota_transport_DEFINES          := 
ota_download_DEFINES          := 
ota_verify_DEFINES          := 
vfs_DEFINES          := 
base64_DEFINES          := 
vfs_device_DEFINES          := 
linkkitapp_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
board_sv6266_evb_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
sv6266_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
vcall_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wall -Werror -Wall -Werror
kernel_init_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
auto_component_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
linkkit_sdk_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
iotx-hal_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
netmgr_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wall -Werror -Wall -Werror
framework_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
cjson_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
ota_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wall -Werror -Wall -Werror
cli_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wall -Werror -Wall -Werror
rhino_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wall -Werror -Wall -Werror
digest_algorithm_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
alicrypto_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -DCONFIG_CRYPT_MBED=1 -DCONFIG_DBG_CRYPT=1 -W -Wdeclaration-after-statement -D_FILE_OFFSET_BITS=64 -DCONFIG_CRYPT_MBED=1 -DCONFIG_DBG_CRYPT=1 -W -Wdeclaration-after-statement -D_FILE_OFFSET_BITS=64
net_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
newlib_stub_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
soc_init_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wno-implicit-function-declaration -Wno-implicit-function-declaration
osal_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wno-implicit-function-declaration -Wno-implicit-function-declaration
cfg_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
log_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
activation_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
chip_code_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
imbedtls_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wall -Werror -Os -Wall -Werror -Os
kv_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wall -Werror -Wall -Werror
yloop_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wall -Werror -Wall -Werror
hal_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wall -Werror -Wall -Werror
ota_hal_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wall -Werror -Wall -Werror
ota_transport_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wall -Werror -Wall -Werror
ota_download_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wall -Werror -Wall -Werror
ota_verify_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wall -Werror -Wall -Werror
vfs_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" -Wall -Werror -Wall -Werror
base64_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
vfs_device_CFLAGS           := -DCONFIG_YWSS -DBUILD_AOS -DAWSS_SUPPORT_STATIS -USYSINFO_OS_VERSION -DSYSINFO_OS_VERSION=\"\" -USYSINFO_PRODUCT_MODEL -DSYSINFO_PRODUCT_MODEL=\"ALI_AOS_SV6266_EVB\" -USYSINFO_DEVICE_NAME -DSYSINFO_DEVICE_NAME=\"SV6266_EVB\" -std=gnu99 -fgnu89-inline -Wno-format -mcpu=n10 -march=v3 -mcmodel=large -DPORTING_DEBUG -DMINIMAL_STACK_SIZE=128 -DTCPIPSTACK_EN -malign-functions -falign-functions=4 -ffunction-sections -fdata-sections -fno-builtin -Wno-attributes --short-enums -w -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable -DLWIP_NOASSERT -fno-delete-null-pointer-checks       -DSYSINFO_APP_VERSION=\"app-1.1.0\"    -DSYSINFO_KERNEL_VERSION=\"AOS-R-1.3.4\"        -DLOG_SIMPLE              -ggdb -O2 -fno-common  -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
linkkitapp_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
board_sv6266_evb_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
sv6266_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
vcall_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
kernel_init_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
auto_component_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
linkkit_sdk_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
iotx-hal_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
netmgr_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
framework_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
cjson_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
ota_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
cli_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
rhino_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
digest_algorithm_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
alicrypto_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
net_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
newlib_stub_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
soc_init_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
osal_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
cfg_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
log_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
activation_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
chip_code_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
imbedtls_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
kv_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
yloop_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
hal_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
ota_hal_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
ota_transport_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
ota_download_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
ota_verify_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
vfs_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
base64_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
vfs_device_CXXFLAGS         :=                                    -ggdb -O2 -fno-common -fno-rtti -fno-exceptions   -DAOS_SDK_VERSION_MAJOR=3 -DAOS_SDK_VERSION_MINOR=2 -DAOS_SDK_VERSION_REVISION=3 -Iout/linkkitapp@sv6266_evb/resources/ -DPLATFORM=\"sv6266_evb\" 
linkkitapp_ASMFLAGS         :=                                    -ggdb
board_sv6266_evb_ASMFLAGS         :=                                    -ggdb
sv6266_ASMFLAGS         :=                                    -ggdb
vcall_ASMFLAGS         :=                                    -ggdb
kernel_init_ASMFLAGS         :=                                    -ggdb
auto_component_ASMFLAGS         :=                                    -ggdb
linkkit_sdk_ASMFLAGS         :=                                    -ggdb
iotx-hal_ASMFLAGS         :=                                    -ggdb
netmgr_ASMFLAGS         :=                                    -ggdb
framework_ASMFLAGS         :=                                    -ggdb
cjson_ASMFLAGS         :=                                    -ggdb
ota_ASMFLAGS         :=                                    -ggdb
cli_ASMFLAGS         :=                                    -ggdb
rhino_ASMFLAGS         :=                                    -ggdb
digest_algorithm_ASMFLAGS         :=                                    -ggdb
alicrypto_ASMFLAGS         :=                                    -ggdb
net_ASMFLAGS         :=                                    -ggdb
newlib_stub_ASMFLAGS         :=                                    -ggdb
soc_init_ASMFLAGS         :=                                    -ggdb
osal_ASMFLAGS         :=                                    -ggdb
cfg_ASMFLAGS         :=                                    -ggdb
log_ASMFLAGS         :=                                    -ggdb
activation_ASMFLAGS         :=                                    -ggdb
chip_code_ASMFLAGS         :=                                    -ggdb
imbedtls_ASMFLAGS         :=                                    -ggdb
kv_ASMFLAGS         :=                                    -ggdb
yloop_ASMFLAGS         :=                                    -ggdb
hal_ASMFLAGS         :=                                    -ggdb
ota_hal_ASMFLAGS         :=                                    -ggdb
ota_transport_ASMFLAGS         :=                                    -ggdb
ota_download_ASMFLAGS         :=                                    -ggdb
ota_verify_ASMFLAGS         :=                                    -ggdb
vfs_ASMFLAGS         :=                                    -ggdb
base64_ASMFLAGS         :=                                    -ggdb
vfs_device_ASMFLAGS         :=                                    -ggdb
linkkitapp_RESOURCES        := 
board_sv6266_evb_RESOURCES        := 
sv6266_RESOURCES        := 
vcall_RESOURCES        := 
kernel_init_RESOURCES        := 
auto_component_RESOURCES        := 
linkkit_sdk_RESOURCES        := 
iotx-hal_RESOURCES        := 
netmgr_RESOURCES        := 
framework_RESOURCES        := 
cjson_RESOURCES        := 
ota_RESOURCES        := 
cli_RESOURCES        := 
rhino_RESOURCES        := 
digest_algorithm_RESOURCES        := 
alicrypto_RESOURCES        := 
net_RESOURCES        := 
newlib_stub_RESOURCES        := 
soc_init_RESOURCES        := 
osal_RESOURCES        := 
cfg_RESOURCES        := 
log_RESOURCES        := 
activation_RESOURCES        := 
chip_code_RESOURCES        := 
imbedtls_RESOURCES        := 
kv_RESOURCES        := 
yloop_RESOURCES        := 
hal_RESOURCES        := 
ota_hal_RESOURCES        := 
ota_transport_RESOURCES        := 
ota_download_RESOURCES        := 
ota_verify_RESOURCES        := 
vfs_RESOURCES        := 
base64_RESOURCES        := 
vfs_device_RESOURCES        := 
linkkitapp_MAKEFILE         := ./example/linkkitapp/linkkitapp.mk
board_sv6266_evb_MAKEFILE         := ./board/sv6266_evb/sv6266_evb.mk
sv6266_MAKEFILE         := ././platform/mcu/sv6266/sv6266.mk
vcall_MAKEFILE         := ./kernel/vcall/vcall.mk
kernel_init_MAKEFILE         := ./kernel/init/init.mk
auto_component_MAKEFILE         := ./out/linkkitapp@sv6266_evb/auto_component/auto_component.mk
linkkit_sdk_MAKEFILE         := ././framework/protocol/linkkit/sdk/sdk.mk
iotx-hal_MAKEFILE         := ././framework/protocol/linkkit/hal/hal.mk
netmgr_MAKEFILE         := ././framework/netmgr/netmgr.mk
framework_MAKEFILE         := ././framework/common/common.mk
cjson_MAKEFILE         := ././utility/cjson/cjson.mk
ota_MAKEFILE         := ././framework/uOTA/uOTA.mk
cli_MAKEFILE         := ./tools/cli/cli.mk
rhino_MAKEFILE         := ./kernel/rhino/rhino.mk
digest_algorithm_MAKEFILE         := ./utility/digest_algorithm/digest_algorithm.mk
alicrypto_MAKEFILE         := ./security/alicrypto/alicrypto.mk
net_MAKEFILE         := ./kernel/protocols/net/net.mk
newlib_stub_MAKEFILE         := ./utility/libc/libc.mk
soc_init_MAKEFILE         := ././platform/mcu/sv6266/sdk/components/bsp/soc/soc_init/soc_init.mk
osal_MAKEFILE         := ././platform/mcu/sv6266/osal/osal.mk
cfg_MAKEFILE         := ././platform/mcu/sv6266/cfg/cfg.mk
log_MAKEFILE         := ././utility/log/log.mk
activation_MAKEFILE         := ./framework/activation/activation.mk
chip_code_MAKEFILE         := ./utility/chip_code/chip_code.mk
imbedtls_MAKEFILE         := ././security/imbedtls/imbedtls.mk
kv_MAKEFILE         := ./kernel/modules/fs/kv/kv.mk
yloop_MAKEFILE         := ./kernel/yloop/yloop.mk
hal_MAKEFILE         := ././kernel/hal/hal.mk
ota_hal_MAKEFILE         := ././framework/uOTA/hal/hal.mk
ota_transport_MAKEFILE         := ././framework/uOTA/src/transport/transport.mk
ota_download_MAKEFILE         := ././framework/uOTA/src/download/download.mk
ota_verify_MAKEFILE         := ././framework/uOTA/src/verify/verify.mk
vfs_MAKEFILE         := ./kernel/vfs/vfs.mk
base64_MAKEFILE         := ./utility/base64/base64.mk
vfs_device_MAKEFILE         := ././kernel/vfs/device/device.mk
linkkitapp_PRE_BUILD_TARGETS:= 
board_sv6266_evb_PRE_BUILD_TARGETS:= 
sv6266_PRE_BUILD_TARGETS:= 
vcall_PRE_BUILD_TARGETS:= 
kernel_init_PRE_BUILD_TARGETS:= 
auto_component_PRE_BUILD_TARGETS:= 
linkkit_sdk_PRE_BUILD_TARGETS:= 
iotx-hal_PRE_BUILD_TARGETS:= 
netmgr_PRE_BUILD_TARGETS:= 
framework_PRE_BUILD_TARGETS:= 
cjson_PRE_BUILD_TARGETS:= 
ota_PRE_BUILD_TARGETS:= 
cli_PRE_BUILD_TARGETS:= 
rhino_PRE_BUILD_TARGETS:= 
digest_algorithm_PRE_BUILD_TARGETS:= 
alicrypto_PRE_BUILD_TARGETS:= 
net_PRE_BUILD_TARGETS:= 
newlib_stub_PRE_BUILD_TARGETS:= 
soc_init_PRE_BUILD_TARGETS:= 
osal_PRE_BUILD_TARGETS:= 
cfg_PRE_BUILD_TARGETS:= 
log_PRE_BUILD_TARGETS:= 
activation_PRE_BUILD_TARGETS:= 
chip_code_PRE_BUILD_TARGETS:= 
imbedtls_PRE_BUILD_TARGETS:= 
kv_PRE_BUILD_TARGETS:= 
yloop_PRE_BUILD_TARGETS:= 
hal_PRE_BUILD_TARGETS:= 
ota_hal_PRE_BUILD_TARGETS:= 
ota_transport_PRE_BUILD_TARGETS:= 
ota_download_PRE_BUILD_TARGETS:= 
ota_verify_PRE_BUILD_TARGETS:= 
vfs_PRE_BUILD_TARGETS:= 
base64_PRE_BUILD_TARGETS:= 
vfs_device_PRE_BUILD_TARGETS:= 
linkkitapp_PREBUILT_LIBRARY := 
board_sv6266_evb_PREBUILT_LIBRARY := 
sv6266_PREBUILT_LIBRARY := ././platform/mcu/sv6266/lib/bootloader.a ././platform/mcu/sv6266/lib/rf_api.a ././platform/mcu/sv6266/lib/crypto.a ././platform/mcu/sv6266/lib/n10.a ././platform/mcu/sv6266/lib/sys.a ././platform/mcu/sv6266/lib/timer.a ././platform/mcu/sv6266/lib/common.a ././platform/mcu/sv6266/lib/idmanage.a ././platform/mcu/sv6266/lib/mbox.a ././platform/mcu/sv6266/lib/hwmac.a ././platform/mcu/sv6266/lib/phy.a ././platform/mcu/sv6266/lib/security.a ././platform/mcu/sv6266/lib/softmac.a ././platform/mcu/sv6266/lib/iotapi.a ././platform/mcu/sv6266/lib/udhcp.a ././platform/mcu/sv6266/lib/wdt.a ././platform/mcu/sv6266/lib/pinmux.a ././platform/mcu/sv6266/lib/netstack_wrapper.a ././platform/mcu/sv6266/lib/ali_port.a ././platform/mcu/sv6266/lib/efuseapi.a ././platform/mcu/sv6266/lib/efuse.a ././platform/mcu/sv6266/lib/tmr.a ././platform/mcu/sv6266/lib/gpio.a ././platform/mcu/sv6266/lib/drv_uart.a ././platform/mcu/sv6266/lib/lowpower.a ././platform/mcu/sv6266/lib/pwm.a ././platform/mcu/sv6266/lib/adc.a ././platform/mcu/sv6266/lib/libhsuart.a
vcall_PREBUILT_LIBRARY := 
kernel_init_PREBUILT_LIBRARY := 
auto_component_PREBUILT_LIBRARY := 
linkkit_sdk_PREBUILT_LIBRARY := 
iotx-hal_PREBUILT_LIBRARY := 
netmgr_PREBUILT_LIBRARY := 
framework_PREBUILT_LIBRARY := 
cjson_PREBUILT_LIBRARY := 
ota_PREBUILT_LIBRARY := 
cli_PREBUILT_LIBRARY := 
rhino_PREBUILT_LIBRARY := 
digest_algorithm_PREBUILT_LIBRARY := 
alicrypto_PREBUILT_LIBRARY := 
net_PREBUILT_LIBRARY := 
newlib_stub_PREBUILT_LIBRARY := 
soc_init_PREBUILT_LIBRARY := 
osal_PREBUILT_LIBRARY := 
cfg_PREBUILT_LIBRARY := 
log_PREBUILT_LIBRARY := 
activation_PREBUILT_LIBRARY := 
chip_code_PREBUILT_LIBRARY := 
imbedtls_PREBUILT_LIBRARY := 
kv_PREBUILT_LIBRARY := 
yloop_PREBUILT_LIBRARY := 
hal_PREBUILT_LIBRARY := 
ota_hal_PREBUILT_LIBRARY := 
ota_transport_PREBUILT_LIBRARY := 
ota_download_PREBUILT_LIBRARY := 
ota_verify_PREBUILT_LIBRARY := 
vfs_PREBUILT_LIBRARY := 
base64_PREBUILT_LIBRARY := 
vfs_device_PREBUILT_LIBRARY := 
linkkitapp_TYPE             := 
board_sv6266_evb_TYPE             := kernel
sv6266_TYPE             := kernel
vcall_TYPE             := kernel
kernel_init_TYPE             := kernel
auto_component_TYPE             := kernel
linkkit_sdk_TYPE             := 
iotx-hal_TYPE             := 
netmgr_TYPE             := framework
framework_TYPE             := framework
cjson_TYPE             := share
ota_TYPE             := 
cli_TYPE             := kernel
rhino_TYPE             := kernel
digest_algorithm_TYPE             := share
alicrypto_TYPE             := 
net_TYPE             := kernel
newlib_stub_TYPE             := share
soc_init_TYPE             := 
osal_TYPE             := 
cfg_TYPE             := 
log_TYPE             := share
activation_TYPE             := 
chip_code_TYPE             := 
imbedtls_TYPE             := 
kv_TYPE             := kernel
yloop_TYPE             := kernel
hal_TYPE             := kernel
ota_hal_TYPE             := 
ota_transport_TYPE             := 
ota_download_TYPE             := 
ota_verify_TYPE             := 
vfs_TYPE             := kernel
base64_TYPE             := share
vfs_device_TYPE             := 
linkkitapp_SELF_BUIlD_COMP_targets  := 
board_sv6266_evb_SELF_BUIlD_COMP_targets  := 
sv6266_SELF_BUIlD_COMP_targets  := 
vcall_SELF_BUIlD_COMP_targets  := 
kernel_init_SELF_BUIlD_COMP_targets  := 
auto_component_SELF_BUIlD_COMP_targets  := 
linkkit_sdk_SELF_BUIlD_COMP_targets  := output/release/lib/libiot_sdk.a
iotx-hal_SELF_BUIlD_COMP_targets  := 
netmgr_SELF_BUIlD_COMP_targets  := 
framework_SELF_BUIlD_COMP_targets  := 
cjson_SELF_BUIlD_COMP_targets  := 
ota_SELF_BUIlD_COMP_targets  := 
cli_SELF_BUIlD_COMP_targets  := 
rhino_SELF_BUIlD_COMP_targets  := 
digest_algorithm_SELF_BUIlD_COMP_targets  := 
alicrypto_SELF_BUIlD_COMP_targets  := 
net_SELF_BUIlD_COMP_targets  := 
newlib_stub_SELF_BUIlD_COMP_targets  := 
soc_init_SELF_BUIlD_COMP_targets  := 
osal_SELF_BUIlD_COMP_targets  := 
cfg_SELF_BUIlD_COMP_targets  := 
log_SELF_BUIlD_COMP_targets  := 
activation_SELF_BUIlD_COMP_targets  := 
chip_code_SELF_BUIlD_COMP_targets  := 
imbedtls_SELF_BUIlD_COMP_targets  := 
kv_SELF_BUIlD_COMP_targets  := 
yloop_SELF_BUIlD_COMP_targets  := 
hal_SELF_BUIlD_COMP_targets  := 
ota_hal_SELF_BUIlD_COMP_targets  := 
ota_transport_SELF_BUIlD_COMP_targets  := 
ota_download_SELF_BUIlD_COMP_targets  := 
ota_verify_SELF_BUIlD_COMP_targets  := 
vfs_SELF_BUIlD_COMP_targets  := 
base64_SELF_BUIlD_COMP_targets  := 
vfs_device_SELF_BUIlD_COMP_targets  := 
linkkitapp_SELF_BUIlD_COMP_scripts  := 
board_sv6266_evb_SELF_BUIlD_COMP_scripts  := 
sv6266_SELF_BUIlD_COMP_scripts  := 
vcall_SELF_BUIlD_COMP_scripts  := 
kernel_init_SELF_BUIlD_COMP_scripts  := 
auto_component_SELF_BUIlD_COMP_scripts  := 
linkkit_sdk_SELF_BUIlD_COMP_scripts  := iotx_sdk_make.sh
iotx-hal_SELF_BUIlD_COMP_scripts  := 
netmgr_SELF_BUIlD_COMP_scripts  := 
framework_SELF_BUIlD_COMP_scripts  := 
cjson_SELF_BUIlD_COMP_scripts  := 
ota_SELF_BUIlD_COMP_scripts  := 
cli_SELF_BUIlD_COMP_scripts  := 
rhino_SELF_BUIlD_COMP_scripts  := 
digest_algorithm_SELF_BUIlD_COMP_scripts  := 
alicrypto_SELF_BUIlD_COMP_scripts  := 
net_SELF_BUIlD_COMP_scripts  := 
newlib_stub_SELF_BUIlD_COMP_scripts  := 
soc_init_SELF_BUIlD_COMP_scripts  := 
osal_SELF_BUIlD_COMP_scripts  := 
cfg_SELF_BUIlD_COMP_scripts  := 
log_SELF_BUIlD_COMP_scripts  := 
activation_SELF_BUIlD_COMP_scripts  := 
chip_code_SELF_BUIlD_COMP_scripts  := 
imbedtls_SELF_BUIlD_COMP_scripts  := 
kv_SELF_BUIlD_COMP_scripts  := 
yloop_SELF_BUIlD_COMP_scripts  := 
hal_SELF_BUIlD_COMP_scripts  := 
ota_hal_SELF_BUIlD_COMP_scripts  := 
ota_transport_SELF_BUIlD_COMP_scripts  := 
ota_download_SELF_BUIlD_COMP_scripts  := 
ota_verify_SELF_BUIlD_COMP_scripts  := 
vfs_SELF_BUIlD_COMP_scripts  := 
base64_SELF_BUIlD_COMP_scripts  := 
vfs_device_SELF_BUIlD_COMP_scripts  := 
AOS_SDK_UNIT_TEST_SOURCES   		:=                                                                      
ALL_RESOURCES             		:= 
INTERNAL_MEMORY_RESOURCES 		:= 
EXTRA_TARGET_MAKEFILES 			:=    .//platform/mcu/sv6266/gen_crc_bin.mk
APPS_START_SECTOR 				:=  
BOOTLOADER_FIRMWARE				:=  
ATE_FIRMWARE				        :=  
APPLICATION_FIRMWARE				:=  
PARAMETER_1_IMAGE					:=  
PARAMETER_2_IMAGE					:=  
FILESYSTEM_IMAGE					:=  
WIFI_FIRMWARE						:=  
BT_PATCH_FIRMWARE					:=  
AOS_ROM_SYMBOL_LIST_FILE 		:= 
AOS_SDK_CHIP_SPECIFIC_SCRIPT		:=                                   
AOS_SDK_CONVERTER_OUTPUT_FILE	:=                                   
AOS_SDK_FINAL_OUTPUT_FILE 		:=                                   
AOS_RAM_STUB_LIST_FILE 			:= 
PING_PONG_OTA 					:= 
