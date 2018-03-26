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
 *  Description: Assembly header for posix functions
 */

#ifndef POSIX_H_INCLUDED
#define POSIX_H_INCLUDED

.globl send_uart


// Exit application
.globl _exit

// Repositions the offset of memory section (no file descriptor implemented)
.globl _lseek


// Read from output memory section (no file descriptor implemented)
.globl _read

// Write to output memory section (no file descriptor implemented)
.globl _write

// Open a file (no file descriptor implemented)
.globl _open

// Close fd (no file descriptor implemented)
.globl lose

// Allocate space on heap
.globl _sbrk

#endif //POSIX_H_INCLUDED
