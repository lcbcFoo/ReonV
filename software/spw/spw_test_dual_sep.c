/*****************************************************************************/
/*   This file is a part of the GRLIB VHDL IP LIBRARY */
/*   Copyright (C) 2004 GAISLER RESEARCH */

/*   This program is free software; you can redistribute it and/or modify */
/*   it under the terms of the GNU General Public License as published by */
/*   the Free Software Foundation; either version 2 of the License, or */
/*   (at your option) any later version. */

/*   See the file COPYING for the full details of the license. */
/******************************************************************************/

#ifndef SPW_ADDR 
#define SPW_ADDR    0x80000a00
#endif

#ifndef SPW_FREQ
#define SPW_FREQ    162000       /* Frequency of txclk in khz, set to 0 to use reset value  */
#endif

#ifndef AHBFREQ
#define AHBFREQ     50000        /* Set to zero to leave reset values */
#endif

#ifndef SPW_CLKDIV
#define SPW_CLKDIV   0
#endif

#ifndef INITIATOR
#define INITIATOR 1
#endif

#ifndef SPW_PORT
#define SPW_PORT 0
#endif

#include <stdlib.h>
#include "spwapi.h"
#include "rmapapi.h"
#include <time.h>
#include <string.h>
#include <limits.h>

#define PKTTESTMAX  128
#define DESCPKT     1024
#define MAXSIZE     2000000 /*16777215*/     /*must not be set to more than 16777216 (2^24)*/
#define RMAPSIZE    1024
#define RMAPCRCSIZE 1024
#define LOOPPKTSIZE 65536

#define TEST1       1
#define TEST2       1
#define TEST3       1
#define TEST4       1
#define TEST5       1
#define TEST6       1
#define TEST7       1
#define TEST8       1
#define TEST9       1
#define TEST10      1
#define TEST11      1
#define TEST12      1

static inline char loadb(int addr)
{
        char tmp;        
        asm(" lduba [%1]1, %0 "
            : "=r"(tmp)
            : "r"(addr)
                );
        return tmp;
}

static inline int loadmem(int addr)
{
        int tmp;        
        asm(" lda [%1]1, %0 "
            : "=r"(tmp)
            : "r"(addr)
                );
        return tmp;
}

static int rmap_read(char dsta, char srca, int addr, int len, int incr, 
                     int dstkey, char *data, struct spwvars *spw) 
{
        int k;
        int tmp;
        int iterations;
        struct rxstatus *rxs;
        struct rmap_pkt *cmd;
        struct rmap_pkt *reply;
        int  *size;
        int *cmdsize;
        int *replysize;
        char *tx0;
        char *rx1;
        char *rx2;
        
        rxs = (struct rxstatus *) malloc(sizeof(struct rxstatus));
        size = (int *) malloc(sizeof(int));
        
        cmd = (struct rmap_pkt *) malloc(sizeof(struct rmap_pkt));
        reply = (struct rmap_pkt *) malloc(sizeof(struct rmap_pkt));
        cmdsize = (int *) malloc(sizeof(int));
        replysize = (int *) malloc(sizeof(int));
        tx0 = malloc(256);
        rx1 = malloc(32+len+1);
        rx2 = malloc(32+len+1);
        
        if (incr) {
                cmd->incr     = yes;
        } else {
                if (((addr % 4) != 0) || ((len % 4) != 0)) {
                        return 1;
                }
                cmd->incr     = no;
        }
        cmd->type     = readcmd;
        cmd->verify   = no;
        cmd->ack      = yes;
        cmd->destaddr = dsta;
        cmd->destkey  = dstkey;
        cmd->srcaddr  = srca;
        cmd->tid      = 0;
        cmd->addr     = addr;
        cmd->len      = len;
        cmd->status   = 0;
        cmd->dstspalen = 0;
        cmd->dstspa  = (char *)NULL;
        cmd->srcspalen = 0;
        cmd->srcspa = (char *)NULL;
        if (build_rmap_hdr(cmd, tx0, cmdsize)) {
                printf("RMAP cmd build failed\n");
                return 3;
        }
        reply->type     = readrep;
        reply->verify   = no;
        reply->ack      = yes;
        if (incr) {
                reply->incr = yes;
        } else {
                reply->incr = no;
        }
        
        reply->status   = 0;
        reply->incr     = yes;
        reply->status   = 0;
        reply->len      = len;
        reply->destaddr = dsta;
        reply->destkey  = dstkey;
        reply->srcaddr  = srca;
        reply->tid      = 0;
        reply->addr     = addr;
        reply->dstspalen = 0;
        reply->dstspa  = (char *)NULL;
        reply->srcspalen = 0;
        reply->srcspa = (char *)NULL;
        if (build_rmap_hdr(reply, rx2, replysize)) {
                printf("RMAP reply build failed\n");
                return 3;
        }
        while (spw_rx(0, rx1, spw)) {
                for (k = 0; k < 64; k++) {}
        }
        if (spw_tx(0, 1, 0, 0, *cmdsize, tx0, 0, tx0, spw)) {
                printf("Transmission failed\n");
                return 4;
        }
        while (!(tmp = spw_checktx(0, spw))) {
                for (k = 0; k < 64; k++) {}
        }
        if (tmp != 1) {
                printf("Error in transmit \n");
                return 5;
        }
        iterations = 0;
        while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                if (iterations > 1000) {
                        printf("ERROR: Time limit exceeded while waiting for RMAP reply\n");
                        return 6;
                }
                for (k = 0; k < 64; k++) {}
                iterations++;
        }
        if (rxs->truncated) {
                printf("Received packet truncated\n");
                return 7;
        }
        if(rxs->eep) {
                printf("Received packet terminated with eep\n");
                return 8;
        }
        if(rxs->hcrcerr) {
                printf("Received packet header crc error detected\n");
                return 9;
        }
        if(rxs->dcrcerr) {
                printf("Received packet data crc error detected\n");
                return 10;
        }
        if (*size != (*replysize+len+1+1)) {
                printf("Received packet has wrong length\n");
                printf("Expected: %i, Got: %i \n", *replysize+len+1, *size);
        }
        for (k = 0; k < *replysize; k++) {
                if (loadb((int)&(rx1[k])) != rx2[k]) {
                        printf("Compare error 0: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[k])), (unsigned)rx2[k]);
                        return 11;
                }
        }
        for (k = 0; k < len; k++) {
                data[k] = loadb((int)&(rx1[*replysize+1+k]));
        }
        free(rxs);
        free(size);
        
        free(cmd);
        free(reply);
        free(cmdsize);
        free(replysize);
        free(tx0);
        free(rx1);
        free(rx2);
        return 0;
}


int main(int argc, char *argv[]) 
{
        int  ret;
        clock_t t1, t2;
        double t3, bitrate;
        int  dmachan;
        int  sysfreq;
        int  txfreq1;
        int  txfreq2;
        int  i;
        int  j;
        int  k;
        int  m;
        int  l;
        int  n;
        int  iterations;
        int  data;
        int  hdr;
        int  notrx;
        int  tmp;
        int  eoplen;        
        int  *size;
        char *txbuf;
        char *rxbuf;
        char *rx0;
        char *rx1;
        char *rx2;
        char *rx3;
        char *tx0;
        char *tx1;
        char *tx2;
        char *tx3;
        char *cmp0;
        char *cmp1;
        char *cmp2;
        char *cmp3;
        char *tx[256];
        char *rx[256];
        char *chk[256];
        char rxdata[4];
        struct rxstatus *rxs;
        struct spwvars *spw;
        struct rmap_pkt *cmd;
        struct rmap_pkt *reply;
        int *cmdsize;
        int *replysize;
        int startrx[4];
        int rmappkt;
        int rmapincr;
        int destaddr;
        int sepaddr[4];
        int chanen[4];
        int rmaprx;
        int found;
        int rxchan;
        int length;
        int maxlen;
        int txlen;
        int rxlen;
        int txpnt;
        int rxpnt;
        int chkpnt;
        int rxchkpnt;
        int init;
        spw = (struct spwvars *) malloc(sizeof(struct spwvars));
        rxs = (struct rxstatus *) malloc(sizeof(struct rxstatus));
        size = (int *) malloc(sizeof(int));
        
        cmd = (struct rmap_pkt *) malloc(sizeof(struct rmap_pkt));
        reply = (struct rmap_pkt *) malloc(sizeof(struct rmap_pkt));
        cmdsize = (int *) malloc(sizeof(int));
        replysize = (int *) malloc(sizeof(int));
        
        printf("**** TEST STARTED **** \n\n");
        /************************ TEST INIT ***********************************/
        /*Initalize link*/
        /*initialize parameters*/

#if INITIATOR == 1 
  
        if (spw_setparam(0x1, SPW_CLKDIV, 0xBF, 0, 0, SPW_ADDR, AHBFREQ, spw, SPW_PORT, SPW_FREQ/10000-1) ) {
                printf("Illegal parameters to spacewire\n");
                exit(1);
        }
        
        for(i = 0; i < 4; i++) {
                spw_setparam_dma(i, 0x1, 0x0, 1, 1048576, spw);
        }
        
#else
        
        if (spw_setparam(0x2, SPW_CLKDIV, 0xBF, 0, 0, SPW_ADDR, AHBFREQ , spw, SPW_PORT, SPW_FREQ/10000-1) ) {
                printf("Illegal parameters to spacewire\n");
                exit(1);
        }
        for(i = 0; i < 4; i++) {
                spw_setparam_dma(i, 0x2, 0x0, 1, 1048576, spw);
        }
        
#endif

        /* initialize links */
        if ((ret = spw_init(spw))) {
                printf("Link initialization failed for link: %d\n", ret);
        }
        
        printf("SPW version: %d \n", spw->ver);
        
        if (wait_running(spw)) {
                printf("Link did not enter run-state\n");
        }

/*   /\************************ TEST 1 **************************************\/  */
/*   /\*Simulatenous time-code and packet transmission/reception*\/ */
#if TEST1 == 1 
        printf("TEST 1: Tx and Rx with simultaneous time-code transmissions \n\n");
        
        rx0 = malloc(128);
        rx1 = malloc(128);
        rx2 = malloc(128);
        rx3 = malloc(128);
        tx0 = malloc(128);
        tx1 = malloc(128);
        tx2 = malloc(128);
        tx3 = malloc(128);
        cmp0 = malloc(128);
        cmp1 = malloc(128);
        cmp2 = malloc(128);
        cmp3 = malloc(128);
        
#if INITIATOR == 1
        tx0[0] = (char)0x2;
        tx1[0] = (char)0x2;
        tx2[0] = (char)0x2;
        tx3[0] = (char)0x2;
        cmp0[0] = (char)0x1;
        cmp1[0] = (char)0x1;
        cmp2[0] = (char)0x1;
        cmp3[0] = (char)0x1;
        
        for(j = 1; j < 128; j++) {
                tx0[j] = ((j + 15) % 256);
                tx1[j] = ((j + 89) % 256);
                tx2[j] = ((j + 65) % 256);
                tx3[j] = ((j + 113) % 256);
                cmp0[j] = ((j + 8) % 256);
                cmp1[j] = ((j + 21) % 256);
                cmp2[j] = ((j + 128) % 256);
                cmp3[j] = ((j + 155) % 256);
        }

        spw_rx(0, rx0, spw);
        spw_rx(0, rx1, spw);
        spw_rx(0, rx2, spw);
        spw_rx(0, rx3, spw);
        spw_tx(0, 0, 0, 0, 0, tx0, 128, tx0, spw);
        spw_tx(0, 0, 0, 0, 0, tx1, 128, tx1, spw);
        spw_tx(0, 0, 0, 0, 0, tx2, 128, tx2, spw);
        spw_tx(0, 0, 0, 0, 0, tx3, 128, tx3, spw);

        for (i = 0; i < 4; i++) {
                while(!(tmp = spw_checktx(0, spw))) {
                        for(j = 0; j < 64; j++) {}
                }
                if (tmp != 1) {
                        printf("Transmit error\n");
                        exit(1);
                }
        }
        
        for(i = 0; i < 4; i++) {
                while(!(tmp = spw_checkrx(0, size, rxs, spw))) {
                        for(j = 0; j < 64; j++) {}
                }
                if (rxs->truncated) {
                        printf("Received packet truncated\n");
                        exit(1);
                }
                if(rxs->eep) {
                        printf("Received packet terminated with eep\n");
                        exit(1);
                }
                if (*size != 128) {
                        printf("Received packet has wrong length\n");
                        exit(1);
                }
        }

        printf("Link received\n");
        
        for(j = 0; j < 128; j++) {
                if (loadb((int)&(rx0[j])) != cmp0[j]) {
                        printf("Compare error buf 0: %u Data: %x Expected: %x \n", j, (unsigned)loadb((int)&(rx0[j])), (unsigned)cmp0[j]);
                        exit(1);
                }
                if (loadb((int)&(rx1[j])) != cmp1[j]) {
                        printf("Compare error buf 1: %u Data: %x Expected: %x \n", j, (unsigned)loadb((int)&(rx1[j])), (unsigned)cmp1[j]);
                        exit(1);
                }
                if (loadb((int)&(rx2[j])) != cmp2[j]) {
                        printf("Compare error buf 2: %u Data: %x Expected: %x \n", j, (unsigned)loadb((int)&(rx2[j])), (unsigned)cmp2[j]);
                        exit(1);
                }
                if (loadb((int)&(rx3[j])) != cmp3[j]) {
                        printf("Compare error buf 3: %u Data: %x Expected: %x \n", j, (unsigned)loadb((int)&(rx3[j])), (unsigned)cmp3[j]);
                        exit(1);
                }
        }
        
  
#else
        tx0[0] = (char)0x1;
        tx1[0] = (char)0x1;
        tx2[0] = (char)0x1;
        tx3[0] = (char)0x1;
        cmp0[0] = (char)0x2;
        cmp1[0] = (char)0x2;
        cmp2[0] = (char)0x2;
        cmp3[0] = (char)0x2;    
        
        for(j = 1; j < 128; j++) {
                cmp0[j] = ((j + 15) % 256);
                cmp1[j] = ((j + 89) % 256);
                cmp2[j] = ((j + 65) % 256);
                cmp3[j] = ((j + 113) % 256);
                tx0[j] = ((j + 8) % 256);
                tx1[j] = ((j + 21) % 256);
                tx2[j] = ((j + 128) % 256);
                tx3[j] = ((j + 155) % 256);
        }

        spw_rx(0, rx0, spw);
        spw_rx(0, rx1, spw);
        spw_rx(0, rx2, spw);
        spw_rx(0, rx3, spw);

        /* Wait for first packet to be received make sure that initiator
           is also ready to receive */
        while(!(tmp = spw_checkrx(0, size, rxs, spw))) {
                for(j = 0; j < 64; j++) {}
        }
        if (rxs->truncated) {
                printf("Received packet truncated\n");
                exit(1);
        }
        if(rxs->eep) {
                printf("Received packet terminated with eep\n");
                exit(1);
        }
        if (*size != 128) {
                printf("Received packet has wrong length\n");
                exit(1);
        }

        /* Transmit four packets */
        spw_tx(0, 0, 0, 0, 0, tx0, 128, tx0, spw);
        spw_tx(0, 0, 0, 0, 0, tx1, 128, tx1, spw);
        spw_tx(0, 0, 0, 0, 0, tx2, 128, tx2, spw);
        spw_tx(0, 0, 0, 0, 0, tx3, 128, tx3, spw);
        
        /* Receive rest of the packets*/
        for(i = 0; i < 3; i++) {
                while(!(tmp = spw_checkrx(0, size, rxs, spw))) {
                        for(j = 0; j < 64; j++) {}
                }
                if (rxs->truncated) {
                        printf("Received packet truncated\n");
                        exit(1);
                }
                if(rxs->eep) {
                        printf("Received packet terminated with eep\n");
                        exit(1);
                }
                if (*size != 128) {
                        printf("Received packet has wrong length\n");
                        exit(1);
                }
        }

        printf("Link received\n");

#endif

        free(rx0);
        free(rx1);
        free(rx2);
        free(rx3);
        free(tx0);
        free(tx1);
        free(tx2);
        free(tx3);
        free(cmp0);
        free(cmp1);
        free(cmp2);
        free(cmp3);
        printf("TEST 1: completed successfully\n\n");
#endif


/* /\************************ TEST 2 **************************************\/ */
#if TEST2 == 1
        printf("TEST 2: Tx and Rx of varying sized packets from/to DMA channel \n\n");
        
        if ((txbuf = calloc(PKTTESTMAX, 1)) == NULL) {
                printf("Transmit buffer initialization failed\n");
                exit(1);
        }
        
        /*initialize data*/
        for (j = 0; j < PKTTESTMAX; j++) {
                txbuf[j] = (char)j;
        }
        txbuf[0] = 0x2;
        txbuf[1] = 0x2;
        
#if INITIATOR == 1 
        
        for (i = 2; i < PKTTESTMAX; i++) {
                printf(".");
                for (j = 2; j < i; j++) {
                        txbuf[j] = ~txbuf[j];
                }
                if (spw_tx(0, 0, 0, 0, 0, txbuf, i, txbuf, spw)) {
                        printf("Transmission failed\n");
                        exit(1);
                }
                while (!(tmp = spw_checktx(0, spw))) {
                        for (k = 0; k < 64; k++) {}
                }
                if (tmp != 1) {
                        printf("Error in transmit \n");
                        exit(1);
                }
        }
        

#else
        
        if ((rxbuf = calloc(PKTTESTMAX, 1)) == NULL) {
                printf("Receive buffer initialization failed\n");
                exit(1);
        }
        
        for (i = 2; i < PKTTESTMAX; i++) {
                printf(".");
                for (j = 2; j < i; j++) {
                        txbuf[j] = ~txbuf[j];
                }
                while (spw_rx(0, rxbuf, spw)) {
                        for (k = 0; k < 64; k++) {}
                }
                while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                        for (k = 0; k < 64; k++) {}
                }
                if (rxs->truncated) {
                        printf("Received packet truncated\n");
                        exit(1);
                }
                if(rxs->eep) {
                        printf("Received packet terminated with eep\n");
                        exit(1);
                }
                if (*size != i) {
                        printf("Received packet has wrong length\n");
                        printf("Expected: %i, Got: %i \n", i, *size);
                }
                for(j = 0; j < i; j++) {
                        if (loadb((int)&(rxbuf[j])) != txbuf[j]) {
                                printf("Compare error: %u Data: %x Expected: %x \n", j, (unsigned)loadb((int)&(rxbuf[j])), (unsigned)txbuf[j]);
                        }
                }
        }
        
        
#endif
  
  
#if INITIATOR == 0 
        free(rxbuf);
#endif
        free(txbuf);
        printf("\n");
        printf("TEST 2: completed successfully\n\n");
#endif
/*   /\************************ TEST 3 **************************************\/ */
#if TEST3 == 1
        printf("TEST 3: Tx and Rx with varying size and alignment (if possible in configuration) from/to DMA channel\n\n");

        if ((txbuf = calloc(PKTTESTMAX, 1)) == NULL) {
                printf("Transmit buffer initialization failed\n");
                exit(1);
        }
        /*initialize data*/
        for (j = 0; j < PKTTESTMAX; j++) {
                txbuf[j] = (char)j;
        }
        txbuf[0] = 0x2;
        txbuf[1] = 0x2;

#if INITIATOR == 0 
        if ((rxbuf = calloc(PKTTESTMAX+4, 1)) == NULL) {
                printf("Receive buffer initialization failed\n");
                exit(1);
        }
#endif 
        for (i = 2; i < PKTTESTMAX; i++) {
                for(m = 1; m < 4; m++) {
                        printf(".");
                        for (j = 2; j < i; j++) {
                                txbuf[j] = ~txbuf[j];
                        }
                        
#if INITIATOR == 1      
                        if (spw_tx(0, 0, 0, 0, 0, txbuf, i, txbuf, spw)) {
                                printf("Transmission failed\n");
                                exit(1);
                        }
                        while (!(tmp = spw_checktx(0, spw))) {
                                for (k = 0; k < 64; k++) {}
                        }
                        if (tmp != 1) {
                                printf("Error in transmit \n");
                                exit(1);
                        }
#else
                        if ( (spw->rmap) == 0 && (spw->rxunaligned == 0) ) {
                                n = 0;
                        } else {
                                n = m;
                        }
                        
                        while (spw_rx(0, (char *)&(rxbuf[n]), spw)) {
                                for (k = 0; k < 64; k++) {}
                        }
                        
                        while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                                for (k = 0; k < 64; k++) {}
                        }
                        if (rxs->truncated) {
                                printf("Received packet truncated\n");
                                exit(1);
                        }
                        if(rxs->eep) {
                                printf("Received packet terminated with eep\n");
                                exit(1);
                        }
                        if (*size != i) {
                                printf("Received packet has wrong length\n");
                                printf("Expected: %i, Got: %i \n", i, *size);
                        }
                        for(j = 0; j < i; j++) {
                                if (loadb((int)&(rxbuf[j+n])) != txbuf[j]) {
                                        printf("Compare error: %u Data: %x Expected: %x \n", j, (unsigned)loadb((int)&(rxbuf[j+n])), (unsigned)txbuf[j]);
                                        exit(1);
                                }
                        }
#endif
                        /* printf("Packet %i transferred with alignment %i\n", i, m); */
                }
                
        }
#if INITIATOR == 0 
        free(rxbuf);
#endif
        free(txbuf);
        printf("\n");
        printf("TEST 3: completed successfully\n\n");

#endif
/*   /\************************ TEST 4 **************************************\/ */
#if TEST4 == 1
        printf("TEST 4: Tx from data pointer with varying alignment\n\n");
        if ((txbuf = calloc(PKTTESTMAX+4, 1)) == NULL) {
                printf("Transmit buffer initialization failed\n");
                exit(1);
        }
#if INITIATOR == 0        
        if ((rxbuf = calloc(PKTTESTMAX+256, 1)) == NULL) {
                printf("Receive buffer initialization failed\n");
                exit(1);
        }
#endif
        /*initialize data*/
        for (j = 0; j < PKTTESTMAX+4; j++) {
                txbuf[j] = (char)j;
        }
        for(i = 2; i < PKTTESTMAX; i++) {
                for(m = 0; m < 4; m++) {
                        printf(".");
                        for (j = 2; j < (i+m); j++) {
                                txbuf[j] = ~txbuf[j];
                        }
                        txbuf[m] = 0x2;
                        txbuf[m+1] = 0x2;
#if INITIATOR == 1
                        if (spw_tx(0, 0, 0, 0, 0, txbuf, i, (char *)&(txbuf[m]), spw)) {
                                printf("Transmission failed\n");
                                exit(1);
                        }
                        while (!(tmp = spw_checktx(0, spw))) {
                                for (k = 0; k < 64; k++) {}
                        }
                        if (tmp != 1) {
                                printf("Error in transmit \n");
                                exit(1);
                        }
#else
                        
                        while (spw_rx(0, rxbuf, spw)) {
                                for (k = 0; k < 64; k++) {}
                        }
                        while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                                for (k = 0; k < 64; k++) {}
                        }
                        if (rxs->truncated) {
                                printf("Received packet truncated\n");
                                exit(1);
                        }
                        if(rxs->eep) {
                                printf("Received packet terminated with eep\n");
                                exit(1);
                        }
                        if (*size != i) {
                                printf("Received packet has wrong length\n");
                                printf("Expected: %i, Got: %i \n", i, *size);
                        }
                        for(j = 0; j < i; j++) {
                                if (loadb((int)&(rxbuf[j])) != txbuf[j+m]) {
                                        printf("Compare error: %u Data: %x Expected: %x \n", j, (unsigned)loadb((int)&(rxbuf[j])), (unsigned)txbuf[j+m]);
                                        exit(1);
                                }
                        }
#endif
                        /* printf("Packet %i transferred with alignment %i\n", i, m); */
                }
                
        }
#if INITIATOR == 0 
        free(rxbuf);
#endif
        free(txbuf);
        printf("\n");
        printf("TEST 4: completed successfully\n\n");
#endif
  /************************ TEST 5 **************************************/
#if TEST5 == 1
        printf("TEST 5: Tx with header and data pointers with varying aligment on header \n\n");
        if ((txbuf = calloc(PKTTESTMAX+4, 1)) == NULL) {
                printf("Transmit buffer initialization failed\n");
                exit(1);
        }
        if ((tx0 = calloc(260, 1)) == NULL) {
                printf("Receive buffer initialization failed\n");
                exit(1);
        }
#if INITIATOR == 0
        if ((rxbuf = calloc(PKTTESTMAX+256, 1)) == NULL) {
                printf("Receive buffer initialization failed\n");
                exit(1);
        }
#endif
        /*initialize data*/
        for (j = 0; j < PKTTESTMAX; j++) {
                txbuf[j] = (char)j;
        }
        for (j = 0; j < 260; j++) {
                tx0[j] = (char)~j;
        }
        txbuf[0] = 0x2;
        txbuf[1] = 0x2;
        for(i = 0; i < 256; i++) {
                for(m = 0; m < 4; m++) {
                        printf(".");
                        for (j = 2; j < PKTTESTMAX; j++) {
                                txbuf[j] = ~txbuf[j];
                        }
                        for (j = 0; j < 260; j++) {
                                tx0[j] = ~tx0[j];
                        }
                        tx0[m] = 0x2;
                        tx0[m+1] = 0x2;
#if INITIATOR == 1                        
                        if (spw_tx(0, 0, 0, 0, i,(char *)&(tx0[m]), PKTTESTMAX, txbuf, spw)) {
                                printf("Transmission failed\n");
                                exit(1);
                        }
                        while (!(tmp = spw_checktx(0, spw))) {
                                for (k = 0; k < 64; k++) {}
                        }
                        if (tmp != 1) {
                                printf("Error in transmit \n");
                                exit(1);
                        }
#else
                        while (spw_rx(0, rxbuf, spw)) {
                                for (k = 0; k < 64; k++) {}
                        }
                        while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                                for (k = 0; k < 64; k++) {}
                        }
                        if (rxs->truncated) {
                                printf("Received packet truncated\n");
                                exit(1);
                        }
                        if(rxs->eep) {
                                printf("Received packet terminated with eep\n");
                                exit(1);
                        }
                        if (*size != (PKTTESTMAX+i)) {
                                printf("Received packet has wrong length\n");
                                printf("Expected: %i, Got: %i \n", i+PKTTESTMAX, *size);
                        }
                        for(j = 0; j < i; j++) {
                                if (loadb((int)&(rxbuf[j])) != tx0[j+m]) {
                                        printf("Compare error: %u Data: %x Expected: %x \n", j, (unsigned)loadb((int)&(rxbuf[j])), (unsigned)tx0[j+m]);
                                }
                        }
                        for(j = 0; j < PKTTESTMAX; j++) {
                                if (loadb((int)&(rxbuf[j+i])) != txbuf[j]) {
                                        printf("Compare error: %u Data: %x Expected: %x \n", j, (unsigned)loadb((int)&(rxbuf[j+i])), (unsigned)txbuf[j]);
                                }
                        }
#endif
                        /* printf("Packet %i transferred with alignment %i\n", i, m); */
                }
                
        }
#if INITIATOR == 0 
        free(rxbuf);
#endif
        free(txbuf);
        free(tx0);
        printf("\n");
        printf("TEST 5: completed successfully\n\n");
#endif
/*   /\************************ TEST 6 **************************************\/ */
#if TEST6 == 1
        printf("TEST 6: Tx with data and header both with varying alignment \n\n");
        if ((txbuf = calloc(PKTTESTMAX+4, 1)) == NULL) {
                printf("Transmit buffer initialization failed\n");
                exit(1);
        }
        if ((tx0 = calloc(260, 1)) == NULL) {
                printf("Receive buffer initialization failed\n");
                exit(1);
        }
#if INITIATOR == 0
        if ((rxbuf = calloc(PKTTESTMAX+256, 1)) == NULL) {
                printf("Receive buffer initialization failed\n");
                exit(1);
        }
#endif

        /*initialize data*/
        for (j = 0; j < PKTTESTMAX; j++) {
                txbuf[j] = (char)j;
        }
        for (j = 0; j < 260; j++) {
                tx0[j] = (char)~j;
        }
        notrx = 0;
        for(i = 0; i < 256; i++) {
                printf(".");
                /* printf("Packet with header %i, alignment: %i and data: %i, alignment: %i transferred\n", i, m, j, l); */
                for(j = 0; j < PKTTESTMAX; j++) {
                        for(m = 0; m < 4; m++) {
                                for(l = 0; l < 4; l++) {
                                        for (k = 0; k < PKTTESTMAX; k++) {
                                                txbuf[k] = ~txbuf[k];
                                        }
                                        for (k = 0; k < 260; k++) {
                                                tx0[k] = ~tx0[k];
                                        }
                                        tx0[m] = 0x2;
                                        tx0[m+1] = 0x2;
                                        txbuf[l] = 0x2;
                                        txbuf[l+1] = 0x2;
#if INITIATOR == 1 
                                        if (spw_tx(0, 0, 0, 0, i,(char *)&(tx0[m]), j, (char *)&(txbuf[l]), spw)) {
                                                printf("Transmission failed\n");
                                                exit(1);
                                        }
                                        while (!(tmp = spw_checktx(0, spw))) {
                                                for (k = 0; k < 64; k++) {}
                                        }
                                        if (tmp != 1) {
                                                printf("Error in transmit \n");
                                                exit(1);
                                        }
#else
                                        if (!notrx) {
                                                while (spw_rx(0, rxbuf, spw)) {
                                                        for (k = 0; k < 64; k++) {}
                                                }
                                        }
                                        if( (i+j) > 1) {
                                                while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                                                        for (k = 0; k < 64; k++) {}
                                                }
                                                if (rxs->truncated) {
                                                        printf("Received packet truncated\n");
                                                        exit(1);
                                                }
                                                if(rxs->eep) {
                                                        printf("Received packet terminated with eep\n");
                                                        exit(1);
                                                }
                                                if (*size != (j+i)) {
                                                        printf("Received packet has wrong length\n");
                                                        printf("Expected: %i, Got: %i \n", i+j, *size);
                                                }
                                                for(k = 0; k < i; k++) {
                                                        if (loadb((int)&(rxbuf[k])) != tx0[k+m]) {
                                                                printf("Compare error: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rxbuf[k])), (unsigned)tx0[k+m]);
                                                                exit(1);
                                                        }
                                                }
                                                for(k = 0; k < j; k++) {
                                                        if (loadb((int)&(rxbuf[k+i])) != txbuf[k+l]) {
                                                                printf("Compare error: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rxbuf[k+i])), (unsigned)txbuf[k+l]);
                                                                exit(1);
                                                        }
                                                }
                                                notrx = 0;
                                        } else {
                                                notrx = 1;
                                        }
#endif
                                }
                                
                        }
                }
        }
#if INITIATOR == 0 
        free(rxbuf);
#endif
        free(txbuf);
        free(tx0);
        printf("\n");
        printf("TEST 6: completed successfully\n\n");
#endif
/*   /\************************ TEST 7 **************************************\/ */
#if TEST7 == 1
        printf("TEST 7: Fill descriptor tables completely \n\n");
#if INITIATOR == 0 
        for(i = 0; i < 256; i++) {
                rx[i] = malloc(DESCPKT+256);
        }
#endif 
        for(i = 0; i < 256; i++) {
                tx[i] = malloc(DESCPKT);
        }
        txbuf = malloc(256);
        /*initialize data*/
        for(i = 0; i < 256; i++) {
                tx[i][0] = 0x2;
                tx[i][1] = 0x2;
                for(j = 2; j < DESCPKT; j++) {
                        tx[i][j] = j ^ i;
                }
        }
        txbuf[0] = 0x2;
        txbuf[1] = 0x2;
        for(i = 2; i < 256; i++) {
                txbuf[i] = i;
        }
#if INITIATOR == 1
        for(i = 0; i < 256; i++) {
                while (spw_tx(0, 0, 0, 0, 255, txbuf, DESCPKT, tx[i], spw)) {
                }
        }
        for(i = 0; i < 256; i++) {
                while (!(tmp = spw_checktx(0, spw))) {
                        for (k = 0; k < 64; k++) {}
                }
                if (tmp != 1) {
                        printf("Error in transmit \n");
                        exit(1);
                }
        }
#else
        for(i = 0; i < 256; i++) {
                while (spw_rx(0, rx[i], spw)) {
                        for (k = 0; k < 64; k++) {}
                }
        }
        for(i = 0; i < 256; i++) {
                while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                        for (k = 0; k < 64; k++) {}
                }
                if (rxs->truncated) {
                        printf("Received packet truncated\n");
                        exit(1);
                }
                if(rxs->eep) {
                        printf("Received packet terminated with eep\n");
                        exit(1);
                }
                if (*size != (255+DESCPKT)) {
                        printf("Received packet has wrong length\n");
                        printf("Expected: %i, Got: %i \n", 255+DESCPKT, *size);
                }
                for(k = 0; k < 255; k++) {
                        if (loadb((int)&(rx[i][k])) != txbuf[k]) {
                                printf("Txbuf: %x Rxbuf: %x\n", (int)txbuf, (int)rx[i]);
                                printf("Compare error: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx[i][k])), (unsigned)txbuf[k]);
                                exit(1);
                        }
                }
                for(k = 0; k < DESCPKT; k++) {
                        if (loadb((int)&(rx[i][k+255])) != tx[i][k]) {
                                printf("Compare error: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx[i][k+255])), (unsigned)tx[i][k]);
                                exit(1);
                        }
                }
        }
#endif
#if INITIATOR == 0
        for(i = 0; i < 256; i++) {
                free(rx[i]);
        }
#endif
        for(i = 0; i < 256; i++) {
                free(tx[i]);
        }
        free(txbuf);
        printf("TEST 7: completed successfully\n\n");
#endif

/*   /\************************ TEST 8 **************************************\/ */
#if TEST8 == 1
        printf("TEST 8: Transmission and reception of maximum size packets\n");
        spw->dma[0].rxmaxlen = MAXSIZE+4;
        if (spw_set_rxmaxlength(0, spw) ) {
                printf("Max length change failed\n");
                exit(1);
        }
        rxbuf = malloc(MAXSIZE);
        txbuf = malloc(MAXSIZE+1);
        tx0   = malloc(64);

#if INITIATOR == 0
	if ((rxbuf == NULL) || (txbuf == NULL) || (tx0 == NULL)) {
                printf("Memory allocation failed\n");
                exit(1);
        }
#else
        if ((txbuf == NULL) || (tx0 == NULL)) {
                printf("Memory allocation failed\n");
                exit(1);
        }
#endif
        txbuf[0] = 0x2;
        txbuf[1] = 0x2;
        for(i = 2; i < MAXSIZE; i++) {
                txbuf[i] = (i % 256);
        }
        printf("Maximum speed test started (several minutes can pass before the next output on screen)\n");
#if INITIATOR == 1
        t1 = clock();
        for (i = 0; i < 64; i++) {
                if (spw_tx(0, 0, 0, 0, 0, txbuf, MAXSIZE, txbuf, spw)) {
                        printf("Transmission failed\n");
                        exit(1);
                }
        }
        for (i = 0; i < 64; i++) {
                while (!(tmp = spw_checktx(0, spw))) {
                        for (k = 0; k < 64; k++) {}
                }
                if (tmp != 1) {
                        printf("Error in transmit \n");
                        exit(1);
                }
        }
#else
	for (i = 0; i < 64; i++) {
                while (spw_rx(0, rxbuf, spw)) {
                        for (k = 0; k < 64; k++) {}
                }
        }
        t1 = clock();
        for (i = 0; i < 64; i++) {
                while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                        for (k = 0; k < 64; k++) {}
                }
                if (rxs->truncated) {
                        printf("Received packet truncated\n");
                        exit(1);
                }
                if(rxs->eep) {
                        printf("Received packet terminated with eep\n");
                        exit(1);
                }
                if (*size != (MAXSIZE)) {
                        printf("Received packet has wrong length\n");
                        printf("Expected: %i, Got: %i \n", MAXSIZE, *size);
                }
        }
        /* The same buffer is used for all descriptors so check is done only once*/
        for(k = 0; k < MAXSIZE; k++) {
                if (loadb((int)&(rxbuf[k])) != txbuf[k]) {
                        printf("Compare error: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rxbuf[k])), (unsigned)txbuf[k]);
                        exit(1);
                }
        }
#endif
        t2 = clock();
        printf("\n");
        t2 = t2 - t1;
        t3 = t2/CLOCKS_PER_SEC;
        bitrate = MAXSIZE/(t3*1000);
        bitrate = bitrate*64*8;
        bitrate /= 1000.0;
        printf("Effective bitrate: %3.1f Mbit/s\n", bitrate);
        printf("Maximum speed test full-duplex started (several minutes can pass before the next output on screen)\n");
        tx0[0] = 0x1;
        tx0[1] = 0x2;
        for(i = 2; i < MAXSIZE; i++) {
                txbuf[i] = ~((txbuf[i]+i) % 256);
        }
        for (i = 0; i < 64; i++) {
                while (spw_rx(0, rxbuf, spw)) {
                        for (k = 0; k < 64; k++) {}
                }
        }
#if INITIATOR == 1        
        spw->dma[0].rxmaxlen = MAXSIZE+4;
        if (spw_set_rxmaxlength(0, spw)) {
                printf("Max length change failed\n");
                exit(1);
        }
#endif
        t1 = clock();
        for (i = 0; i < 64; i++) {
#if INITIATOR == 1 
                if (spw_tx(0, 0, 0, 0, 0, txbuf, MAXSIZE, txbuf, spw)) {
                        printf("Transmission failed link 1\n");
                        exit(1);
                }
#else
                if (spw_tx(0, 0, 0, 0, 2, tx0, MAXSIZE-2, txbuf, spw)) {
                        printf("Transmission failed link 2\n");
                        exit(1);
                }
#endif
        }
        for (i = 0; i < 64; i++) {
                while (!(tmp = spw_checktx(0, spw))) {
                        for (k = 0; k < 64; k++) {}
                }
                if (tmp != 1) {
                        printf("Error in transmit \n");
                        exit(1);
                }
        }
        t2 = clock();
        for (i = 0; i < 64; i++) {
                while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                        for (k = 0; k < 64; k++) {}
                }
                if (rxs->truncated) {
                        printf("Received packet truncated\n");
                        exit(1);
                }
                if(rxs->eep) {
                        printf("Received packet terminated with eep\n");
                        exit(1);
                }
                if (*size != (MAXSIZE)) {
                        printf("Received packet has wrong length\n");
                        printf("Expected: %i, Got: %i \n", MAXSIZE, *size);
                }
        }
        /* The same buffer is used for all descriptors so check is done only once*/
#if INITIATOR == 0
        for(k = 0; k < MAXSIZE; k++) {
                if (loadb((int)&(rxbuf[k])) != txbuf[k]) {
                        printf("Compare error: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rxbuf[k])), (unsigned)txbuf[k]);
                        exit(1);
                }
        }
#else
        for(k = 0; k < 2; k++) {
                if (loadb((int)&(rxbuf[k])) != tx0[k]) {
                        printf("Compare error: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rxbuf[k])), (unsigned)tx0[k]);
                        exit(1);
                }
        }
        for(k = 2; k < MAXSIZE; k++) {
                if (loadb((int)&(rxbuf[k])) != txbuf[k-2]) {
                        printf("Compare error: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rxbuf[k])), (unsigned)txbuf[k-2]);
                        exit(1);
                }
        }
#endif
        printf("\n");
        t2 = t2 - t1;
        t3 = t2/CLOCKS_PER_SEC;
        bitrate = MAXSIZE/(t3*1000);
        bitrate = bitrate*128*8;
        bitrate /= 1000.0;
        printf("Effective bitrate: %3.1f Mbit/s\n", bitrate);

        for(i = 2; i < MAXSIZE; i++) {
                txbuf[i] = ~txbuf[i];
        }

        spw->dma[0].rxmaxlen = MAXSIZE;
        if (spw_set_rxmaxlength(0, spw) ) {
                printf("Max length change failed\n");
                exit(1);
        }
        maxlen = loadmem((int)&(spw->regs->dma[0].rxmaxlen));
        printf("Maxlen: %d\n", maxlen);
#if INITIATOR == 1
        if ((ret = spw_tx(0, 0, 0, 0, 2, txbuf, maxlen-1, txbuf, spw))) {
                printf("Transmission failed: %d\n", ret);
                exit(1);
        }
        while (!(tmp = spw_checktx(0, spw))) {
                for (k = 0; k < 64; k++) {}
        }
        if (tmp != 1) {
                printf("Error in transmit \n");
                exit(1);
        }
#else
        while (spw_rx(0, rxbuf, spw)) {
                for (k = 0; k < 64; k++) {}
        }
        
        while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                for (k = 0; k < 64; k++) {}
        }
        if (!rxs->truncated) {
                printf("Received packet not truncated\n");
                exit(1);
        }
        if(rxs->eep) {
                printf("Received packet terminated with eep\n");
                exit(1);
        }
        if (*size != (maxlen)) {
                printf("Received packet has wrong length\n");
                printf("Expected: %i, Got: %i \n", maxlen, *size);
        }
        for(k = 0; k < 2; k++) {
                if (loadb((int)&(rxbuf[k])) != txbuf[k]) {
                        printf("Compare error: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rxbuf[k])), (unsigned)txbuf[k]);
                        exit(1);
                }
        }
        for(k = 0; k < maxlen-2; k++) {
                if (loadb((int)&(rxbuf[k+2])) != txbuf[k]) {
                        printf("Compare error: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rxbuf[k+2])), (unsigned)txbuf[k]);
                        exit(1);
                }
        }
#endif
        for(i = 2; i < MAXSIZE; i++) {
                txbuf[i] = ~txbuf[i];
        }
        printf("\n");
        spw->dma[0].rxmaxlen = maxlen+4;
        if (spw_set_rxmaxlength(0, spw) ) {
                printf("Max length change failed\n");
                exit(1);
        }
#if INITIATOR == 0 
        if (spw_tx(0, 0, 0, 0, 2, tx0, maxlen-1, txbuf, spw)) {
                printf("Transmission failed\n");
                exit(1);
        }
        while (!(tmp = spw_checktx(0, spw))) {
                for (k = 0; k < 64; k++) {}
        }
        if (tmp != 1) {
                printf("Error in transmit \n");
                exit(1);
        }
#else
        while (spw_rx(0, rxbuf, spw)) {
                for (k = 0; k < 64; k++) {}
        }
        while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                for (k = 0; k < 64; k++) {}
        }
        if (rxs->truncated) {
                printf("Received packet truncated\n");
                exit(1);
        }
        if(rxs->eep) {
                printf("Received packet terminated with eep\n");
                exit(1);
        }
        if (*size != (maxlen+1)) {
                printf("Received packet has wrong length\n");
                printf("Expected: %i, Got: %i \n", maxlen+1, *size);
        }
        for(k = 0; k < 2; k++) {
                if (loadb((int)&(rxbuf[k])) != tx0[k]) {
                        printf("Compare error: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rxbuf[k])), (unsigned)tx0[k]);
                        exit(1);
                }
        }
        for(k = 0; k < maxlen-2; k++) {
                if (loadb((int)&(rxbuf[k+2])) != txbuf[k]) {
                        printf("Compare error: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rxbuf[k+2])), (unsigned)txbuf[k]);
                        exit(1);
                }
        }
#endif
        free(rxbuf);
        free(txbuf);
        free(tx0);
  printf("TEST 8: completed successfully\n");
#endif
/*   /\************************ TEST 9 **************************************\/ */

/* OBS!!!!! Both cores must have RMAP crc support for this test to work, there
   is no way to detect this so check this manually and enable the test if the
   requirement is fulfilled */
#if TEST9 == 1
  printf("TEST 9: RMAP CRC for DMA channel(random data) \n\n");
  if ((spw->rmap == 1) || (spw->rmapcrc == 1)) {
          
          if ((txbuf = calloc(PKTTESTMAX+4, 1)) == NULL) {
                  printf("Transmit buffer initialization failed\n");
                  exit(1);
          }
          if ((tx0 = calloc(260, 1)) == NULL) {
                  printf("Receive buffer initialization failed\n");
                  exit(1);
          }
#if INITIATOR == 0 
          if ((rxbuf = calloc(PKTTESTMAX+256+2, 1)) == NULL) {
                  printf("Receive buffer initialization failed\n");
                  exit(1);
          }
#endif  
          /*initialize data*/
          for (j = 0; j < PKTTESTMAX; j++) {
                  txbuf[j] = (char)j;
          }
          for (j = 0; j < 260; j++) {
                  tx0[j] = (char)~j;
          }
          notrx = 0; data = 0; hdr = 0;
          for(i = 0; i < 256; i++) {
                  printf(".");
                  for(j = 0; j < PKTTESTMAX; j++) {
                          for(m = 0; m < 4; m++) {
                                  for(l = 0; l < 4; l++) {
                                          /* printf("h %i, a: %i d: %i, a: %i\n", i, m, j, l);  */
                                          for (k = 0; k < PKTTESTMAX; k++) {
                                                  txbuf[k] = ~txbuf[k];
                                          }
                                          for (k = 0; k < 260; k++) {
                                                  tx0[k] = ~tx0[k];
                                          }
                                          if (i != 0) {
                                                  hdr = 1;
                                          } else {
                                                  hdr = 0;
                                          }
                                          if ((i != 0) || (j != 0)) {
                                                  data = 1;
                                          } else {
                                                  data = 0;
                                          }
                                          tx0[m] = 0x2;
                                          tx0[m+1] = 0x2;
                                          txbuf[l] = 0x2;
                                          txbuf[l+1] = 0x2;
#if INITIATOR == 1
                                          if (spw_tx(0, hdr, 1, 0, i,(char *)&(tx0[m]), j, (char *)&(txbuf[l]), spw)) {
                                                  printf("Transmission failed\n");
                                                  exit(1);
                                          }
                                          while (!(tmp = spw_checktx(0, spw))) {
                                                  for (k = 0; k < 64; k++) {}
                                          }
                                          if (tmp != 1) {
                                                  printf("Error in transmit \n");
                                                  exit(1);
                                          }
#else
                                          if (!notrx) {
                                                  while (spw_rx(0, rxbuf, spw)) {
                                                          for (k = 0; k < 64; k++) {}
                                                  }
                                          }
                                          if( (i+j+hdr+data) > 1) {
                                                  while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                                                          for (k = 0; k < 64; k++) {}
                                                  }
                                                  if (rxs->truncated) {
                                                          printf("Received packet truncated\n");
                                                          exit(1);
                                                  }
                                                  if(rxs->eep) {
                                                          printf("Received packet terminated with eep\n");
                                                          exit(1);
                                                  }
                                                  if (*size != (j+i+hdr+data)) {
                                                          printf("Received packet has wrong length\n");
                                                          printf("Expected: %i, Got: %i \n", i+j, *size);
                                                  }
                                                  for(k = 0; k < i; k++) {
                                                          if (loadb((int)&(rxbuf[k])) != tx0[k+m]) {
                                                                  printf("Compare error: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rxbuf[k])), (unsigned)tx0[k+m]);
                                                                  exit(1);
                                                          }
                                                  }
                                                  for(k = 0; k < j; k++) {
                                                          if (loadb((int)&(rxbuf[k+i+hdr])) != txbuf[k+l]) {
                                                                  printf("Compare error: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rxbuf[k+i+hdr])), (unsigned)txbuf[k+l]);
                                                                  exit(1);
                                                          }
                                                  }
                                                  notrx = 0;
                                          } else {
                                                  notrx = 1;
                                          }
#endif
                                  }
                          
                          }
                  }
          }
#if INITIATOR == 0
          free(rxbuf);
#endif
          free(txbuf);
          free(tx0);
          printf("\n");
  }
  printf("TEST: 9 completed successfully\n\n");
#endif
/*   /\************************ TEST 10 **************************************\/ */
#if TEST10==1
/* Only the target needs to have RMAP target in hardware. The initiator handles
   commands and replies in software */
  printf("TEST 10: RMAP and transmit spa test\n");
#if INITIATOR == 0
  /* enable rmap*/
  spw_rmapen(spw);
#endif
#if INITIATOR == 1
  tx0 = (char *)malloc(64);
  tx1 = (char *)calloc(RMAPSIZE, 1);
  rx0 = (char *)malloc(RMAPSIZE+4);
  rx1 = (char *)malloc(32+RMAPSIZE);
  rx2 = (char *)malloc(32+RMAPSIZE);
  if( (tx0 == NULL) || (tx1 == NULL) || (rx0 == NULL) ||
      (rx1 == NULL) || (rx2 == NULL) ) {
          printf("Memory initialization error\n");
          exit(1);
  }
  
  printf("\nNon verified writes\n");

  for(i = 0; i < RMAPSIZE; i++) {
          printf(".");
          for(m = 0; m < 8; m++) {
                  /* send write command */
                  for(j = 0; j < i; j++) {
                          tx1[j]  = ~tx1[j];
                  }
                  if (m >= 4) {
                          cmd->incr     = no;
                  } else {
                          cmd->incr     = yes;
                  }
                  cmd->type     = writecmd;
                  cmd->verify   = no;
                  cmd->ack      = yes;
                  cmd->destaddr = 0x2;
                  cmd->destkey  = 0xBF;
                  cmd->srcaddr  = 0x1;
                  cmd->tid      = i;
                  cmd->addr     = (int)&(rx0[(m%4)]);
                  cmd->len      = i;
                  cmd->status   = 0;
                  cmd->dstspalen = 0;
                  cmd->dstspa  = (char *)NULL;
                  cmd->srcspalen = 0;
                  cmd->srcspa = (char *)NULL;
                  if (build_rmap_hdr(cmd, tx0, cmdsize)) {
                          printf("RMAP cmd build failed\n");
                          exit(1);
                  }
                  reply->type     = writerep;
                  reply->verify   = no;
                  reply->ack      = yes;
                  if (m >= 4) {
                          reply->incr     = no;
                          if ( ((((int)&(rx0[(m%4)])) % 4) != 0) || ((cmd->len % 4) != 0) )  {
                                  reply->status   = 10;
                          } else {
                                  reply->status   = 0;
                          }
                  } else {
                          reply->incr     = yes;
                          reply->status   = 0;
                  }
                  reply->destaddr = 0x2;
                  reply->destkey  = 0XBF;
                  reply->srcaddr  = 0x1;
                  reply->tid      = i;
                  reply->addr     = (int)&(rx0[(m%4)]);
                  reply->len      = i;
                  reply->dstspalen = 0;
                  reply->dstspa  = (char *)NULL;
                  reply->srcspalen = 0;
                  reply->srcspa = (char *)NULL;
                  if (build_rmap_hdr(reply, rx2, replysize)) {
                          printf("RMAP reply build failed\n");
                          exit(1);
                  }
                  while (spw_rx(0, rx1, spw)) {
                          for (k = 0; k < 64; k++) {}
                  }
                  if (spw_tx(0, 1, 1, 0, *cmdsize, tx0, j, tx1, spw)) {
                          printf("Transmission failed\n");
                          exit(1);
                  }
                  while (!(tmp = spw_checktx(0, spw))) {
                          for (k = 0; k < 64; k++) {}
                  }
                  if (tmp != 1) {
                          printf("Error in transmit \n");
                          exit(1);
                  }
                  iterations = 0;
                  while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                          if (iterations > 1000) {
                                  printf("ERROR: Time limit exceeded while waiting for RMAP reply\n");
                                  exit(0);
                          }
                          for (k = 0; k < 64; k++) {}
                          /* printf("0x%x\n", spw2->regs->status);*/
                          iterations++;
                  }
                  if (rxs->truncated) {
                          printf("Received packet truncated\n");
                          exit(1);
                  }
                  if(rxs->eep) {
                          printf("Received packet terminated with eep\n");
                          exit(1);
                  }
                  if(rxs->hcrcerr) {
                          printf("Received packet header crc error detected\n");
                          exit(1);
                  }
                  if(rxs->dcrcerr) {
                          printf("Received packet data crc error detected\n");
                          exit(1);
                  }
                  if (*size != (*replysize+1)) {
                          printf("Received packet has wrong length\n");
                          printf("Expected: %i, Got: %i \n", *replysize+1, *size);
                  }
                  for(k = 0; k < *replysize; k++) {
                          if (loadb((int)&(rx1[k])) != rx2[k]) {
                                  printf("Compare error 0: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[k])), (unsigned)rx2[k]);
                                  exit(1);
                          }
                  }
                  
                  if (m >= 4) {
                          cmd->incr     = no;
                  } else {
                          cmd->incr     = yes;
                  }
                  cmd->type     = readcmd;
                  cmd->verify   = no;
                  cmd->ack      = yes;
                  cmd->destaddr = 0x2;
                  cmd->destkey  = 0xBF;
                  cmd->srcaddr  = 0x1;
                  cmd->tid      = i;
                  cmd->addr     = (int)&(rx0[(m%4)]);
                  cmd->len      = i;
                  cmd->status   = 0;
                  cmd->dstspalen = 0;
                  cmd->dstspa  = (char *)NULL;
                  cmd->srcspalen = 0;
                  cmd->srcspa = (char *)NULL;
                  if (build_rmap_hdr(cmd, tx0, cmdsize)) {
                          printf("RMAP cmd build failed\n");
                          exit(1);
                  }
                  reply->type     = readrep;
                  reply->verify   = no;
                  reply->ack      = yes;
                  if (m >= 4) {
                          reply->incr     = no;
                          if ( ((((int)&(rx0[(m%4)])) % 4) != 0) || ((cmd->len % 4) != 0) )  {
                                  reply->status   = 10;
                          } else {
                                  reply->status   = 0;
                          }
                  } else {
                          reply->incr     = yes;
                          reply->status   = 0;
                  }
                  if (reply->status == 0) {
                          reply->len      = i;
                  } else {
                          reply->len      = 0;
                  }
                  reply->destaddr = 0x2;
                  reply->destkey  = 0xBF;
                  reply->srcaddr  = 0x1;
                  reply->tid      = i;
                  reply->addr     = (int)&(rx0[(m%4)]);
                  reply->dstspalen = 0;
                  reply->dstspa  = (char *)NULL;
                  reply->srcspalen = 0;
                  reply->srcspa = (char *)NULL;
                  if (build_rmap_hdr(reply, rx2, replysize)) {
                          printf("RMAP reply build failed\n");
                          exit(1);
                  }
                  while (spw_rx(0, rx1, spw)) {
                          for (k = 0; k < 64; k++) {}
                  }
                  if (spw_tx(0, 1, 0, 0, *cmdsize, tx0, 0, tx1, spw)) {
                          printf("Transmission failed\n");
                          exit(1);
                  }
                  while (!(tmp = spw_checktx(0, spw))) {
                          for (k = 0; k < 64; k++) {}
                  }
                  if (tmp != 1) {
                          printf("Error in transmit \n");
                          exit(1);
                  }
                  iterations = 0;
                  while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                          if (iterations > 1000) {
                                  printf("ERROR: Time limit exceeded while waiting for RMAP reply\n");
                                  exit(0);
                          }
                          for (k = 0; k < 64; k++) {}
                          /* printf("0x%x\n", spw2->regs->status);*/
                          iterations++;
                  }
                  if (rxs->truncated) {
                          printf("Received packet truncated\n");
                          exit(1);
                  }
                  if(rxs->eep) {
                          printf("Received packet terminated with eep\n");
                          exit(1);
                  }
                  if(rxs->hcrcerr) {
                          printf("Received packet header crc error detected\n");
                          exit(1);
                  }
                  if(rxs->dcrcerr) {
                          printf("Received packet data crc error detected\n");
                          exit(1);
                  }
                  for (k = 0; k < *replysize; k++) {
                          if (loadb((int)&(rx1[k])) != rx2[k]) {
                                  printf("Compare error 0: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[k])), (unsigned)rx2[k]);
                                  exit(1);
                          }
                  }
                  if ((reply->status) == 0 && (i != 0)) {
                          if (*size != (*replysize+2+i)) {
                                  printf("Received packet has wrong length\n");
                                  printf("Expected: %i, Got: %i \n", *replysize+2+i, *size);
                          }
                          if (cmd->incr == yes) {
                                  for(k = 0; k < i; k++) {
                                          if (loadb((int)&(rx1[*replysize+1+k])) != tx1[k]) {
                                                  printf("Compare error 1: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[*replysize+1+k])), (unsigned)tx1[k]);
                                                  exit(1);
                                          }
                                  }
                          } else {
                                  for(k = 0; k < i; k++) {
                                          if (loadb((int)&(rx1[*replysize+1+k])) != tx1[((i/4)-1)*4+(k%4)]) {
                                                  printf("Compare error 2: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[*replysize+1+k])), (unsigned)tx1[(i/4)*4+(k%4)]);
                                                  printf("Rx1: %x, Rx0: %x\n", (int)rx1, (int)rx0);
                                                  //exit(1);
                                          }
                                  }
                          }
                  } else {
                          if (*size != (*replysize+2)) {
                                  printf("Received packet has wrong length\n");
                                  printf("Expected: %i, Got: %i \n", *replysize+2, *size);
                          }
                  }
          }
  }
  printf("\n");
  printf("Non-verified write test passed\n");


  printf("\nVerified writes\n");
  for(i = 0; i < 64; i++) {
          printf(".");
          for(m = 0; m < 8; m++) {
                  for(j = 0; j < i; j++) {
                          tx1[j]  = ~tx1[j];
                  }
                  if (m >= 4) {
                          cmd->incr     = no;
                  } else {
                          cmd->incr     = yes;
                  }
                  cmd->type     = writecmd;
                  cmd->verify   = yes;
                  cmd->ack      = yes;
                  cmd->destaddr = 0x2;
                  cmd->destkey  = 0xBF;
                  cmd->srcaddr  = 0x1;
                  cmd->tid      = i;
                  cmd->addr     = (int)&(rx0[(m%4)]);
                  cmd->len      = i;
                  cmd->status   = 0;
                  cmd->dstspalen = 0;
                  cmd->dstspa  = (char *)NULL;
                  cmd->srcspalen = 0;
                  cmd->srcspa = (char *)NULL;
                  if (build_rmap_hdr(cmd, tx0, cmdsize)) {
                          printf("RMAP cmd build failed\n");
                          exit(1);
                  }
                  reply->type     = writerep;
                  reply->verify   = yes;
                  reply->ack      = yes;
                  if (m >= 4) {
                          reply->incr     = no;
                          
                  } else {
                          reply->incr     = yes;
                  }
                  if ( (((((int)&(rx0[(m%4)])) % 2) != 0) && (cmd->len == 2)) ||
                       (((((int)&(rx0[(m%4)])) % 4) != 0) && (cmd->len == 4)) ||
                       (cmd->len == 3) ) {
                          reply->status   = 10;
                  } else {
                          reply->status   = 0;
                  }
                  if (cmd->len > 4) {
                          reply->status = 9;
                          
                  }
                  reply->destaddr = 0x2;
                  reply->destkey  = 0XBF;
                  reply->srcaddr  = 0x1;
                  reply->tid      = i;
                  reply->addr     = (int)&(rx0[(m%4)]);
                  reply->len      = i;
                  reply->dstspalen = 0;
                  reply->dstspa  = (char *)NULL;
                  reply->srcspalen = 0;
                  reply->srcspa = (char *)NULL;
                  if (build_rmap_hdr(reply, rx2, replysize)) {
                          printf("RMAP reply build failed\n");
                          exit(1);
                  }
                  while (spw_rx(0, rx1, spw)) {
                          for (k = 0; k < 64; k++) {}
                  }
                  if (spw_tx(0, 1, 1, 0, *cmdsize, tx0, j, tx1, spw)) {
                          printf("Transmission failed\n");
                          exit(1);
                  }
                  while (!(tmp = spw_checktx(0, spw))) {
                          for (k = 0; k < 64; k++) {}
                  }
                  if (tmp != 1) {
                          printf("Error in transmit \n");
                          exit(1);
                  }
                  iterations = 0;
                  while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                          if (iterations > 1000) {
                                  printf("ERROR: Time limit exceeded while waiting for RMAP reply\n");
                                  exit(0);
                          }
                          for (k = 0; k < 64; k++) {}
                          /* printf("0x%x\n", spw2->regs->status);*/
                          iterations++;
                  }
                  if (rxs->truncated) {
                          printf("Received packet truncated\n");
                          exit(1);
                  }
                  if(rxs->eep) {
                          printf("Received packet terminated with eep\n");
                          exit(1);
                  }
                  if(rxs->hcrcerr) {
                          printf("Received packet header crc error detected\n");
                          exit(1);
                  }
                  if(rxs->dcrcerr) {
                          printf("Received packet data crc error detected\n");
                          exit(1);
                  }
                  if (*size != (*replysize+1)) {
                          printf("Received packet has wrong length0\n");
                          printf("Expected: %i, Got: %i \n", *replysize+1, *size);
                          exit(1);
                  }
                  for(k = 0; k < *replysize; k++) {
                          if (loadb((int)&(rx1[k])) != rx2[k]) {
                                  printf("Compare error 0: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[k])), (unsigned)rx2[k]);
                                  exit(1);
                          }
                  }
                  
                  
                  if (reply->status == 0) {
                          cmd->type     = readcmd;
                          cmd->incr     = yes;
                          cmd->verify   = no;
                          cmd->ack      = yes;
                          cmd->destaddr = 0x2;
                          cmd->destkey  = 0xBF;
                          cmd->srcaddr  = 0x1;
                          cmd->tid      = i;
                          cmd->addr     = (int)&(rx0[(m%4)]);
                          cmd->len      = i;
                          cmd->status   = 0;
                          cmd->dstspalen = 0;
                          cmd->dstspa  = (char *)NULL;
                          cmd->srcspalen = 0;
                          cmd->srcspa = (char *)NULL;
                          if (build_rmap_hdr(cmd, tx0, cmdsize)) {
                                  printf("RMAP cmd build failed\n");
                                  exit(1);
                          }
                          reply->type     = readrep;
                          reply->verify   = no;
                          reply->ack      = yes;
                          reply->status   = 0;
                          reply->incr     = yes;
                          
                          if (reply->status == 0) {
                                  reply->len      = i;
                          } else {
                                  reply->len      = 0;
                          }
                          reply->destaddr = 0x2;
                          reply->destkey  = 0xBF;
                          reply->srcaddr  = 0x1;
                          reply->tid      = i;
                          reply->addr     = (int)&(rx0[(m%4)]);
                          reply->dstspalen = 0;
                          reply->dstspa  = (char *)NULL;
                          reply->srcspalen = 0;
                          reply->srcspa = (char *)NULL;
                          if (build_rmap_hdr(reply, rx2, replysize)) {
                                  printf("RMAP reply build failed\n");
                                  exit(1);
                          }
                          while (spw_rx(0, rx1, spw)) {
                                  for (k = 0; k < 64; k++) {}
                          }
                          if (spw_tx(0, 1, 0, 0, *cmdsize, tx0, 0, tx1, spw)) {
                                  printf("Transmission failed\n");
                                  exit(1);
                          }
                          while (!(tmp = spw_checktx(0, spw))) {
                                  for (k = 0; k < 64; k++) {}
                          }
                          if (tmp != 1) {
                                  printf("Error in transmit \n");
                                  exit(1);
                          }
                          iterations = 0;
                          while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                                  if (iterations > 1000) {
                                          printf("ERROR: Time limit exceeded while waiting for RMAP reply\n");
                                          exit(0);
                                  }
                                  for (k = 0; k < 64; k++) {}
                                  /* printf("0x%x\n", spw2->regs->status);*/
                                  iterations++;
                          }
                          if (rxs->truncated) {
                                  printf("Received packet truncated\n");
                                  exit(1);
                          }
                          if(rxs->eep) {
                                  printf("Received packet terminated with eep\n");
                                  exit(1);
                          }
                          if(rxs->hcrcerr) {
                                  printf("Received packet header crc error detected\n");
                                  exit(1);
                          }
                          if(rxs->dcrcerr) {
                                  printf("Received packet data crc error detected\n");
                                  exit(1);
                          }
                          for (k = 0; k < *replysize; k++) {
                                  if (loadb((int)&(rx1[k])) != rx2[k]) {
                                          printf("Compare error 1: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[k])), (unsigned)rx2[k]);
                                          exit(1);
                                  }
                          }
                          if ((reply->status) == 0 && (i != 0)) {
                                  if (*size != (*replysize+2+i)) {
                                          printf("Received packet has wrong length1\n");
                                          printf("Expected: %i, Got: %i \n", *replysize+2+i, *size);
                                  }
                                  for(k = 0; k < i; k++) {
                                          if (loadb((int)&(rx1[*replysize+1+k])) != tx1[k]) {
                                                  printf("Compare error 2: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[*replysize+1+k])), (unsigned)tx1[k]);
                                                  exit(1);
                                          }
                                  }
                                  
                          } else {
                                  if (*size != (*replysize+2)) {
                                          printf("Received packet has wrong length2\n");
                                          printf("Expected: %i, Got: %i \n", *replysize+2, *size);
                                  }
                          }
                  } 
/* if (((i % 4) == 0) && ((m % 8) == 0)) { */
/*           printf("Packet  %i, alignment %i\n", i, m); */
/*         } */
          }
  }
  printf("\n");
  printf("Verified write test passed\n");


  printf("\nRMW\n");

  /* Get initial contents of memory */
  cmd->type     = readcmd;
  cmd->incr     = yes;
  cmd->verify   = no;
  cmd->ack      = yes;
  cmd->destaddr = 0x2;
  cmd->destkey  = 0xBF;
  cmd->srcaddr  = 0x1;
  cmd->tid      = 1400;
  cmd->addr     = (int)&(rx0[0]);
  cmd->len      = 4;
  cmd->status   = 0;
  cmd->dstspalen = 0;
  cmd->dstspa  = (char *)NULL;
  cmd->srcspalen = 0;
  cmd->srcspa = (char *)NULL;
  if (build_rmap_hdr(cmd, tx0, cmdsize)) {
          printf("RMAP cmd build failed\n");
          exit(1);
  }
  reply->type     = readrep;
  reply->verify   = no;
  reply->ack      = yes;
  reply->status   = 0;
  reply->incr     = yes;
  
  reply->len      = 4;
  reply->destaddr = 0x2;
  reply->destkey  = 0xBF;
  reply->srcaddr  = 0x1;
  reply->tid      = 1400;
  reply->addr     = (int)&(rx0[0]);
  reply->dstspalen = 0;
  reply->dstspa  = (char *)NULL;
  reply->srcspalen = 0;
  reply->srcspa = (char *)NULL;
  if (build_rmap_hdr(reply, rx2, replysize)) {
          printf("RMAP reply build failed\n");
          exit(1);
  }
  while (spw_rx(0, rx1, spw)) {
          for (k = 0; k < 64; k++) {}
  }
  if (spw_tx(0, 1, 0, 0, *cmdsize, tx0, 0, tx1, spw)) {
          printf("Transmission failed\n");
          exit(1);
  }
  while (!(tmp = spw_checktx(0, spw))) {
          for (k = 0; k < 64; k++) {}
  }
  if (tmp != 1) {
          printf("Error in transmit \n");
          exit(1);
  }
  iterations = 0;
  while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
          if (iterations > 1000) {
                  printf("ERROR: Time limit exceeded while waiting for RMAP reply\n");
                  exit(0);
          }
          for (k = 0; k < 64; k++) {}
          /* printf("0x%x\n", spw2->regs->status);*/
          iterations++;
  }
  if (rxs->truncated) {
          printf("Received packet truncated\n");
          exit(1);
  }
  if(rxs->eep) {
          printf("Received packet terminated with eep\n");
          exit(1);
  }
  if(rxs->hcrcerr) {
          printf("Received packet header crc error detected\n");
          exit(1);
  }
  if(rxs->dcrcerr) {
          printf("Received packet data crc error detected\n");
          exit(1);
  }
  for (k = 0; k < *replysize; k++) {
          if (loadb((int)&(rx1[k])) != rx2[k]) {
                  printf("Compare error 0: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[k])), (unsigned)rx2[k]);
                  exit(1);
          }
  }
  if (*size != (*replysize+2+4)) {
          printf("Received packet has wrong length1\n");
          printf("Expected: %i, Got: %i \n", *replysize+2+i, *size);
  }
  for(k = 0; k < 4; k++) {
          rxdata[k] = loadb((int)&(rx1[*replysize+1+k]));
  }
                                  
  for(i = 0; i < 64; i++) {
          printf(".");
          for(m = 0; m < 8; m++) {
                  for(j = 0; j < i; j++) {
                          tx1[j]  = ~tx1[j];
                  }
                  if (m >= 4) {
                          cmd->incr     = no;
                  } else {
                          cmd->incr     = yes;
                  }
                  cmd->type     = rmwcmd;
                  cmd->verify   = yes;
                  cmd->ack      = yes;
                  cmd->destaddr = 0x2;
                  cmd->destkey  = 0xBF;
                  cmd->srcaddr  = 0x1;
                  cmd->tid      = i;
                  cmd->addr     = (int)&(rx0[(m%4)]);
                  cmd->len      = i;
                  cmd->status   = 0;
                  cmd->dstspalen = 0;
                  cmd->dstspa  = (char *)NULL;
                  cmd->srcspalen = 0;
                  cmd->srcspa = (char *)NULL;
                  if (build_rmap_hdr(cmd, tx0, cmdsize)) {
                          printf("RMAP cmd build failed\n");
                          exit(1);
                  }
                  reply->type     = rmwrep;
                  reply->verify   = yes;
                  reply->ack      = yes;
                  if (m >= 4) {
                          reply->incr     = no;
                  } else {
                          reply->incr     = yes;
                  }
                  if ( (((((int)&(rx0[(m%4)])) % 2) != 0) && ((cmd->len/2) == 2)) ||
                       (((((int)&(rx0[(m%4)])) % 4) != 0) && ((cmd->len/2) == 4)) ||
                       ((cmd->len/2) == 3) ) {
                          reply->status   = 10;
                  } else {
                          reply->status   = 0;
                  }
                  if ( (cmd->len != 0) && (cmd->len != 2) && (cmd->len != 4) &&
                       (cmd->len != 6) && (cmd->len != 8)) {
                          reply->status = 11;
                  }
                  if (m >= 4) {
                          reply->status = 2;
                  }
                  if (reply->status == 0) {
                          for(k = 0; k < (i/2); k++) {
                                  rx2[*replysize+1+k] = loadb((int)&(rx0[k+m]));
                          }
                  }
                  reply->destaddr = 0x2;
                  reply->destkey  = 0xBF;
                  reply->srcaddr  = 0x1;
                  reply->tid      = i;
                  reply->addr     = (int)&(rx0[(m%4)]);
                  if (reply->status == 0) {
                          reply->len      = (i/2);
                  } else {
                          reply->len      = 0;
                  }
                  reply->dstspalen = 0;
                  reply->dstspa  = (char *)NULL;
                  reply->srcspalen = 0;
                  reply->srcspa = (char *)NULL;
                  if (build_rmap_hdr(reply, rx2, replysize)) {
                          printf("RMAP reply build failed\n");
                          exit(1);
                  }
                  while (spw_rx(0, rx1, spw)) {
                          for (k = 0; k < 64; k++) {}
                  }
                  if (spw_tx(0, 1, 1, 0, *cmdsize, tx0, j, tx1, spw)) {
                          printf("Transmission failed\n");
                          exit(1);
                  }
                  while (!(tmp = spw_checktx(0, spw))) {
                          for (k = 0; k < 64; k++) {}
                  }
                  if (tmp != 1) {
                          printf("Error in transmit \n");
                          exit(1);
                  }
                  iterations = 0;
                  while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                          if (iterations > 1000) {
                                  printf("ERROR: Time limit exceeded while waiting for RMAP reply\n");
                                  exit(0);
                          }
                          for (k = 0; k < 64; k++) {}
                          /* printf("0x%x\n", spw2->regs->status);*/
                          iterations++;
                  }
                  if (rxs->truncated) {
                          printf("Received packet truncated\n");
                          exit(1);
                  }
                  if(rxs->eep) {
                          printf("Received packet terminated with eep\n");
                          exit(1);
                  }
                  if(rxs->hcrcerr) {
                          printf("Received packet header crc error detected\n");
                          exit(1);
                  }
                  if(rxs->dcrcerr) {
                          printf("Received packet data crc error detected\n");
                          exit(1);
                  }
                  if ((reply->status == 0) && (i != 0)) {
                          if (*size != (*replysize+1+(i/2)+1)) {
                                  printf("Received packet has wrong length\n");
                                  printf("Expected: %i, Got: %i \n", *replysize+2+(i/2), *size);
                                  exit(1);
                          }
                  } else {
                          if (*size != (*replysize+2)) {
                                  printf("Received packet has wrong length\n");
                                  printf("Expected: %i, Got: %i \n", *replysize+1, *size);
                                  exit(1);
                          }
                  }
                  for(k = 0; k < *replysize; k++) {
                          if (loadb((int)&(rx1[k])) != rx2[k]) {
                                  printf("Compare error 1: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[k])), (unsigned)rx2[k]);
                                  exit(1);
                          }
                  }
                  if (reply->status == 0) {
                          for(k = *replysize+1; k < *replysize+1+(i/2); k++) {
                                  if (loadb((int)&(rx1[k])) != rxdata[k-*replysize-1+(m%4)]) {
                                          printf("Compare error 2: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[k])), (unsigned)rxdata[k-*replysize-1+(m%4)]);
                                          exit(1);
                                  }
                          }
                          for(k = 0; k < (i/2); k++) {
                                  rxdata[(m%4)+k] = ((tx1[k] & tx1[k+(i/2)]) | (rxdata[(m%4)+k] & ~tx1[k+(i/2)]) );
                          }
                  } 
          }
                  /* if (((i % 4) == 0) && ((m % 8) == 0)) { */
/*           printf("Packet  %i, alignment %i\n", i, m); */
/*         } */
  
  }
  printf("\n");
  printf("RMW test passed\n");


  /*late and early eop tests*/
  printf("\nLate and early eop\n");
  for(i = 0; i < RMAPSIZE; i++) {
          printf(".");
          if (i < 16) {
                  tmp = -i;
          } else {
                  tmp = -16;
          }
          for (j = tmp; j < i; j++) {
                  for (m = 0; m < 3; m++) {
/*                           printf("Packet  %i, type %i, offset: %i\n", i, m, j); */
                          for(k = 0; k < i; k++) {
                                  tx1[k]  = ~tx1[k];
                          }
                          if (m == 0) {
                                  cmd->type     = writecmd;
                                  cmd->verify   = no;
                                  reply->type   = writerep;
                                  reply->verify = no;
                          } else if (m == 2) {
                                  cmd->type     = rmwcmd;
                                  cmd->verify   = yes;
                                  reply->type    = rmwrep;
                                  reply->verify = yes;
                          } else {
                                  cmd->type     = writecmd;
                                  cmd->verify   = yes;
                                  reply->type    = writerep;
                                  reply->verify = yes;
                          }
                          cmd->incr     = yes;
                          cmd->ack      = yes;
                          cmd->destaddr = 0x2;
                          cmd->destkey  = 0xBF;
                          cmd->srcaddr  = 0x1;
                          cmd->tid      = i;
                          cmd->addr     = (int)rx0;
                          cmd->len      = i;
                          cmd->status   = 0;
                          cmd->dstspalen = 0;
                          cmd->dstspa  = (char *)NULL;
                          cmd->srcspalen = 0;
                          cmd->srcspa = (char *)NULL;
                          if (build_rmap_hdr(cmd, tx0, cmdsize)) {
                                  printf("RMAP cmd build failed\n");
                                  exit(1);
                          }
                          reply->len       = 0;
                          if (j < 0 ) {
                                  reply->status = 5;
                          } else if (j == 0) {
                                  reply->status = 0;
                                  
                          } else {
                                  reply->status = 6;
                                  for(l = 0; l < i; l++) {
                                          if ((int)tx1[l] != 0) {
                                                  reply->status = 4;
                                          }
                                  }
                          }
                          if(m == 2 ) {
                                  if((cmd->len != 0) && (cmd->len != 2) && (cmd->len != 4) &&
                                     (cmd->len != 6) && (cmd->len != 8)) {
                                          reply->status = 11;
                                  } else if( (((cmd->len/2) == 2) && (cmd->addr % 2 != 0)) ||
                                             (((cmd->len/2) == 4) && (cmd->addr % 4 != 0)) ||
                                             ((cmd->len/2) == 3) ) {
                                          reply->status = 10;
                                  } else {
                                          if (reply->status != 0) {
                                                  reply->len = 0;
                                          } else {
                                                  reply->len = cmd->len/2;
                                          }
                                  }
                          } else if (m != 0) {
                                  if(cmd->len > 4) {
                                          reply->status = 9;
                                  } else if( (((cmd->len) == 2) && (cmd->addr % 2 != 0)) ||
                                             (((cmd->len) == 4) && (cmd->addr % 4 != 0)) ||
                                             ((cmd->len) == 3) ) {
                                          reply->status = 10;
                                  }
                          }
                          reply->incr      = yes;
                          reply->ack       = yes;
                          reply->destaddr  = 0x2;
                          reply->destkey   = 0xBF;
                          reply->srcaddr   = 0x1;
                          reply->tid       = i;
                          reply->addr      = (int)rx0;
                          reply->dstspalen = 0;
                          reply->dstspa    = (char *) NULL;
                          reply->srcspalen = 0;
                          reply->srcspa    = (char *) NULL;
                          if (build_rmap_hdr(reply, rx2, replysize)) {
                                  printf("RMAP reply build failed\n");
                                  exit(1);
                          }
                          if ((reply->status == 0) || (reply->status == 6)) {
                                  for(k = 0; k < reply->len; k++) {
                                          rx2[*replysize+1+k] = loadb((int)&(rx0[k]));
                                  }
                          }
                          while (spw_rx(0, rx1, spw)) {
                                  for (k = 0; k < 64; k++) {}
                          }
                          if (spw_tx(0, 1, 1, 0, *cmdsize, tx0, i+j, tx1, spw)) {
                                  printf("Transmission failed\n");
                                  exit(1);
                          }
                          while (!(tmp = spw_checktx(0, spw))) {
                                  for (k = 0; k < 64; k++) {}
                          }
                          if (tmp != 1) {
                                  printf("Error in transmit \n");
                                  exit(1);
                          }
                          iterations = 0;
                          while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                                  if (iterations > 1000) {
                                          printf("ERROR: Time limit exceeded while waiting for RMAP reply\n");
                                          exit(0);
                                  }
                                  for (k = 0; k < 64; k++) {}
                                  /* printf("0x%x\n", spw2->regs->status);*/
                                  iterations++;
                          }
                          if (rxs->truncated) {
                                  printf("Received packet truncated\n");
                                  exit(1);
                          }
                          if(rxs->eep) {
                                  printf("Received packet terminated with eep\n");
                                  exit(1);
                          }
                          if(rxs->hcrcerr) {
                                  printf("Received packet header crc error detected\n");
                                  exit(1);
                          }
                          if(rxs->dcrcerr) {
                                  printf("Received packet data crc error detected\n");
                                  exit(1);
                          }
                          if (m == 2) {
                                  if ((i != 0) && ((reply->status == 0) || (reply->status == 6))) {
                                          tmp = reply->len+1;
                                  } else {
                                          tmp = 1;
                                  }
                          } else {
                                  tmp = 0;
                          }
                          if (*size != (*replysize+1+tmp)) {
                                  printf("Received packet has wrong length\n");
                                  printf("Expected: %i, Got: %i \n", *replysize+1+tmp, *size);
                                  exit(1);
                          }
                          if (tmp == 0) {
                                  tmp++;
                          }
                          for(k = 0; k < *replysize; k++) {
                                  if (loadb((int)&(rx1[k])) != rx2[k]) {
                                          if (k != 3) {
                                                  printf("Compare error 0: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[k])), (unsigned)rx2[k]);
                                                  printf("Packet  %i, type %i, offset: %i\n", i, m, j);
                                                  exit(1);
                                          }
                                  }
                          }
                          if ((reply->status == 0) || (reply->status == 6)) {
                                  if (m == 2) {
                                          for(k = 0; k < reply->len; k++) {
                                                  if (loadb((int)&(rx1[k+*replysize+1])) != rx2[k+*replysize+1]) {
                                                          printf("Compare error 2: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[k+*replysize+1])), (unsigned)rx2[k+*replysize+1]);
                                                          printf("Rx0: %x, Rx1: %x, Rx2: %x\n", (int)rx0, (int)rx1, (int)rx2);
                                                          exit(1);
                                                  }
                                          }
                                          if ((tmp = rmap_read(0x2, 0x1, (int)&(rx0[0]), reply->len/2, 1, 0xBF, rx0, spw))) {
                                                  printf("RMAP read failed\n");
                                                  exit(1);
                                          }
                                          for(k = 0; k < (reply->len/2); k++) {
                                                  if (rx0[k] != ((tx1[k] & tx1[k+(i/2)]) | (rx2[*replysize+1+k] & ~tx1[k+(i/2)]) )) {
                                                          printf("Compare error 3: %u Data: %x Expected: %x \n", k, (unsigned)rx0[k], (unsigned)tx1[k]);
                                                          exit(1);
                                                  }
                                          }
                                  } else {
                                          if ((tmp = rmap_read(0x2, 0x1, (int)&(rx0[0]), i, 1, 0xBF, rx0, spw))) {
                                                  printf("RMAP read failed: %d\n", tmp);
                                                  exit(1);
                                          }
                                          for (k = 0; k < i; k++) {
                                                  if (rx0[k] != tx1[k]) {
                                                          printf("Compare error 1: %u Data: %x Expected: %x \n", k, rx0[k], (unsigned)tx1[k]);
                                                          exit(1);
                                                  }
                                          }
                                  }
                          }
                  }
          }
          
  }
  free(tx0); 
  free(tx1); 
  free(rx0); 
  free(rx1); 
  free(rx2); 
#endif
  printf("\n");
  printf("TEST 10: completed successfully\n\n");
#endif
/*   /\************************ TEST 11 **************************************\/ */
#if TEST11 == 1
  printf("TEST 11: DMA channel RMAP CRC test\n\n");
  if ((spw->rmapcrc == 1) || (spw->rmap == 1)) {
          tx0 = (char *)malloc(64);
          tx1 = (char *)calloc(RMAPCRCSIZE, 1);
          rx1 = (char *)malloc(32+RMAPCRCSIZE);
          for(i = 0; i < RMAPCRCSIZE; i++) {
                  printf(".");
                  for(m = 0; m < 6; m++) {
                          for(k = 0; k < i; k++) {
                                  tx1[k]  = ~tx1[k];
                          }
                          switch (m) {
                                  case 0:
                                          cmd->type     = writerep;
                                          j           = 0;
                                          cmd->verify   = no;
                                          l = 0;
                                          break;
                                  case 1:
                                          cmd->type     = readrep;
                                          cmd->verify   = no;
                                          j           = i;
                                          l = 1;
                                          break;
                                  case 2:
                                          cmd->type     = rmwrep;
                                          j           = (i/2);
                                          cmd->verify   = yes;
                                          l = 1;
                                          break;
                                  case 3:
                                          cmd->type     = writecmd;
                                          cmd->verify   = no;
                                          j = i;
                                          l = 1;
                                          break;
                                  case 4:
                                          cmd->type     = readcmd;
                                          cmd->verify   = no;
                                          j = 0;
                                          l = 0;
                                          break;
                                  case 5:
                                          cmd->type     = rmwcmd;
                                          j           = (i % 8);
                                          cmd->verify   = yes;
                                          l = 1;
                                          break;        
                                  default:
                                          break;
                          }
                          
                          if (m > 2) {
                                  cmd->destaddr = 0x2;
                                  cmd->srcaddr  = 0x1;
                          }
                          else {
                                  cmd->destaddr = 0x1;
                                  cmd->srcaddr  = 0x2;
                          }
                          
                          cmd->incr     = no;
                          cmd->ack      = yes;
                          cmd->destkey  = 0xBF;
                          cmd->tid      = i;
                          cmd->addr     = 0x41234567;
                          cmd->len      = i;
                          cmd->status   = 0;
                          cmd->dstspalen = 0;
                          cmd->dstspa  = (char *)NULL;
                          cmd->srcspalen = 0;
                          cmd->srcspa = (char *)NULL;
                          if (build_rmap_hdr(cmd, tx0, cmdsize)) {
                                  printf("RMAP cmd build failed\n");
                                  exit(1);
                          }
#if INITIATOR == 1                          
                          if (spw_tx(0, 1, l, 0, *cmdsize, tx0, j, tx1, spw)) {
                                  printf("Transmission failed\n");
                                  exit(1);
                          }
                          while (!(tmp = spw_checktx(0, spw))) {
                                  for (k = 0; k < 64; k++) {}
                          }
                          
                          if (tmp != 1) {
                                  printf("Error in transmit \n");
                                  exit(1);
                          }
#else

                          while (spw_rx(0, rx1, spw)) {
                                  for (k = 0; k < 64; k++) {}
                          }

                          while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                                  for (k = 0; k < 64; k++) {}
                          }
                          if (rxs->truncated) {
                                  printf("Received packet truncated\n");
                                  exit(1);
                          }
                          if(rxs->eep) {
                                  printf("Received packet terminated with eep\n");
                                  exit(1);
                          }
                          if(rxs->hcrcerr) {
                                  printf("Received packet header crc error detected\n");
                                  exit(1);
                          }
                          if(rxs->dcrcerr) {
                                  printf("Received packet data crc error detected\n");
                                  exit(1);
                          }
                          
                          if (*size != (*cmdsize+1+j+l)) {
                                  printf("Received packet has wrong length\n");
                                  printf("Expected: %i, Got: %i \n", *cmdsize+1+j+l, *size);
                                  exit(1);
                          }
                          for(k = 0; k < *cmdsize; k++) {
                                  if (loadb((int)&(rx1[k])) != tx0[k]) {
                                          printf("Compare error 0: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[k])), (unsigned)tx0[k]);
                                          printf("Packet  %i, type %i\n", i, m);
                                          exit(1);
                                  }
                          }
                          for(k = 0; k < j; k++) {
                                  if (loadb((int)&(rx1[k+*cmdsize+1])) != tx1[k]) {
                                          printf("Compare error 1: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[k+*cmdsize+1])), (unsigned)tx1[k]);
                                          exit(1);
                                  }
                          }
                          if ((i == 0) && (m == 0)) {
                                  spw_rmapdis(spw);
                          }
#endif
                          /* if (((i % 4) == 0) && ((m % 3) == 0)) { */
/*                                   printf("Packet  %i, type %i\n", i, m); */
/*                           } */
                  }
          }
  }
  printf("\n");
  printf("TEST 11: completed successfully\n\n");
#endif
  /************************ TEST 12 **************************************/
#if TEST12 == 1
  printf("TEST 12 Indefinite loop with continuous full-duplex transfers testing long time stability\n\n");

  for(i = 0; i < 128; i++) {
          rx[i] = malloc(LOOPPKTSIZE);
  }
  for(i = 0; i < 64; i++) {
          tx[i] = malloc(LOOPPKTSIZE);
          chk[i] = malloc(LOOPPKTSIZE);
  }
  /*initialize data*/
  for(i = 0; i < 64; i++) {
#if INITIATOR == 1
          tx[i][0] = 0x2;
          chk[i][0] = 0x1;
#else
          tx[i][0] = 0x1;
          chk[i][0] = 0x2;
#endif
          tx[i][1] = 0x2;
          chk[i][1] = 0x2;
          for(j = 2; j < LOOPPKTSIZE; j++) {
                  tx[i][j] = (i+j) % 256;
                  chk[i][j] = (i+j) % 256;
          }
  }
  txlen = 2;
  rxlen = 2;
  txpnt = 0;
  rxpnt = 0;
  chkpnt = 0;
  rxchkpnt = 0;
  init = 0;
  
  for(i = 0; i < 128; i++) {
          while (spw_rx(0, rx[rxpnt], spw)) {}
          if (rxpnt < 127) {
                  rxpnt++;
          } else {
                  rxpnt = 0;
          }
  }

  for(i = 0; i < 64; i++) {
          while (spw_tx(0, 0, 0, 0, 0, tx[txpnt], txlen, tx[txpnt], spw)) {}
          if (txlen < LOOPPKTSIZE) {
                  txlen++;
          } else {
                  txlen = 2;
          }
          if (txpnt < 63) {
                  txpnt++;
          } else {
                  txpnt = 0;
          }
  }
  while(1) {
          if ((tmp = spw_checktx(0, spw))) {
                  if (tmp != 1) {
                          printf("Error in transmit \n");
                  }
                  for (i = 2; i < txlen; i++) {
                          tx[txpnt][i] = (tx[txpnt][i]+txpnt+i) % 256;
                  }
                  if (spw_tx(0, 0, 0, 0, 0, tx[txpnt], txlen, tx[txpnt], spw)) {
                          printf("Error in transmit \n");
                  }
                  if (txlen < LOOPPKTSIZE) {
                          txlen++;
                  } else {
                          txlen = 2;
                  }
                  if (txpnt < 63) {
                          txpnt++;
                  } else {
                          txpnt = 0;
                  }
          }

          
          if ((tmp = spw_checkrx(0, size, rxs, spw))) {
                  printf(".");
                  if (rxs->truncated) {
                          printf("Received packet truncated\n");
                  }
                  if(rxs->eep) {
                          printf("Received packet terminated with eep\n");
                  }
                  if (*size != rxlen) {
                          printf("Received packet has wrong length\n");
                          printf("Expected: %i, Got: %i \n", rxlen, *size);
                  }
                  for(k = 0; k < rxlen; k++) {
                          if (loadb((int)&(rx[rxchkpnt][k])) != chk[chkpnt][k]) {
                                  printf("Compare error: %u %u %u Data: %x Expected: %x \n", rxchkpnt, chkpnt, k, (unsigned)loadb((int)&(rx[rxchkpnt][k])), (unsigned)chk[chkpnt][k]);
                          }
                  }
                  if (rxlen < LOOPPKTSIZE) {
                          rxlen++;
                  } else {
                          rxlen = 2;
                  }
                  if (chkpnt < 63) {
                          chkpnt++;
                  } else {
                          chkpnt = 0;
                          init = 1;
                  }
                  if (rxchkpnt < 127) {
                          rxchkpnt++;
                  } else {
                          rxchkpnt = 0;
                  }
                  if (init) {
                          for (i = 2; i < rxlen; i++) {
                                  chk[chkpnt][i] = (chk[chkpnt][i]+chkpnt+i) % 256;
                          }
                  }
                  if (spw_rx(0, rx[rxpnt], spw)) {
                          printf("Error in receive\n");
                  }
                  if (rxpnt < 127) {
                          rxpnt++;
                  } else {
                          rxpnt = 0;
                  }
          }
  }
  for(i = 0; i < 128; i++) {
          free(rx[i]);
  }
  for(i = 0; i < 64; i++) {
          free(tx[i]);
          free(chk[i]);
  }
  printf("\nTEST 12: completed successfully\n\n");
#endif
  printf("*********** Test suite completed successfully ************\n");
  exit(0);
        
}
