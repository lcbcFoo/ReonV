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
 *  Description: This file contains minimal implementations of a crt0 for ReonV.
 */


#include "reonv.h"

.file "reonv_crt0.S"
.extern _start
.extern main

.globl __reonv_start
.globl __wrap_write
.globl __wrap_exit
.globl __wrap_read
.globl __wrap_open
.globl __wrap_close
.globl __wrap_lseek
.globl __wrap_sbrk
.type "__reonv_start",@function
.type "__wrap_exit",@function
.type "__wrap_open",@function
.type "__wrap_close",@function
.type "__wrap_write",@function
.type "__wrap_read",@function
.type "__wrap_lseek",@function
.type "__wrap_sbrk", @function

.org 0x0
// Reset Function
__reonv_start:
	mv 	x1,x0
	mv 	x2,x0
	mv 	x3,x0
	mv 	x4,x0
	mv 	x5,x0
	mv 	x6,x0
	mv 	x7,x0
	mv 	x8,x0
	mv 	x9,x0
	mv 	x10,x0
	mv 	x11,x0
	mv 	x12,x0
	mv 	x13,x0
	mv 	x14,x0
	mv 	x15,x0
	mv 	x16,x0
	mv 	x17,x0
	mv 	x18,x0
	mv 	x19,x0
	mv 	x20,x0
	mv 	x21,x0
	mv 	x22,x0
	mv 	x23,x0
	mv 	x24,x0
	mv 	x25,x0
	mv 	x26,x0
	mv 	x27,x0
	mv 	x28,x0
	mv 	x29,x0
	mv 	x30,x0
	mv 	x31,x0

	li	sp,SP_START
	call 	main
	call 	__wrap_exit

// Wrap some existent glibc posix functions to force linker to use our
// implementation
__wrap_exit:
	jal 	x0,_exit_c

__wrap_open:
	jal 	x0,_open_c

__wrap_close:
	jal 	x0,_close_c

__wrap_write:
	jal 	x0,_write_c

__wrap_read:
	jal 	x0,_read_c

__wrap_lseek:
	jal 	x0,_lseek_c

__wrap_sbrk:
	jal 	x0,_sbrk_c
