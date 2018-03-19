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

// Currently only reads/writes data from output section of memory
static char* heap = (char*) HEAP_START;
static char* out_mem = (char*)OUT_MEM_BEGIN;




#define LEON_REG_UART_CONTROL_RTD  0x000000FF	/* RX/TX data */

/*
 *  The following defines the bits in the LEON UART Status Registers.
 */

#define LEON_REG_UART_STATUS_DR   0x00000001	/* Data Ready */
#define LEON_REG_UART_STATUS_TSE  0x00000002	/* TX Send Register Empty */
#define LEON_REG_UART_STATUS_THE  0x00000004	/* TX Hold Register Empty */
#define LEON_REG_UART_STATUS_BR   0x00000008	/* Break Error */
#define LEON_REG_UART_STATUS_OE   0x00000010	/* RX Overrun Error */
#define LEON_REG_UART_STATUS_PE   0x00000020	/* RX Parity Error */
#define LEON_REG_UART_STATUS_FE   0x00000040	/* RX Framing Error */
#define LEON_REG_UART_STATUS_ERR  0x00000078	/* Error Mask */


/*
 *  The following defines the bits in the LEON UART Status Registers.
 */

#define LEON_REG_UART_CTRL_RE     0x00000001	/* Receiver enable */
#define LEON_REG_UART_CTRL_TE     0x00000002	/* Transmitter enable */
#define LEON_REG_UART_CTRL_RI     0x00000004	/* Receiver interrupt enable */
#define LEON_REG_UART_CTRL_TI     0x00000008	/* Transmitter interrupt enable */
#define LEON_REG_UART_CTRL_PS     0x00000010	/* Parity select */
#define LEON_REG_UART_CTRL_PE     0x00000020	/* Parity enable */
#define LEON_REG_UART_CTRL_FL     0x00000040	/* Flow control enable */
#define LEON_REG_UART_CTRL_LB     0x00000080	/* Loop Back enable */


typedef struct
{
  volatile unsigned int data;
  volatile unsigned int status;
  volatile unsigned int ctrl;
  volatile unsigned int scaler;
} LEON23_APBUART_Regs_Map;


#define UART_TIMEOUT 100000
static LEON23_APBUART_Regs_Map *uart_regs = 0;
//int *console = (int *) 0x80000100;
int
dbgleon_printf (const char *fmt, ...)
{
  unsigned int i, loops, ch;
  int printed_len;
  char printk_buf[1024];
  char *p = printk_buf;

  /* Emit the output into the temporary buffer */
  p = fmt;
  printed_len = 10;

    uart_regs = (LEON23_APBUART_Regs_Map*) 0x80000100;
	if (uart_regs){
	    while (printed_len-- != 0){
    		ch = *p++;
    		if (uart_regs){
    		    loops = 0;

                while (!(uart_regs->status & LEON_REG_UART_STATUS_THE) && (loops < UART_TIMEOUT))
    		          loops++;

                uart_regs->data = ch;
    		    loops = 0;
    		    while (!(uart_regs->status & LEON_REG_UART_STATUS_TSE) && (loops < UART_TIMEOUT))
    		        loops++;
    		  }
	      }
	  }
  //---------------------
}




// Exit application
void _exit_c( int status ) {
	__asm("ebreak");
}

// Repositions the offset of memory section (no file descriptor implemented)
int _lseek_c( int fd, int offset, int whence ) {

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
int _read_c( int fd, char *buffer, int len ) {
    int i;
    for(i = 0; (i < len) && (&out_mem[i] < (char*)OUT_MEM_END); i++){
        buffer[i] = out_mem[i];
    }

    out_mem += i;
    return i;
}

// Write to output memory section (no file descriptor implemented)
int _write_c( int fd, char *buffer, int len ) {
    int i;
	for(i = 0; (i < len) && (&out_mem[i] < (char*)OUT_MEM_END); i++){
		out_mem[i] = buffer[i];
	}

    out_mem += i;
	return i;
}

// Open a file (no file descriptor implemented)
int _open_c( const char *path, int flags, int mode ) {
	return 0;
}

// Close fd (no file descriptor implemented)
int _close_c( int fd ) {

	return 0;
}

// Allocate space on heap
void* _sbrk_c( int incr ) {
	void* addr = (void*) heap;
	heap += incr;
	return addr;
}
