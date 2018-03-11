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
