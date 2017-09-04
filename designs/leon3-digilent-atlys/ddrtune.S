/*
 *  ddrtune.S
 *  Joris van Rantwijk
 *
 *  DDRTUNE is a very small LEON3 program that tunes the DDR2 controller
 *  for correct timing of data read signals.
 *
 *  This program can be loaded into AHBRAM and executed with GRMON
 *  in order to get the DDR2 memory up and running.  As a next step,
 *  a main program image can then be loaded into the DDR2 memory in
 *  the usual way.
 *
 *  Compile as follows:
 *    $ sparc-elf-gcc -nostdlib -Ttext=0xa0000000 ddrtune.S -o ddrtune.exe
 *
 *  Use as follows:
 *    grmon> reset
 *    grmon> load ddrtune.exe
 *    grmon> run
 *
 *  The program probes a range of different IODELAY settings, running
 *  a tiny memory test at each setting.  When it finds a group of good
 *  delay values, it sets the IODELAY to the middle of the safe group.
 *
 *  The program prints messages to the console port. It shows a map
 *  of good/bad delay settings (1=good, 0=bad) and it prints the chosen
 *  delay setting.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public
 *  License as published by the Free Software Foundation; either
 *  version 2 of the License, or (at your option) any later version.
 */


#define APBUART         0x80000100
#define DDR2CFG         0xfff00100

#define DDR2CFG1_VAL    0x82208491
#define DDR2CFG3_VAL    0x02c50000
#define DDR2CFG4_VAL    0x00000100
#define DDR2CFG5_VAL    0x00470004


.seg "text"
.global start

/********  CODE  ********/

start:

/* Reset CPU */
    set  0xc0, %g1
    mov  %g1, %psr
    nop
    nop
    mov  %g0, %wim
    nop
    nop
    mov  %g0, %tbr
    nop
    nop

/* Disable cache */
    sta  %g0, [%g0] 2
    nop
    nop

#ifdef INIT_UART
/* Configure APBUART for 38400 bps (assuming 50 MHz AHB clock) */
    set APBUART_SCAL, %o0
    mov 162, %g1
    st  %g1, [%o0+0xc]
    mov 0x3, %g1
    st  %g1, [%o0+8]
#endif

/* Find start address of image */
findstart:
    call findstart2
    nop
findstart2:
    sub  %o7, findstart-start, %l7          /* %l7 = address of start */

/* Print hello */
    call printstr
    add  %l7, data_hello-start, %o0

/* Configure memory controller */
    set  DDR2CFG, %o0
    set  DDR2CFG1_VAL, %o1
    st   %o1, [%o0]
    set  DDR2CFG3_VAL, %o1
    st   %o1, [%o0+0x8]
    set  DDR2CFG4_VAL, %o1
    st   %o1, [%o0+0xc]
    set  DDR2CFG5_VAL, %o1
    st   %o1, [%o0+0x10]
    set  DDR2CFG1_VAL, %o1
    set  0x10000, %g1
    or   %o1, %g1, %o1
    st   %o1, [%o0]

    call printchar
    mov  '.', %o0

/* Reset input delay */
    call resetdelay
    nop
    call readcmp
    nop

    call printchar
    mov  '.', %o0

/* Write test pattern to memory */
    call writemem
    nop

    call printchar
    mov  '.', %o0

    call printstr
    add  %l7, data_eoln-start, %o0

/* Scan over 160 delay steps */
    mov  %g0, %l1           /* %l1 = current data delay setting */
    mov  %g0, %l2           /* %l2 = current run length of good results */
    mov  -1,  %l3           /* %l3 = optimum delay setting */

scanloop:
    /* test read from memory */
    call readcmp
    nop

    /* force error during last iteration as sentinel */
    cmp  %l1, 160
    be,a scanloop_upd
    mov  %g0, %o0

scanloop_upd:
    cmp  %o0, 0
    bne  scanloop_print
    inc  %l2
    cmp  %l2, 16
    ble,a scanloop_print
    mov  %g0, %l2
    cmp  %l3, -1
    bne,a scanloop_print
    mov  %g0, %l2

    /* Found first group of at least 16 correct delay settings.
       Take the middle of this group as the optimum setting. */
    srl  %l2, 1, %l2
    sub  %l1, %l2, %l3
    mov  %g0, %l2
 
scanloop_print:
    /* print 0 for error, 1 for success */
    call printchar
    add  %o0, '0', %o0

    /* increment data delay */
    call incdelay
    nop

    inc  %l1
    andcc %l1, 0xf, %g0
    bne scanloop_noeol
    nop
    call printstr
    add  %l7, data_eoln-start, %o0
scanloop_noeol:

    cmp  %l1, 161
    bne  scanloop
    nop

/* Report result */
    call printstr
    add  %l7, data_eoln-start, %o0

    cmp  %l3, -1
    be   tune_failed
    nop

    call printstr
    add  %l7, data_delayrpt-start, %o0

    srl  %l3, 4, %o0
    call printchar
    add  %o0, '0', %o0
    and  %l3, 0x0f, %o0
    cmp  %o0, 10
    add  %o0, '0', %o0
    bge,a result_lsb
    add  %o0, 'a'-'0'-10, %o0
result_lsb:
    call printchar
    nop

/* Set optimal delay (%l3 steps) */
    call resetdelay
    nop

setdelay_loop:
    call readcmp
    nop

    cmp  %l3, 0
    be   setdelay_end
    nop

    call incdelay
    nop

    ba   setdelay_loop
    dec  %l3
setdelay_end:

    call printstr
    add  %l7, data_done-start, %o0

    ba   endprog
    nop

tune_failed:
    call printstr
    add  %l7, data_failed-start, %o0
    nop

/* End program (force CPU in error mode via TA 0 with %g1=1) */
endprog:
    nop
    mov  1, %g1
    ta   0
    nop
    unimp
    nop


/* Reset DDR2 data delay. */
resetdelay:
    set  0x80000000, %g1
writeddrcfg:
    set  DDR2CFG, %o0
    set  DDR2CFG3_VAL, %o1
    or   %o1, %g1, %o1
    st   %o1, [%o0+0x8]
    set  20, %g1
writeddrcfg_wait:
    deccc %g1
    bne  writeddrcfg_wait
    nop
    retl
    nop 


/* Increase DDR2 data delay. */
incdelay:
    set  0xffff, %g1
    ba   writeddrcfg
    nop
   

/* Print character from %o0 to serial port. */
printchar:
    set  APBUART, %g1
    ld   [%g1+4], %g1
    andcc %g1, 4, %g0
    beq  printchar
    set  APBUART, %g1
    st   %o0, [%g1]
    retl
    nop


/* Print string at %o0 to serial port. */
printstr:
    mov  %o7, %o5
    mov  %o0, %o1
printstr_loop:
    ldub [%o1], %o0
    cmp  %o0, %g0
    beq  printstr_end
    inc  %o1
    call printchar
    nop
    ba   printstr_loop
    nop
printstr_end:
    jmpl %o5+8, %g0
    nop


/* Copy test pattern to DDR memory */
writemem:
    set  0x40000000, %o0
    add  %l7, data_testwords-start, %o1
    mov  16, %o2
writemem_loop:
    ld   [%o1], %g1
    add  %o1, 4, %o1
    st   %g1, [%o0]
    deccc %o2
    bne  writemem_loop
    add  %o0, 4, %o0
    retl
    nop


/* Read from memory and compare.
   Return %o0=1 if correct, %o0=0 if bad. */
readcmp:
    set  0x40000000, %o0
    add  %l7, data_testwords-start, %o1
readcmp_loop:
    ldd  [%o0], %o2
    add  %o0, 8, %o0
    ld   [%o1], %g1
    cmp  %g1, %o2
    bne  readcmp_bad
    ld   [%o1+4], %g1
    cmp  %g1, %o3
    bne  readcmp_bad
    add  %o1, 8, %o1
    andcc %o0, 0x40, %g0
    beq  readcmp_loop
    nop
    retl
    mov  1, %o0
readcmp_bad:
    retl
    mov  0, %o0


/********  DATA  ********/

.align 4
data_hello:
    .asciz "\r\nDDRTUNE:\r\n"

data_eoln:
    .asciz "\r\n"

data_delayrpt:
    .asciz "delay = 0x"

data_done:
    .asciz ", OK.\r\n"

data_failed:
    .asciz "FAILED\r\n"

.align 4
data_testwords:
    .word  0x12345678
    .word  0xf0c3a596
    .word  0x6789abcd
    .word  0xa6f1590e
    .word  0xedcba987
    .word  0x0f3c5a69
    .word  0x98765432
    .word  0x590ea6f1
    .word  0xffff0000
    .word  0x0000ffff
    .word  0x5ac3ffff
    .word  0x0000a53c
    .word  0x01510882 
    .word  0xf4d908fd
    .word  0x9b6f7a46
    .word  0xc721271d

/********  END  ********/

