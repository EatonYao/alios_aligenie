/*
 * Copyright (C) 2015-2018 Alibaba Group Holding Limited
 */

#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "iot_export.h"
#include "utils_hmac.h"
#include "iotx_utils.h"
#include "iotx_log.h"
#include "iot_export_http2.h"
#include "iot_export_http2_stream.h"
#include "lite-list.h"

#define HTTP2_STREAM_MALLOC(size) LITE_malloc(size, MEM_MAGIC, "http2.stream")
#define HTTP2_STREAM_FREE(ptr)    LITE_free(ptr)

#define URL_MAX_LEN                     (100)

#define h2stream_err(...)               log_err("h2stream", __VA_ARGS__)
#define h2stream_warning(...)           log_warning("h2stream", __VA_ARGS__)
#define h2stream_info(...)              log_info("h2stream", __VA_ARGS__)
#define h2stream_debug(...)             log_debug("h2stream", __VA_ARGS__)

typedef enum {
    NUM_STRING_ENUM      = 0,
    PATH_CREATE_STR_ENUM = 1,
    PATH_UPLOAD_STR_ENUM = 2,
    CID_STRING_ENUM      = 3,
    ORI_SIGN_STR_ENUM    = 4,
    FS_STRING_ENUM       = 5,
    REAL_SIGN_STR_ENUM   = 6,
} HEADER_TYPE_ENUM;


typedef struct _device_info_struct_ {
    char        product_key[PRODUCT_KEY_LEN + 1];
    char        device_name[DEVICE_NAME_LEN + 1];
    char        device_secret[DEVICE_SECRET_LEN + 1];
    char        url[URL_MAX_LEN + 1];
    int         port;
} device_info;

typedef struct {
    http2_connection_t   *http2_connect;
    void                 *mutex;
    void                 *semaphore;
    void                 *rw_thread;
    http2_list_t         stream_list;
    int                  init_state;
    http2_stream_cb_t    *cbs;
#ifdef FS_ENABLED
    http2_list_t         file_list;
    void                 *file_thread;
#endif
    uint8_t              connect_state;
    uint8_t              retry_cnt;
} stream_handle_t;

typedef struct {
    unsigned int stream_id;         /* http2 protocol stream id */
    char *channel_id;               /* string return by server to identify a specific stream channel, different from stream identifier which is a field in http2 frame */
    stream_type_t stream_type;      /* check @stream_type_t */
    void *semaphore;                /* semaphore for http2 response sync */
    char status_code[5];            /* http2 response status code */
    uint8_t  rcv_hd_cnt;            /* the number of concerned heads received*/
    void     *user_data;            /* data passed to the stream callback function */
    http2_list_t list;              /* list_head */
} http2_stream_node_t;

static device_info g_device_info;

static stream_handle_t *g_stream_handle = NULL;
static httpclient_t g_client;

static int _set_device_info(device_conn_info_t *device_info)
{
    memset(g_device_info.product_key, 0, PRODUCT_KEY_LEN + 1);
    memset(g_device_info.device_name, 0, DEVICE_NAME_LEN + 1);
    memset(g_device_info.device_secret, 0, DEVICE_SECRET_LEN + 1);
    memset(g_device_info.url, 0, URL_MAX_LEN + 1);

    strncpy(g_device_info.product_key, device_info->product_key, PRODUCT_KEY_LEN);
    strncpy(g_device_info.device_name, device_info->device_name, DEVICE_NAME_LEN);
    strncpy(g_device_info.device_secret, device_info->device_secret, DEVICE_SECRET_LEN);
    if(device_info->url != NULL) {
        strncpy(g_device_info.url, device_info->url, URL_MAX_LEN);
    }
    g_device_info.port = device_info->port;

    return 0;
}



static int http2_nv_copy(http2_header *nva, int start, http2_header *nva_copy, int num)
{
    int i, j;
    for (i = start, j = 0; j < num; i++, j++) {
        nva[i].name = nva_copy[j].name;
        nva[i].value = nva_copy[j].value;
        nva[i].namelen = nva_copy[j].namelen;
        nva[i].valuelen = nva_copy[j].valuelen;
    }
    return i;
}

static int iotx_http2_get_url(char *buf, char *productkey)
{
    if (strlen(g_device_info.url) != 0) {
        strncpy(buf, g_device_info.url, URL_MAX_LEN);
        return g_device_info.port;
    }
#if defined(ON_DAILY)
    sprintf(buf, "%s", "10.101.12.205");
    return 9999;
#elif defined(ON_PRE)
    sprintf(buf, "%s", "100.67.141.158");
    return 8443;
#else
    sprintf(buf, "%s", productkey);
    strcat(buf, ".iot-as-http2.cn-shanghai.aliyuncs.com");
    return 443;
#endif
}

static void file_upload_gen_string(char *str, int type, char *para1, int para2)
{
    switch (type) {
    case NUM_STRING_ENUM: {
        sprintf(str, "%d", para2);
        break;
    }
    case PATH_CREATE_STR_ENUM:
    case PATH_UPLOAD_STR_ENUM:
    case ORI_SIGN_STR_ENUM:
    case CID_STRING_ENUM: {
        if (type == PATH_CREATE_STR_ENUM) {
            sprintf(str, "/message/pub_with_resp/sys/%s/%s/thing/%s/create",
                    g_device_info.product_key,
                    g_device_info.device_name,
                    para1);
        } else if (type == PATH_UPLOAD_STR_ENUM) {
            sprintf(str, "/message/pub_with_resp/sys/%s/%s/thing/%s/upload",
                    g_device_info.product_key,
                    g_device_info.device_name,
                    para1);
        } else if (type == ORI_SIGN_STR_ENUM) {
            sprintf(str, "clientId%sdeviceName%sproductKey%s",
                    para1,
                    g_device_info.device_name,
                    g_device_info.product_key);
        } else {
            sprintf(str, "%s.%s", g_device_info.product_key, g_device_info.device_name);
        }
        break;
    }
    case REAL_SIGN_STR_ENUM: {
        utils_hmac_sha1(para1, strlen(para1), str, g_device_info.device_secret, strlen(g_device_info.device_secret));
        break;
    }
    default: {
        h2stream_err("ASSERT\n");
        break;
    }
    }
}

static int http2_stream_node_search(stream_handle_t *handle, unsigned int stream_id, http2_stream_node_t **p_node)
{
    *p_node = NULL;

    POINTER_SANITY_CHECK(handle, NULL_VALUE_ERROR);
    POINTER_SANITY_CHECK(p_node, NULL_VALUE_ERROR);

    http2_stream_node_t *search_node = NULL;
    list_for_each_entry(search_node, &handle->stream_list, list, http2_stream_node_t) {
        if (search_node->stream_id == stream_id) {
            *p_node = search_node;
            return SUCCESS_RETURN;
        }
    }

    h2stream_debug("stream node not exist, stream_id = %d", stream_id);
    return FAIL_RETURN;
}

static void on_stream_header(int32_t stream_id, int cat, const uint8_t *name, uint32_t namelen,
                             const uint8_t *value, uint32_t valuelen, uint8_t flags)
{
    http2_stream_node_t *node = NULL;

    if (g_stream_handle == NULL) {
        return;
    }
    http2_stream_node_search(g_stream_handle, stream_id, &node);
    if (node == NULL) {
        return;
    }

    switch (cat) {
    case 0x01:
        if (strncmp((char *)name, "x-data-stream-id", (int)namelen) == 0) {
            node->channel_id = HTTP2_STREAM_MALLOC(valuelen + 1);
            if (node->channel_id == NULL) {
                return;
            }
            memset(node->channel_id, 0, (int)valuelen + 1);
            memcpy(node->channel_id, (char *)value, (int)valuelen);
            if (++node->rcv_hd_cnt == 2) {
                HAL_SemaphorePost(node->semaphore);
            }
        } else if (strncmp((char *)name, ":status", (int)namelen) == 0) {
            strncpy(node->status_code, (char *)value, sizeof(node->status_code) - 1);
            if (++node->rcv_hd_cnt == 2) {
                HAL_SemaphorePost(node->semaphore);
            }
        }
    }

    if (g_stream_handle->cbs && g_stream_handle->cbs->on_stream_header_cb) {
        g_stream_handle->cbs->on_stream_header_cb(node->stream_id, node->channel_id, cat, name, namelen, value, valuelen,
                flags, node->user_data);
    }
}

static void on_stream_chunk_recv(int32_t stream_id, const uint8_t *data, uint32_t len, uint8_t flags)
{
    http2_stream_node_t *node;
    if (g_stream_handle == NULL) {
        return;
    }
    http2_stream_node_search(g_stream_handle, stream_id, &node);
    if (node == NULL) {
        return;
    }

    if (g_stream_handle->cbs && g_stream_handle->cbs->on_stream_chunk_recv_cb) {
        g_stream_handle->cbs->on_stream_chunk_recv_cb(node->stream_id, node->channel_id, data, len, flags, node->user_data);
    }
}

static void on_stream_close(int32_t stream_id, uint32_t error_code)
{
    http2_stream_node_t *node;
    if (g_stream_handle == NULL) {
        return;
    }
    http2_stream_node_search(g_stream_handle, stream_id, &node);
    if (node == NULL) {
        return;
    }
    if (g_stream_handle->cbs && g_stream_handle->cbs->on_stream_close_cb) {
        g_stream_handle->cbs->on_stream_close_cb(node->stream_id, node->channel_id, error_code,node->user_data);
    }
}

static  void on_stream_frame_send(int32_t stream_id, int type, uint8_t flags)
{
    http2_stream_node_t *node;
    if (g_stream_handle == NULL) {
        return;
    }
    http2_stream_node_search(g_stream_handle, stream_id, &node);
    if (node == NULL) {
        return;
    }
    if (g_stream_handle->cbs && g_stream_handle->cbs->on_stream_frame_send_cb) {
        g_stream_handle->cbs->on_stream_frame_send_cb(node->stream_id,node->channel_id, type, flags,node->user_data);
    }
}

static void on_stream_frame_recv(int32_t stream_id, int type, uint8_t flags)
{
    http2_stream_node_t *node;
    if (g_stream_handle == NULL) {
        return;
    }
    http2_stream_node_search(g_stream_handle, stream_id, &node);
    if (node == NULL) {
        return;
    }

    if (g_stream_handle->cbs && g_stream_handle->cbs->on_stream_frame_recv_cb) {
        g_stream_handle->cbs->on_stream_frame_recv_cb(node->stream_id,node->channel_id, type, flags,node->user_data);
    }
}

static http2_user_cb_t my_cb = {
    .on_user_header_cb = on_stream_header,
    .on_user_chunk_recv_cb = on_stream_chunk_recv,
    .on_user_stream_close_cb = on_stream_close,
    .on_user_frame_send_cb = on_stream_frame_send,
    .on_user_frame_recv_cb = on_stream_frame_recv,
};

static int  reconnect(stream_handle_t *handle)
{
    char buf[100] = {0};
    http2_connection_t *conn = NULL;

    iotx_http2_client_disconnect(handle->http2_connect);
    handle->http2_connect = NULL;
    int port = iotx_http2_get_url(buf, g_device_info.product_key);
    conn = iotx_http2_client_connect_with_cb((void *)&g_client, buf, port, &my_cb);
    if (conn == NULL) {
        return -1;
    }
    handle->http2_connect = conn;
    return 0;
}

static void *http2_io(void *user_data)
{
    stream_handle_t *handle = (stream_handle_t *)user_data;
    int rv = 0;
    POINTER_SANITY_CHECK(handle, NULL);
    iotx_time_t timer;
    iotx_time_init(&timer);
    while (handle->init_state) {
        if (handle->connect_state) {
            HAL_MutexLock(handle->mutex);
            rv = iotx_http2_exec_io(handle->http2_connect);
            HAL_MutexUnlock(handle->mutex);
        }
        if (utils_time_is_expired(&timer) && handle->connect_state) {
            HAL_MutexLock(handle->mutex);
            rv = iotx_http2_client_send_ping(handle->http2_connect);
            HAL_MutexUnlock(handle->mutex);
            utils_time_countdown_ms(&timer, IOT_HTTP2_KEEP_ALIVE_TIME);
        }

        if (rv < 0) {
            if (handle->retry_cnt == IOT_HTTP2_KEEP_ALIVE_CNT - 1) {
                h2stream_info("rv =%d, try reconnect\n", rv);
                if (handle->connect_state != 0) {
                    handle->connect_state = 0;
                    if (handle->cbs && handle->cbs->on_disconnect_cb) {
                        handle->cbs->on_disconnect_cb();
                    }
                }
                rv = reconnect(handle);
                continue;
            } else {
                handle->retry_cnt++;
            }
        } else {
            if (handle->connect_state == 0) {
                handle->connect_state = 1;
                handle->retry_cnt = 0;
                if (handle->cbs && handle->cbs->on_reconnect_cb) {
                    handle->cbs->on_reconnect_cb();
                }
            }
        }
        HAL_SleepMs(100);
    }
    HAL_SemaphorePost(handle->semaphore);

    return NULL;
}

static int http2_stream_node_insert(stream_handle_t *handle, unsigned int id, void *user_data, http2_stream_node_t **p_node)
{
    http2_stream_node_t *node = NULL;
    void *semaphore = NULL;

    POINTER_SANITY_CHECK(handle, NULL_VALUE_ERROR);

    ARGUMENT_SANITY_CHECK(id != 0, FAIL_RETURN);

    if (p_node != NULL) {
        *p_node = NULL;
    }

    node = (http2_stream_node_t *)HTTP2_STREAM_MALLOC(sizeof(http2_stream_node_t));
    if (node == NULL) {
        return FAIL_RETURN;
    }

    memset(node, 0, sizeof(http2_stream_node_t));
    node->stream_id = id;
    node->user_data = user_data;
    semaphore = HAL_SemaphoreCreate();
    if (semaphore == NULL) {
        HTTP2_STREAM_FREE(node);
        return FAIL_RETURN;
    }
    node->semaphore = semaphore;

    INIT_LIST_HEAD((list_head_t *)&node->list);
    list_add((list_head_t *)&node->list, (list_head_t *)&handle->stream_list);

    if (p_node != NULL) {
        *p_node = node;
    }

    return SUCCESS_RETURN;
}

static int http2_stream_node_remove(stream_handle_t *handle, unsigned int id)
{
    http2_stream_node_t *search_node;

    POINTER_SANITY_CHECK(handle, NULL_VALUE_ERROR);
    ARGUMENT_SANITY_CHECK(id != 0, FAIL_RETURN);

    list_for_each_entry(search_node, &handle->stream_list, list, http2_stream_node_t) {
        if (id == search_node->stream_id) {
            h2stream_info("stream_node found, delete\n");

            list_del((list_head_t *)&search_node->list);
            HTTP2_STREAM_FREE(search_node->channel_id);
            HAL_SemaphoreDestroy(search_node->semaphore);
            HTTP2_STREAM_FREE(search_node);
            return SUCCESS_RETURN;
        }
    }
    return FAIL_RETURN;
}

static int get_version_int()
{
    const char *p_version = LINKKIT_VERSION;
    int v_int = 0;

    while (*p_version != 0) {
        if (*p_version <= '9' && *p_version >= '0') {
            v_int = v_int * 10 + *p_version - '0';
        }
        p_version ++;
    }
    return v_int;
}

void *IOT_HTTP2_Connect(device_conn_info_t *conn_info, http2_stream_cb_t *user_cb)
{
    stream_handle_t *stream_handle = NULL;
    http2_connection_t *conn = NULL;
    char buf[URL_MAX_LEN + 1] = {0};
    int port = 0;
    int ret = 0;

    POINTER_SANITY_CHECK(conn_info, NULL);
    POINTER_SANITY_CHECK(conn_info->product_key, NULL);
    POINTER_SANITY_CHECK(conn_info->device_name, NULL);
    POINTER_SANITY_CHECK(conn_info->device_secret, NULL);

    memset(&g_client, 0, sizeof(httpclient_t));

    stream_handle = HTTP2_STREAM_MALLOC(sizeof(stream_handle_t));
    if (stream_handle == NULL) {
        return NULL;
    }

    memset(stream_handle, 0, sizeof(stream_handle_t));
    stream_handle->mutex = HAL_MutexCreate();
    if (stream_handle->mutex == NULL) {
        HTTP2_STREAM_FREE(stream_handle);
        h2stream_err("mutex create error\n");
        return NULL;
    }
    stream_handle->semaphore = HAL_SemaphoreCreate();
    if (stream_handle->semaphore == NULL) {
        h2stream_err("semaphore create error\n");
        HAL_MutexDestroy(stream_handle->mutex);
        HTTP2_STREAM_FREE(stream_handle);
        return NULL;
    }

    INIT_LIST_HEAD((list_head_t *) & (stream_handle->stream_list));
#ifdef FS_ENABLED
    INIT_LIST_HEAD((list_head_t *) & (stream_handle->file_list));
#endif

    _set_device_info(conn_info);
    g_stream_handle = stream_handle;
    g_stream_handle->cbs = user_cb;

    port = iotx_http2_get_url(buf, conn_info->product_key);
    conn = iotx_http2_client_connect_with_cb((void *)&g_client, buf, port, &my_cb);
    if (conn == NULL) {
        HAL_MutexDestroy(stream_handle->mutex);
        HAL_SemaphoreDestroy(stream_handle->semaphore);
        HTTP2_STREAM_FREE(stream_handle);
        return NULL;
    }
    stream_handle->http2_connect = conn;
    stream_handle->init_state = 1;

    hal_os_thread_param_t thread_parms = {0};
    thread_parms.stack_size = 6144;
    thread_parms.name = "http2_io";
    ret = HAL_ThreadCreate(&stream_handle->rw_thread, http2_io, stream_handle, &thread_parms, NULL);
    if (ret != 0) {
        h2stream_err("thread create error\n");
        IOT_HTTP2_Disconnect(stream_handle);
        return NULL;
    }
    HAL_ThreadDetach(stream_handle->rw_thread);
    return stream_handle;
}

int IOT_HTTP2_Stream_Open(void *hd, stream_data_info_t *info, header_ext_info_t *header)
{
    char client_id[64 + 1] = {0};
    char sign_str[256 + 1] = {0};
    char sign[41 + 1] = {0};
    char path[128] = {0};
    int header_count = 0;
    int header_num;
    int rv = 0;
    http2_data h2_data;
    http2_stream_node_t *node = NULL;
    stream_handle_t *handle = (stream_handle_t *)hd;
    http2_header *nva = NULL;

    POINTER_SANITY_CHECK(handle, NULL_VALUE_ERROR);
    POINTER_SANITY_CHECK(info, NULL_VALUE_ERROR);
    POINTER_SANITY_CHECK(info->identify, NULL_VALUE_ERROR);


    memset(&h2_data, 0, sizeof(http2_data));

    HAL_Snprintf(path, sizeof(path), "/stream/open/%s", info->identify);

    file_upload_gen_string(client_id, CID_STRING_ENUM, NULL, 0);
    file_upload_gen_string(sign_str, ORI_SIGN_STR_ENUM, client_id, 0);
    file_upload_gen_string(sign, REAL_SIGN_STR_ENUM, sign_str, 0);

    char version[33] = {0};
    HAL_Snprintf(version, sizeof(version), "%d", get_version_int());
    const http2_header static_header[] = { MAKE_HEADER(":method", "POST"),
                                           MAKE_HEADER_CS(":path", path),
                                           MAKE_HEADER(":scheme", "https"),
                                           MAKE_HEADER("x-auth-name", "devicename"),
                                           MAKE_HEADER_CS("x-auth-param-client-id", client_id),
                                           MAKE_HEADER("x-auth-param-signmethod", "hmacsha1"),
                                           MAKE_HEADER_CS("x-auth-param-product-key", g_device_info.product_key),
                                           MAKE_HEADER_CS("x-auth-param-device-name", g_device_info.device_name),
                                           MAKE_HEADER_CS("x-auth-param-sign", sign),
                                           MAKE_HEADER_CS("x-sdk-version", version),
                                           MAKE_HEADER_CS("x-sdk-version-name", LINKKIT_VERSION),
                                           MAKE_HEADER("x-sdk-platform", "c"),
                                           MAKE_HEADER("content-length", "0"),
                                         };
    header_num = sizeof(static_header) / sizeof(static_header[0]);
    if (header != NULL) {
        header_num += header->num;
    }
    nva = (http2_header *)HTTP2_STREAM_MALLOC(sizeof(http2_header) * header_num);
    if (nva == NULL) {
        h2stream_err("nva malloc failed\n");
        return FAIL_RETURN;
    }


    /* add external header if it's not NULL */
    header_count = http2_nv_copy(nva, 0, (http2_header *)static_header, sizeof(static_header) / sizeof(static_header[0]));
    if (header != NULL) {
        header_count = http2_nv_copy(nva, header_count, (http2_header *)header->nva, header->num);
    }

    h2_data.header = (http2_header *)nva;
    h2_data.header_count = header_count;
    h2_data.data = NULL;
    h2_data.len = 0;
    h2_data.flag = 1 ;
    h2_data.stream_id = 0;

    HAL_MutexLock(handle->mutex);
    rv = iotx_http2_client_send((void *)handle->http2_connect, &h2_data);
    http2_stream_node_insert(handle, h2_data.stream_id, info->user_data, &node);
    HAL_MutexUnlock(handle->mutex);
    HTTP2_STREAM_FREE(nva);

    if (rv < 0) {
        h2stream_err("client send error\n");
        return FAIL_RETURN;
    }

    if (node == NULL) {
        h2stream_err("node insert failed!");
        return FAIL_RETURN;
    }

    node->stream_type = STREAM_TYPE_AUXILIARY;
    rv = HAL_SemaphoreWait(node->semaphore, IOT_HTTP2_RES_OVERTIME_MS);
    if (rv < 0 || memcmp(node->status_code, "200", 3)) {
        h2stream_err("semaphore wait overtime or status code error\n");
        HAL_MutexLock(handle->mutex);
        http2_stream_node_remove(handle, node->stream_id);
        HAL_MutexUnlock(handle->mutex);
        return FAIL_RETURN;
    }
    info->channel_id = HTTP2_STREAM_MALLOC(strlen(node->channel_id) + 1);
    if (info->channel_id == NULL) {
        h2stream_err("channel_id malloc failed\n");
        HAL_MutexLock(handle->mutex);
        http2_stream_node_remove(handle, node->stream_id);
        HAL_MutexUnlock(handle->mutex);
        return FAIL_RETURN;
    }
    memset(info->channel_id, 0, strlen(node->channel_id) + 1);
    strcpy(info->channel_id, node->channel_id);

    return SUCCESS_RETURN;
}

int IOT_HTTP2_Stream_Send(void *hd, stream_data_info_t *info, header_ext_info_t *header)
{
    int rv = 0;
    http2_data h2_data;
    char path[128] = {0};
    char data_len_str[33] = {0};
    int windows_size;
    int count = 0;
    http2_stream_node_t *node = NULL;
    stream_handle_t *handle = (stream_handle_t *)hd;
    http2_header *nva = NULL;

    POINTER_SANITY_CHECK(handle, NULL_VALUE_ERROR);
    POINTER_SANITY_CHECK(info, NULL_VALUE_ERROR);
    POINTER_SANITY_CHECK(info->stream, NULL_VALUE_ERROR);
    POINTER_SANITY_CHECK(info->channel_id, NULL_VALUE_ERROR);
    ARGUMENT_SANITY_CHECK(info->stream_len != 0, FAIL_RETURN);
    ARGUMENT_SANITY_CHECK(info->packet_len != 0, FAIL_RETURN);

    windows_size = iotx_http2_get_available_window_size(handle->http2_connect);
    while (windows_size < info->packet_len) {
        h2stream_warning("windows_size < info->packet_len ,wait ...\n");
        HAL_SleepMs(100);
        if (++count > 50) {
            return FAIL_RETURN;
        }
        windows_size = iotx_http2_get_available_window_size(handle->http2_connect);
    }

    HAL_Snprintf(data_len_str, sizeof(data_len_str), "%d", info->stream_len);
    HAL_Snprintf(path, sizeof(path), "/stream/send/%s", info->identify);
    if (info->send_len == 0) { //first send,need header
        int header_count, header_num;
        char version[33] = {0};
        HAL_Snprintf(version, sizeof(version), "%d", get_version_int());
        const http2_header static_header[] = { MAKE_HEADER(":method", "POST"),
                                               MAKE_HEADER_CS(":path", path),
                                               MAKE_HEADER(":scheme", "https"),
                                               MAKE_HEADER_CS("content-length", data_len_str),
                                               MAKE_HEADER_CS("x-data-stream-id", info->channel_id),
                                               MAKE_HEADER_CS("x-sdk-version", version),
                                               MAKE_HEADER_CS("x-sdk-version-name", LINKKIT_VERSION),
                                               MAKE_HEADER("x-sdk-platform", "c"),
                                             };

        header_num = sizeof(static_header) / sizeof(static_header[0]);
        if (header != NULL) {
            header_num += header->num;
        }
        nva = (http2_header *)HTTP2_STREAM_MALLOC(sizeof(http2_header) * header_num);
        if (nva == NULL) {
            h2stream_err("nva malloc failed\n");
            return FAIL_RETURN;
        }

        /* add external header if it's not NULL */
        header_count = http2_nv_copy(nva, 0, (http2_header *)static_header, sizeof(static_header) / sizeof(static_header[0]));
        if (header != NULL) {
            header_count = http2_nv_copy(nva, header_count, (http2_header *)header->nva, header->num);
        }
        memset(&h2_data, 0, sizeof(h2_data));
        h2_data.header = (http2_header *)nva;
        h2_data.header_count = header_count;
        h2_data.data = info->stream;
        h2_data.len = info->packet_len;

        if (info->packet_len + info->send_len == info->stream_len) { //last frame
            h2_data.flag = 1;
        } else {
            h2_data.flag = 0;
        }

        HAL_MutexLock(handle->mutex);
        rv = iotx_http2_client_send((void *)handle->http2_connect, &h2_data);
        http2_stream_node_insert(handle, h2_data.stream_id, info->user_data, &node);
        HAL_MutexUnlock(handle->mutex);
        HTTP2_STREAM_FREE(nva);

        if (rv < 0) {
            h2stream_err("send failed!");
            return FAIL_RETURN;
        }

        if (node == NULL) {
            h2stream_err("node insert failed!");
            return FAIL_RETURN;
        }

        node->stream_type = STREAM_TYPE_UPLOAD;
        info->h2_stream_id = h2_data.stream_id;
        info->send_len += info->packet_len;
    } else {
        h2_data.header = NULL;
        h2_data.header_count = 0;
        h2_data.data = info->stream;
        h2_data.len = info->packet_len;

        h2_data.stream_id = info->h2_stream_id;
        if (info->packet_len + info->send_len == info->stream_len) { //last frame
            h2_data.flag = 1;
        } else {
            h2_data.flag = 0;
        }

        HAL_MutexLock(handle->mutex);
        rv = iotx_http2_client_send((void *)handle->http2_connect, &h2_data);
        HAL_MutexUnlock(handle->mutex);
        if (rv < 0) {
            return FAIL_RETURN;
        }
        info->send_len += info->packet_len;
    }

    if (h2_data.flag == 1) {
        http2_stream_node_t *node = NULL;
        HAL_MutexLock(handle->mutex);
        http2_stream_node_search(handle, h2_data.stream_id, &node);
        HAL_MutexUnlock(handle->mutex);
        if (node == NULL) {
            h2stream_err("node search failed!");
            return FAIL_RETURN;
        }
        rv = HAL_SemaphoreWait(node->semaphore, IOT_HTTP2_RES_OVERTIME_MS);
        if (rv < 0 || memcmp(node->status_code, "200", 3)) {
            h2stream_err("semaphore wait overtime or status code error,h2_data.stream_id %d\n", h2_data.stream_id);
            HAL_MutexLock(handle->mutex);
            http2_stream_node_remove(handle, node->stream_id);
            HAL_MutexUnlock(handle->mutex);
            return FAIL_RETURN;
        }
    }

    return rv;
}

int IOT_HTTP2_Stream_Query(void *hd, stream_data_info_t *info, header_ext_info_t *header)
{
    int rv = 0;
    http2_data h2_data;
    http2_stream_node_t *node = NULL;
    char path[128] = {0};
    int header_count, header_num;
    stream_handle_t *handle = (stream_handle_t *)hd;
    http2_header *nva = NULL;

    POINTER_SANITY_CHECK(info, NULL_VALUE_ERROR);
    POINTER_SANITY_CHECK(handle, NULL_VALUE_ERROR);
    POINTER_SANITY_CHECK(info->channel_id, NULL_VALUE_ERROR);
    char version[33] = {0};
    HAL_Snprintf(version, sizeof(version), "%d", get_version_int());
    HAL_Snprintf(path, sizeof(path), "/stream/send/%s", info->identify);
    const http2_header static_header[] = { MAKE_HEADER(":method", "GET"),
                                           MAKE_HEADER_CS(":path", path),
                                           MAKE_HEADER(":scheme", "https"),
                                           MAKE_HEADER_CS("x-data-stream-id", info->channel_id),
                                           MAKE_HEADER("x-test-downstream", "1"),
                                           MAKE_HEADER_CS("x-sdk-version", version),
                                           MAKE_HEADER_CS("x-sdk-version-name", LINKKIT_VERSION),
                                           MAKE_HEADER("x-sdk-platform", "c"),
                                         };

    header_num = sizeof(static_header) / sizeof(static_header[0]);
    if (header != NULL) {
        header_num += header->num;
    }
    nva = (http2_header *)HTTP2_STREAM_MALLOC(sizeof(http2_header) * header_num);
    if (nva == NULL) {
        h2stream_err("nva malloc failed\n");
        return FAIL_RETURN;
    }

    /* add external header if it's not NULL */
    header_count = http2_nv_copy(nva, 0, (http2_header *)static_header, sizeof(static_header) / sizeof(static_header[0]));
    if (header != NULL) {
        header_count = http2_nv_copy(nva, header_count, (http2_header *)header->nva, header->num);
    }
    h2_data.header = (http2_header *)nva;
    h2_data.header_count = header_count;
    h2_data.data = NULL;
    h2_data.len = 0;
    h2_data.flag = 1;
    h2_data.stream_id = 0;

    HAL_MutexLock(handle->mutex);
    rv = iotx_http2_client_send((void *)handle->http2_connect, &h2_data);
    http2_stream_node_insert(handle, h2_data.stream_id, info->user_data, &node);
    HAL_MutexUnlock(handle->mutex);
    HTTP2_STREAM_FREE(nva);

    if (rv < 0) {
        h2stream_err("client send error\n");
        return rv;
    }

    if (node == NULL) {
        h2stream_err("node insert failed!");
        return FAIL_RETURN;
    }

    node->stream_type = STREAM_TYPE_DOWNLOAD;
    rv = HAL_SemaphoreWait(node->semaphore, IOT_HTTP2_RES_OVERTIME_MS);
    if (rv < 0 || memcmp(node->status_code, "200", 3)) {
        h2stream_err("semaphore wait overtime or status code error\n");
        HAL_MutexLock(handle->mutex);
        http2_stream_node_remove(handle, node->stream_id);
        HAL_MutexUnlock(handle->mutex);
        return FAIL_RETURN;
    }

    return rv;
}

int IOT_HTTP2_Stream_Close(void *hd, stream_data_info_t *info)
{
    int rv = 0;
    http2_data h2_data;
    char path[128] = {0};
    stream_handle_t *handle = (stream_handle_t *)hd;

    POINTER_SANITY_CHECK(info, NULL_VALUE_ERROR);
    POINTER_SANITY_CHECK(handle, NULL_VALUE_ERROR);
    POINTER_SANITY_CHECK(info->channel_id, NULL_VALUE_ERROR);
    char version[33] = {0};
    HAL_Snprintf(version, sizeof(version), "%d", get_version_int());
    HAL_Snprintf(path, sizeof(path), "/stream/close/%s", info->identify);
    const http2_header static_header[] = { MAKE_HEADER(":method", "POST"),
                                           MAKE_HEADER_CS(":path", path),
                                           MAKE_HEADER(":scheme", "https"),
                                           MAKE_HEADER_CS("x-data-stream-id", info->channel_id),
                                           MAKE_HEADER_CS("x-sdk-version", version),
                                           MAKE_HEADER_CS("x-sdk-version-name", LINKKIT_VERSION),
                                           MAKE_HEADER("x-sdk-platform", "c"),
                                         };

    int header_count = sizeof(static_header) / sizeof(static_header[0]);
    h2_data.header = (http2_header *)static_header;
    h2_data.header_count = header_count;
    h2_data.data = NULL;
    h2_data.len = 0;
    h2_data.flag = 1;
    h2_data.stream_id = 0;

    HAL_MutexLock(handle->mutex);
    rv = iotx_http2_client_send((void *)handle->http2_connect, &h2_data);
    HAL_MutexUnlock(handle->mutex);

    if (rv < 0) {
        h2stream_warning("client send error\n");
    }

    /* just delete stream node */
    char *stream_id = info->channel_id;
    int len = strlen(stream_id);
    http2_stream_node_t *node, *next;
    HAL_MutexLock(handle->mutex);
    list_for_each_entry_safe(node, next, &handle->stream_list, list, http2_stream_node_t) {
        if (info->h2_stream_id == node->stream_id) {
            h2stream_info("stream_node found:stream_id= %d, Delete It", node->stream_id);
            list_del((list_head_t *)&node->list);
            HTTP2_STREAM_FREE(node->channel_id);
            HAL_SemaphoreDestroy(node->semaphore);
            HTTP2_STREAM_FREE(node);
            continue;
        }
        if ((node->channel_id != NULL) && (stream_id != NULL) &&
                (len == strlen(node->channel_id) && !strncmp(node->channel_id, stream_id, len))) {
            list_del((list_head_t *)&node->list);
            HTTP2_STREAM_FREE(node->channel_id);
            HAL_SemaphoreDestroy(node->semaphore);
            HTTP2_STREAM_FREE(node);
        }
    }
    HTTP2_STREAM_FREE(info->channel_id);
    info->channel_id = NULL;
    HAL_MutexUnlock(handle->mutex);
    return rv;
}

int IOT_HTTP2_Disconnect(void *hd)
{
    int ret;
    stream_handle_t *handle = (stream_handle_t *)hd;

    POINTER_SANITY_CHECK(handle, NULL_VALUE_ERROR);
    handle->init_state = 0;

    ret = HAL_SemaphoreWait(handle->semaphore, PLATFORM_WAIT_INFINITE);
    if (ret < 0) {
        h2stream_err("semaphore wait err\n");
        return FAIL_RETURN;
    }

    http2_stream_node_t *node, *next;
    HAL_MutexLock(handle->mutex);
    list_for_each_entry_safe(node, next, &handle->stream_list, list, http2_stream_node_t) {
        list_del((list_head_t *)&node->list);
        HTTP2_STREAM_FREE(node->channel_id);
        HAL_SemaphoreDestroy(node->semaphore);
        HTTP2_STREAM_FREE(node);
    }
    HAL_MutexUnlock(handle->mutex);
    g_stream_handle = NULL;
    HAL_MutexDestroy(handle->mutex);
    HAL_SemaphoreDestroy(handle->semaphore);

    ret = iotx_http2_client_disconnect(handle->http2_connect);
    HTTP2_STREAM_FREE(handle);
    return ret;
}

#ifdef FS_ENABLED
#define PACKET_LEN 16384

typedef struct {
    stream_handle_t *handle;
    const char *path;
    const char *identify;
    upload_file_result_cb cb;
    header_ext_info_t *header;
    void *data;
    http2_list_t list;
} http2_stream_file_t;

static int http2_stream_get_file_size(const char *file_name)
{
    void *fp = NULL;
    int size = 0;
    if ((fp = HAL_Fopen(file_name, "r")) == NULL) {
        h2stream_err("The file %s can not be opened.\n", file_name);
        return -1;
    }
    HAL_Fseek(fp, 0L, HAL_SEEK_END);
    size = HAL_Ftell(fp);
    HAL_Fclose(fp);
    return size;
}

static int http2_stream_get_file_data(const char *file_name, char *data, int len, int offset)
{
    void *fp = NULL;
    int ret = 0;
    if ((fp = HAL_Fopen(file_name, "r")) == NULL) {
        h2stream_err("The file %s can not be opened.\n", file_name);
        return -1;
    }
    ret = HAL_Fseek(fp, offset, HAL_SEEK_SET);
    if (ret != 0) {
        HAL_Fclose(fp);
        h2stream_err("The file %s can not move offset.\n", file_name);
        return -1;
    }
    ret = HAL_Fread(data, len, 1, fp);
    HAL_Fclose(fp);
    return len;
}

static void *http_upload_one(void *user)
{

    stream_data_info_t info;
    int ret;
    if (user == NULL) {
        return NULL;
    }

    http2_stream_file_t *user_data = (http2_stream_file_t *)user;
    stream_handle_t *handle = (stream_handle_t *)user_data->handle;

    int file_size = http2_stream_get_file_size(user_data->path);

    if (file_size <= 0) {
        if (user_data->cb) {
            user_data->cb(user_data->path, UPLOAD_FILE_NOT_EXIST, user_data->data);
        }
        HTTP2_STREAM_FREE(user_data);
        return NULL;
    }

    h2stream_info("file_size=%d", file_size);

    char *data_buffer = HTTP2_STREAM_MALLOC(PACKET_LEN);
    if (data_buffer == NULL) {
        user_data->cb(user_data->path, UPLOAD_MALLOC_FAILED, user_data->data);
        HTTP2_STREAM_FREE(user_data);
        return NULL;
    }

    memset(&info, 0, sizeof(stream_data_info_t));
    info.stream = data_buffer;
    info.stream_len = file_size;
    info.packet_len = PACKET_LEN;
    //info.identify = "com/aliyun/iotx/vision/picture/device/upstream";
    info.identify = user_data->identify;

    ret = IOT_HTTP2_Stream_Open(user_data->handle, &info, user_data->header);
    if (ret < 0) {
        h2stream_err("IOT_HTTP2_Stream_Open failed %d\n", ret);
        if (user_data->cb) {
            user_data->cb(user_data->path, UPLOAD_STREAM_OPEN_FAILED, user_data->data);
        }
        HTTP2_STREAM_FREE(user_data);
        HTTP2_STREAM_FREE(data_buffer);
        return NULL;
    }

    while (info.send_len < info.stream_len) {

        if (!handle->init_state) {
            ret = -1;
            break;
        }
        ret = http2_stream_get_file_data(user_data->path, data_buffer, PACKET_LEN, info.send_len);
        if (ret <= 0) {
            ret = -1;
            h2stream_err("read file err %d\n", ret);
            break;
        }
        info.packet_len = ret;

        if (info.stream_len - info.send_len < info.packet_len) {
            info.packet_len = info.stream_len - info.send_len;
        }

        ret = IOT_HTTP2_Stream_Send(user_data->handle, &info, user_data->header);
        if (ret < 0) {
            h2stream_err("send err %d\n", ret);
            break;
        }
        h2stream_debug("send len =%d\n", info.send_len);
    }

    if (user_data->cb) {

        if (ret < 0) {
            ret = UPLOAD_STREAM_SEND_FAILED;
        } else {
            ret = UPLOAD_SUCCESS;
        }
        user_data->cb(user_data->path, ret, user_data->data);
    }
    IOT_HTTP2_Stream_Close(user_data->handle, &info);
    HTTP2_STREAM_FREE(data_buffer);
    HTTP2_STREAM_FREE(user_data);
    return NULL;
}


static void *http_upload_file_func(void *user)
{
    if (user == NULL) {
        return NULL;
    }
    stream_handle_t *handle = (stream_handle_t *)user;
    while (handle->init_state) {
        http2_stream_file_t *node, *next;
        HAL_MutexLock(handle->mutex);
        list_for_each_entry_safe(node, next, &handle->file_list, list, http2_stream_file_t) {
            list_del((list_head_t *)&node->list);
            HAL_MutexUnlock(handle->mutex);
            http_upload_one((void *)node);
            HAL_MutexLock(handle->mutex);
            break;
        }

        if (list_empty((list_head_t *)&handle->file_list)) {
            h2stream_debug("no file left,file upload thread exit\n");
            handle->file_thread = NULL;
            HAL_MutexUnlock(handle->mutex);
            break;
        }
        HAL_MutexUnlock(handle->mutex);
    }

    return NULL;
}


//void *file_thread = NULL;
int IOT_HTTP2_Stream_UploadFile(void *hd, const char *file_path, const char *identify,
                                header_ext_info_t *header,
                                upload_file_result_cb cb, void *user_data)
{

    int ret;
    hal_os_thread_param_t thread_parms = {0};
    stream_handle_t *handle = (stream_handle_t *)hd;

    POINTER_SANITY_CHECK(handle, NULL_VALUE_ERROR);
    POINTER_SANITY_CHECK(file_path, NULL_VALUE_ERROR);
    POINTER_SANITY_CHECK(identify, NULL_VALUE_ERROR);

    http2_stream_file_t *file_data = (http2_stream_file_t *)HTTP2_STREAM_MALLOC(sizeof(http2_stream_file_t));
    if (file_data == NULL) {
        return -1;
    }

    file_data->handle = handle;
    file_data->path =  file_path;
    file_data->identify = identify;
    file_data->cb = cb;
    file_data->data = user_data;
    file_data->header = header;

    thread_parms.stack_size = 6144;
    thread_parms.name = "file_upload";

    INIT_LIST_HEAD((list_head_t *)&file_data->list);
    HAL_MutexLock(handle->mutex);
    list_add_tail((list_head_t *)&file_data->list, (list_head_t *)&handle->file_list);
    if (handle->file_thread == NULL) {
        ret = HAL_ThreadCreate(&handle->file_thread, http_upload_file_func, handle, &thread_parms, NULL);
        if (ret != 0) {
            h2stream_err("thread create error\n");
            HTTP2_STREAM_FREE(file_data);
            HAL_MutexUnlock(handle->mutex);
            return -1;
        }
        HAL_ThreadDetach(handle->file_thread);
    }
    HAL_MutexUnlock(handle->mutex);
    return 0;
}
#endif
