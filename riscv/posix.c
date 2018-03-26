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
#include "mini-printf.h"
#define POSIC_C
#include "posix_c.h"


static char* heap;
static char* out_mem;
static char* console_buffer;
static LEON23_APBUART_Regs_Map *uart_regs;


/* PRINTF ********************/




/*
 * The Minimal snprintf() implementation
 *
 * Copyright (c) 2013,2014 Michal Ludvig <michal@logix.cz>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the auhor nor the names of its contributors
 *       may be used to endorse or promote products derived from this software
 *       without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * ----
 *
 * This is a minimal snprintf() implementation optimised
 * for embedded systems with a very limited program memory.
 * mini_snprintf() doesn't support _all_ the formatting
 * the glibc does but on the other hand is a lot smaller.
 * Here are some numbers from my STM32 project (.bin file size):
 *      no snprintf():      10768 bytes
 *      mini snprintf():    11420 bytes     (+  652 bytes)
 *      glibc snprintf():   34860 bytes     (+24092 bytes)
 * Wasting nearly 24kB of memory just for snprintf() on
 * a chip with 32kB flash is crazy. Use mini_snprintf() instead.
 *
 */
#include <unistd.h>
#include "posix_c.h"
#include "mini-printf.h"
#include "reonv.h"


static unsigned int
mini_strlen(const char *s)
{
	unsigned int len = 0;
	while (s[len] != '\0') len++;
	return len;
}

static unsigned int
mini_itoa(int value, unsigned int radix, unsigned int uppercase, unsigned int unsig,
	 char *buffer, unsigned int zero_pad)
{
	//__asm("ebreak");
	char	*pbuffer = buffer;
	int	negative = 0;
	unsigned int	i, len;

	/* No support for unusual radixes. */
	if (radix > 16)
		return 0;

	if (value < 0 && !unsig) {
		negative = 1;
		value = -value;
	}

	/* This builds the string back to front ... */
	do {
		int digit = value % radix;
		*(pbuffer++) = (digit < 10 ? '0' + digit : (uppercase ? 'A' : 'a') + digit - 10);
		value /= radix;
	} while (value > 0);

	for (i = (pbuffer - buffer); i < zero_pad; i++)
		*(pbuffer++) = '0';

	if (negative)
		*(pbuffer++) = '-';

	*(pbuffer) = '\0';

	/* ... now we reverse it (could do it recursively but will
	 * conserve the stack space) */
	len = (pbuffer - buffer);
	for (i = 0; i < len / 2; i++) {
		char j = buffer[i];
		buffer[i] = buffer[len-i-1];
		buffer[len-i-1] = j;
	}

	return len;
}

struct mini_buff {
	char *buffer, *pbuffer;
	unsigned int buffer_len;
};

static int my_putc(int ch, struct mini_buff *b){
	if ((unsigned int)((b->pbuffer - b->buffer) + 1) >= b->buffer_len)
		return 0;
	*(b->pbuffer++) = ch;
	*(b->pbuffer) = '\0';
	return 1;
}

static int my_puts(char *s, unsigned int len, struct mini_buff *b){
	unsigned int i;

	if (b->buffer_len - (b->pbuffer - b->buffer) - 1 < len)
		len = b->buffer_len - (b->pbuffer - b->buffer) - 1;

	/* Copy to buffer */
	for (i = 0; i < len; i++)
		*(b->pbuffer++) = s[i];
	*(b->pbuffer) = '\0';

	return len;
}

int mini_vsnprintf(char *buffer, unsigned int buffer_len, const char *fmt, char** va){
	char* args = (*va);
	//__asm("ebreak");
	struct mini_buff b;
	char bf[24];
	char ch;

	b.buffer = buffer;
	b.pbuffer = buffer;
	b.buffer_len = buffer_len;

	while ((ch=*(fmt++))) {
		if ((unsigned int)((b.pbuffer - b.buffer) + 1) >= b.buffer_len)
			break;
		if(ch == '\n'){
			my_putc(ch, &b);
			ch = '\r';
			my_putc(ch, &b);
		}
		else if (ch!='%'){
			my_putc(ch, &b);
        }
		else {
			char zero_pad = 0;
			char *ptr;
			unsigned int len;
			unsigned int d;

			ch=*(fmt++);

			/* Zero padding requested, supported up to 9 zeros */
			if (ch=='0') {
				ch=*(fmt++);
				if (ch == '\0')
					goto end;
				if(ch >= '0' && ch <= '9')
					zero_pad = ch - '0';
				ch=*(fmt++);
			}

			switch (ch) {
				case 0:
					goto end;

				case 'u':
				case 'd':
					d = (unsigned int) *((int*)args);
					args += sizeof(unsigned int);
					len = mini_itoa(d, 10, 0, (ch=='u'), bf, zero_pad);
					my_puts(bf, len, &b);
					break;

				case 'x':
				case 'X':
					d = (unsigned int) *((int*)args);
					args += sizeof(unsigned int);
					len = mini_itoa(d, 16, (ch=='X'), 1, bf, zero_pad);
					my_puts(bf, len, &b);
					break;

				case 'c' :
					ch = (char) *args;
					args += sizeof(int);
					my_putc(ch, &b);
					break;

				case 's' :
					ptr = (char*) *((int*)args);
					args += sizeof(int);
					my_puts(ptr, mini_strlen(ptr), &b);
					break;

				default:
					my_putc(ch, &b);
					break;
			}
		}
	}
end:
	return b.pbuffer - b.buffer;
}


int mini_snprintf(char* buffer, unsigned int buffer_len, const char *fmt, ...){
	int ret;
	va_list va;
	va_start(va, fmt);
	ret = mini_vsnprintf(buffer, buffer_len, fmt, va);
	va_end(va);

	return ret;
}

int reonv_printf (const char *fmt, ...){
    va_list args;

    /* Emit the output into the temporary buffer */
    va_start (args, fmt);
	//__asm("ebreak");
    unsigned int printed_len = mini_snprintf (console_buffer, CONSOLE_BUFFER_SIZE * sizeof (char), fmt, args);
    va_end (args);

    write(STDOUT_FILENO, console_buffer, printed_len);
}





/* END PRINTF*/


int send_uart (char *fmt, unsigned int len){
    unsigned int i, loops, ch;
    char *p = fmt;

	if (uart_regs){
	    while (len-- != 0){
    		ch = *p++;
    		if (uart_regs){
    		    loops = 0;

                while (!(uart_regs->status & LEON_REG_UART_STATUS_THE) && (loops < UART_TIMEOUT))
    		          loops++;
                unsigned int outdata = (unsigned int) ch;
                outdata <<= 24;
                uart_regs->data = outdata;
    		    loops = 0;
    		    while (!(uart_regs->status & LEON_REG_UART_STATUS_TSE) && (loops < UART_TIMEOUT))
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


// Exit application
void _exit( int status ) {
	__asm("ebreak");
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
	return addr;
}
