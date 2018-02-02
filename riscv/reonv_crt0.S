#include "reonv.h"

.file "reonv_crt0.S"
.extern _start
.extern main
.extern _exit
.extern _open
.extern _close
.extern _write
.extern _read


.globl __reonv_startup
.type "__reonv_startup",@function
.type "exit",@function
.type "open",@function
.type "close",@function
.type "write",@function
.type "read",@function

.org 0x0
// Reset Function
__reonv_startup:
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

// Wrap some existent glibc posix functions used by benchmarkers
__wrap_exit:
	call 	_exit_c

__wrap_open:
	call 	_open_c

__wrap_close:
	call 	_close_c

__wrap_write:
	call 	_write_c

__wrap_read:
	call 	_read_c
