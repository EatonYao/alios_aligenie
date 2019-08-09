/****************************************************************//**
 *
 * @file tftp_server.c
 *
 * @author   Logan Gunthorpe <logang@deltatee.com>
 *           Dirk Ziegelmeier <dziegel@gmx.de>
 *
 * @brief    Trivial File Transfer Protocol (RFC 1350)
 *
 * Copyright (c) Deltatee Enterprises Ltd. 2013
 * All rights reserved.
 *
 ********************************************************************/

/*
 * Redistribution and use in source and binary forms, with or without
 * modification,are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Author: Logan Gunthorpe <logang@deltatee.com>
 *         Dirk Ziegelmeier <dziegel@gmx.de>
 *
 */

/**
 * @defgroup tftp TFTP server
 * @ingroup apps
 *
 * This is simple TFTP server for the lwIP raw API.
 */

#include "lwip/udp.h"
#include "lwip/timeouts.h"
#include "lwip/debug.h"
#include "lwip/apps/tftp.h"

#include <string.h>
#include <stdio.h>

struct tftp_state {
  const tftp_context_t *ctx;
  void *handle;
  struct pbuf *last_data;
  struct udp_pcb *upcb;
  ip_addr_t addr;
  u16_t port;
  int timer;
  int last_pkt;
  u16_t blknum;
  u8_t retries;
  u8_t mode_write;
};

static struct tftp_state tftp_state;

static void tftp_tmr(void* arg);
void tftp_send_error(struct udp_pcb *pcb, const ip_addr_t *addr, u16_t port,
                    tftp_error_t code, const char *str);
void tftp_send_ack(struct udp_pcb *pcb, const ip_addr_t *addr, u16_t port, u16_t blknum);

static void
close_handle(void)
{
  tftp_state.port = 0;
  ip_addr_set_any(0, &tftp_state.addr);

  if(tftp_state.last_data != NULL) {
    pbuf_free(tftp_state.last_data);
    tftp_state.last_data = NULL;
  }

  sys_untimeout(tftp_tmr, NULL);

  if (tftp_state.handle) {
    tftp_state.ctx->close(tftp_state.handle);
    tftp_state.handle = NULL;
    LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: closing\n"));
  }
}

static void
resend_data(void)
{
  struct pbuf *p = pbuf_alloc(PBUF_TRANSPORT, tftp_state.last_data->len, PBUF_RAM);
  if(p == NULL) {
    return;
  }

  if(pbuf_copy(p, tftp_state.last_data) != ERR_OK) {
    pbuf_free(p);
    return;
  }

  udp_sendto(tftp_state.upcb, p, &tftp_state.addr, tftp_state.port);
  pbuf_free(p);
}

static void
send_data(void)
{
  u16_t *payload;
  int ret;

  if(tftp_state.last_data != NULL) {
    pbuf_free(tftp_state.last_data);
  }

  tftp_state.last_data = pbuf_alloc(PBUF_TRANSPORT, TFTP_HEADER_LENGTH + TFTP_MAX_PAYLOAD_SIZE, PBUF_RAM);
  if(tftp_state.last_data == NULL) {
    return;
  }

  payload = (u16_t *) tftp_state.last_data->payload;
  payload[0] = PP_HTONS(TFTP_DATA);
  payload[1] = lwip_htons(tftp_state.blknum);

  ret = tftp_state.ctx->read(tftp_state.handle, &payload[2], TFTP_MAX_PAYLOAD_SIZE);
  if (ret < 0) {
    tftp_send_error(tftp_state.upcb, &tftp_state.addr, tftp_state.port, TFTP_ERROR_ACCESS_VIOLATION, "Error occured while reading the file.");
    close_handle();
    return;
  }

  pbuf_realloc(tftp_state.last_data, (u16_t)(TFTP_HEADER_LENGTH + ret));
  resend_data();
}

static void
recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr, u16_t port)
{
  u16_t *sbuf = (u16_t *) p->payload;
  int opcode;

  LWIP_UNUSED_ARG(arg);
  LWIP_UNUSED_ARG(upcb);

  if (((tftp_state.port != 0) && (port != tftp_state.port)) ||
      (!ip_addr_isany_val(tftp_state.addr) && !ip_addr_cmp(&tftp_state.addr, addr))) {
    tftp_send_error(tftp_state.upcb, addr, port,
            TFTP_ERROR_ACCESS_VIOLATION, "Only one connection at a time is supported");
    pbuf_free(p);
    return;
  }

  opcode = sbuf[0];

  tftp_state.last_pkt = tftp_state.timer;
  tftp_state.retries = 0;

  switch (opcode) {
    case PP_HTONS(TFTP_RRQ): /* fall through */
    case PP_HTONS(TFTP_WRQ):
    {
      const char tftp_null = 0;
      char filename[TFTP_MAX_FILENAME_LEN] = {0};
      char mode[TFTP_MAX_MODE_LEN];
      u16_t filename_end_offset;
      u16_t mode_end_offset;

      if(tftp_state.handle != NULL) {
        tftp_send_error(tftp_state.upcb, addr, port,
                TFTP_ERROR_ACCESS_VIOLATION, "Only one connection at a time is supported");
        break;
      }

      sys_timeout(TFTP_TIMER_MSECS, tftp_tmr, NULL);

      /* find \0 in pbuf -> end of filename string */
      filename_end_offset = pbuf_memfind(p, &tftp_null, sizeof(tftp_null), 2);
      if((u16_t)(filename_end_offset-2) > sizeof(filename)) {
        tftp_send_error(tftp_state.upcb, addr, port,
                TFTP_ERROR_ACCESS_VIOLATION, "Filename too long/not NULL terminated");
        break;
      }
      pbuf_copy_partial(p, filename, filename_end_offset-2, 2);

      /* find \0 in pbuf -> end of mode string */
      mode_end_offset = pbuf_memfind(p, &tftp_null, sizeof(tftp_null), filename_end_offset+1);
      if((u16_t)(mode_end_offset-filename_end_offset) > sizeof(mode)) {
        tftp_send_error(tftp_state.upcb, addr, port,
                TFTP_ERROR_ACCESS_VIOLATION, "Mode too long/not NULL terminated");
        break;
      }
      pbuf_copy_partial(p, mode, mode_end_offset-filename_end_offset, filename_end_offset+1);

      tftp_state.handle = tftp_state.ctx->open(filename, mode, opcode == PP_HTONS(TFTP_WRQ));
      tftp_state.blknum = 1;

      if (!tftp_state.handle) {
        tftp_send_error(tftp_state.upcb, addr, port,
                TFTP_ERROR_FILE_NOT_FOUND, "Unable to open requested file.");
        break;
      }

      LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: %s request from ",
                  (opcode == PP_HTONS(TFTP_WRQ)) ? "write" : "read"));
      ip_addr_debug_print(TFTP_DEBUG | LWIP_DBG_STATE, addr);
      LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, (" for '%s' mode '%s'\n", filename, mode));

      ip_addr_copy(tftp_state.addr, *addr);
      tftp_state.port = port;

      if (opcode == PP_HTONS(TFTP_WRQ)) {
        tftp_state.mode_write = 1;
        tftp_send_ack(tftp_state.upcb, &tftp_state.addr, tftp_state.port, 0);
      } else {
        tftp_state.mode_write = 0;
        send_data();
      }

      break;
    }

    case PP_HTONS(TFTP_DATA):
    {
      int ret;
      u16_t blknum;

      if (tftp_state.handle == NULL) {
        tftp_send_error(tftp_state.upcb, addr, port,
                TFTP_ERROR_ACCESS_VIOLATION, "No connection");
        break;
      }

      if (tftp_state.mode_write != 1) {
        tftp_send_error(tftp_state.upcb, addr, port,
                TFTP_ERROR_ACCESS_VIOLATION, "Not a write connection");
        break;
      }

      blknum = lwip_ntohs(sbuf[1]);
      pbuf_header(p, -TFTP_HEADER_LENGTH);

      ret = tftp_state.ctx->write(tftp_state.handle, p);
      if (ret < 0) {
        tftp_send_error(tftp_state.upcb, addr, port,
                TFTP_ERROR_ACCESS_VIOLATION, "error writing file");
        close_handle();
      } else {
        tftp_send_ack(tftp_state.upcb, &tftp_state.addr, tftp_state.port, blknum);
      }

      if (p->tot_len < TFTP_MAX_PAYLOAD_SIZE) {
        close_handle();
      }
      break;
    }

    case PP_HTONS(TFTP_ACK):
    {
      u16_t blknum;
      int lastpkt;

      if (tftp_state.handle == NULL) {
        tftp_send_error(tftp_state.upcb, addr, port,
                TFTP_ERROR_ACCESS_VIOLATION, "No connection");
        break;
      }

      if (tftp_state.mode_write != 0) {
        tftp_send_error(tftp_state.upcb, addr, port,
                TFTP_ERROR_ACCESS_VIOLATION, "Not a read connection");
        break;
      }

      blknum = lwip_ntohs(sbuf[1]);
      if (blknum != tftp_state.blknum) {
        tftp_send_error(tftp_state.upcb, addr, port,
                TFTP_ERROR_UNKNOWN_TRFR_ID, "Wrong block number");
        break;
      }

      lastpkt = 0;

      if (tftp_state.last_data != NULL) {
        lastpkt = tftp_state.last_data->tot_len != (TFTP_MAX_PAYLOAD_SIZE + TFTP_HEADER_LENGTH);
      }

      if (!lastpkt) {
        tftp_state.blknum++;
        send_data();
      } else {
        close_handle();
      }

      break;
    }

    default:
      tftp_send_error(tftp_state.upcb, addr, port,
              TFTP_ERROR_ILLEGAL_OPERATION, "Unknown operation");
      break;
  }

  pbuf_free(p);
}

static void
tftp_tmr(void* arg)
{
  LWIP_UNUSED_ARG(arg);

  tftp_state.timer++;

  if (tftp_state.handle == NULL) {
    return;
  }

  sys_timeout(TFTP_TIMER_MSECS, tftp_tmr, NULL);

  if ((tftp_state.timer - tftp_state.last_pkt) > (TFTP_TIMEOUT_MSECS / TFTP_TIMER_MSECS)) {
    if ((tftp_state.last_data != NULL) && (tftp_state.retries < TFTP_MAX_RETRIES)) {
      LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: timeout, retrying\n"));
      resend_data();
      tftp_state.retries++;
    } else {
      LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: timeout\n"));
      close_handle();
    }
  }
}

static void* tftp_fopen(const char* fname, const char* mode, u8_t write)
{
    FILE *fp = NULL;

    if (strncmp(mode, "netascii", 8) == 0) {
        fp = fopen(fname, write == 0 ? "r" : "w");
    } else if (strncmp(mode, "octet", 5) == 0) {
        fp = fopen(fname, write == 0 ? "rb" : "wb");
    }
    return (void*)fp;
}

static void tftp_fclose(void* handle)
{
    fclose((FILE*)handle);
}

static int tftp_fread(void* handle, void* buf, int bytes)
{
    size_t readbytes;
    readbytes = fread(buf, 1, (size_t)bytes, (FILE*)handle);
    return (int)readbytes;
}

static int tftp_fwrite(void* handle, struct pbuf* p)
{
    char buff[512];
    size_t writebytes = -1;
    pbuf_copy_partial(p, buff, p->tot_len, 0);
    writebytes = fwrite(buff, 1, p->tot_len, (FILE *)handle);
    return (int)writebytes;
}

const tftp_context_t server_ctx = {
    .open = tftp_fopen,
    .close = tftp_fclose,
    .read = tftp_fread,
    .write = tftp_fwrite
};

/** @ingroup tftp
 * Initialize TFTP server.
 * @param ctx TFTP callback struct
 */
err_t
tftp_server_start(void)
{
  err_t ret;

  if (tftp_state.upcb != NULL)
      return ERR_OK;

  struct udp_pcb *pcb = udp_new_ip_type(IPADDR_TYPE_ANY);
  if (pcb == NULL) {
    return ERR_MEM;
  }

  ret = udp_bind(pcb, IP_ANY_TYPE, TFTP_PORT);
  if (ret != ERR_OK) {
    udp_remove(pcb);
    return ret;
  }

  tftp_state.handle    = NULL;
  tftp_state.port      = 0;
  tftp_state.ctx       = &server_ctx;
  tftp_state.timer     = 0;
  tftp_state.last_data = NULL;
  tftp_state.upcb      = pcb;
  udp_recv(pcb, recv, NULL);

  return ERR_OK;
}

void
tftp_server_stop(void)
{
    if (tftp_state.handle)
        close_handle();

    if (tftp_state.upcb != NULL) {
        udp_remove(tftp_state.upcb);
        memset(&tftp_state, 0, sizeof(tftp_state));
    }
}
