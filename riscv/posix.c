/*
 * This file is part of the ReonV distribution (https://github.com/lcbcFoo/ReonV).
 * Copyright (c) 2018 to Lucas C. B. Castro.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/*	Author: Lucas C. B. Castro
 *  Description: This file contains minimal implementations of some posix
 * 				 functions for ReonV.
 */

#include <unistd.h>
#include "reonv.h"
#include "mini_printf.h"
#define POSIC_C
#include "posix_c.h"

// External
char* console_buffer;

// Internal
static char* heap;
char* out_mem;
static LEON23_APBUART_Regs_Map *uart_regs;

/* Sends output via UART, adapted from BCC source code */
int send_uart (char *fmt, unsigned int len){
    unsigned int i, loops, ch;
    char *p = fmt;

	if (uart_regs){
	    while (len-- != 0){
    		ch = *p++;
    		if (uart_regs){
    		    loops = 0;

                while (!((uart_regs->status >> 24) & LEON_REG_UART_STATUS_THE) && (loops < UART_TIMEOUT))
    		          loops++;
				// Moves byte to beginning of TX buffer
				unsigned int outdata = (unsigned int) ch;
                outdata <<= 24;
                uart_regs->data = outdata;
    		    loops = 0;
    		    while (!((uart_regs->status >> 24) & LEON_REG_UART_STATUS_TSE) && (loops < UART_TIMEOUT))
    		        loops++;
    		  }
	      }
	  }

      return p - fmt;
  //---------------------
}

void _init_reonv(){
    uart_regs = (LEON23_APBUART_Regs_Map*) 0x80000100;
    heap = (char*) HEAP_START;
    out_mem = (char*)OUT_MEM_BEGIN;
    console_buffer = (char*) sbrk(CONSOLE_BUFFER_SIZE);
}


void *memcpy(void *dest, const void *src, unsigned int n){
    for(int i = 0; i < n; i++){
        *((char*)dest++) = *((char*)src++);
    }
}

// Exit application
void _exit(int status) {
	__asm("ebreak");
	while(1);
}

// Repositions the offset of memory section (no file descriptor implemented)
int _lseek( int fd, int offset, int whence ) {

    if(whence == SEEK_SET)
        out_mem = (char*) (OUT_MEM_BEGIN + offset);
   else if(whence == SEEK_CUR)
       out_mem = (char*) (out_mem + offset);
   else if(whence == SEEK_END)
       out_mem = (char*) (OUT_MEM_END + offset);
   else
       return -1;

    if(out_mem < (char*) OUT_MEM_BEGIN)
        return -1;
    else if(out_mem > (char*) OUT_MEM_END)
        return -1;

	return out_mem - (char*) OUT_MEM_BEGIN;
}


// Read from output memory section (no file descriptor implemented)
int _read( int fd, char *buffer, int len ) {
    int i;
    for(i = 0; (i < len) && (&out_mem[i] < (char*)OUT_MEM_END); i++){
        buffer[i] = out_mem[i];
    }

    out_mem += i;
    return i;
}

// Write to output memory section (no file descriptor implemented)
int _write( int fd, char *buffer, int len ) {
    int i;

    if(fd == STDOUT_FILENO){
        return send_uart(buffer, len);
    }

	for(i = 0; (i < len) && (&out_mem[i] < (char*)OUT_MEM_END); i++){
		out_mem[i] = buffer[i];
	}

    out_mem += i;
	return i;
}

// Open a file (no file descriptor implemented)
int _open( const char *path, int flags, int mode ) {
	return 0;
}

// Close fd (no file descriptor implemented)
int _close( int fd ) {

	return 0;
}

// Allocate space on heap
void* _sbrk( int incr ) {
	void* addr = (void*) heap;
	heap += incr;

	// Keep heap byte aligned
	while((int)heap % 4 != 0)
		heap++;
	return addr;
}
