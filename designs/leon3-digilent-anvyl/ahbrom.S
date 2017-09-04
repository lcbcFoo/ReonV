/*
 *  ahbrom.S
 *  Joris van Rantwijk
 *
 *  This is a boot image for the AHBROM entity which is embedded in
 *  the FPGA firmware.  The AHBROM is mapped at address 0x00000000
 *  and is therefore the very first code which is executed by the LEON3
 *  after reset.
 *
 *  This code serves the following purposes:
 *   - delay until the SPI flash memory is available;
 *   - tune DDR2 read timing;
 *   - jump to the real boot loader at address 0xe0200000 in SPI memory.
 *
 *  Compile this code into a VHDL entity as follows:
 *    $ sparc-elf-gcc -nostdlib -Tlinkprom -Ttext=0 ahbrom.S -o ahbrom.exe
 *    $ sparc-elf-objcopy -O binary ahbrom.exe ahbrom.bin
 *    $ grlib/bin/ahbrom ahbrom.bin ahbrom.vhd
 *
 *  Then include the entity ahbrom.vhd in the top level of the LEON3
 *  system and rerun the FPGA synthesis.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public
 *  License as published by the Free Software Foundation; either
 *  version 2 of the License, or (at your option) any later version.
 */


/* Register addresses of GRLIB cores (assuming default core locations). */
#define APBUART         0x80000100
#define DDR2CFG         0xfff00100
#define SPIMCTRL        0xfff00200

/* UART baud rate calculation (assuming 50 MHz CPU frequency). */
#define UART_BAUD       38400
#define CPU_FREQ        50000000
#define UART_SCALE      (CPU_FREQ/(8*UART_BAUD))

/* Configuration for DDR2SPA (assuming Atlys board with 150 MHz DDR). */
#define DDR2CFG1_VAL    0x82208491
#define DDR2CFG3_VAL    0x02c50000
#define DDR2CFG4_VAL    0x00000100
#define DDR2CFG5_VAL    0x00470004


.seg "text"
.global start

/********  CODE  ********/

start:

    /* Reset CPU, disable traps. */
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

    /* Configure APBUART */
    set  APBUART, %o0
    set  UART_SCALE, %g1
    st   %g1, [%o0+0xc]
    mov  0x3, %g1
    st   %g1, [%o0+8]

    /* Print message. */
    set  data_hello, %o0
    call printstr
    nop

    /* Reset SPI memory controller. */
    set  SPIMCTRL, %o0
    set  0x18, %g1
    st   %g1, [%o0+0x4]

    mov  '.', %o0
    call printchar
    nop

    /* Wait until SPI memory initialized. */
waitspi:
    set  SPIMCTRL, %o0
    ld   [%o0+0x8], %g1
    andcc %g1, 4, %g0
    be   waitspi
    nop

    mov  '.', %o0
    call printchar
    nop

    /* Configure DDR2 memory controller */
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

    mov  '.', %o0
    call printchar
    nop

    /* Reset DDR2 data delay */
    call resetdelay
    nop
    call readcmp
    nop

    mov  '.', %o0
    call printchar
    nop

    /* Write test pattern to memory */
    call writemem
    nop

    mov  '.', %o0
    call printchar
    nop

    /* Scan over 160 delay steps */
    mov  %g0, %l1           /* %l1 = current data delay setting */
    mov  %g0, %l2           /* %l2 = current run length of good results */
    mov  -1,  %l3           /* %l3 = optimum delay setting */

scanloop:
    /* Test read from memory. */
    call readcmp
    nop

    /* Force error during last iteration as sentinel. */
    cmp  %l1, 160
    be,a scanloop_upd
    mov  %g0, %o0

scanloop_upd:
    cmp  %o0, 0
    bne  scanloop_scannext
    inc  %l2
    cmp  %l2, 16
    ble,a scanloop_scannext
    mov  %g0, %l2
    cmp  %l3, -1
    bne,a scanloop_scannext
    mov  %g0, %l2

    /* Found first group of at least 16 correct delay settings.
       Take the middle of this group as the optimum setting. */
    srl  %l2, 1, %l2
    sub  %l1, %l2, %l3
    mov  %g0, %l2
 
scanloop_scannext:
    /* Increment data delay. */
    call incdelay
    nop

    cmp  %l1, 160
    inc  %l1
    bne  scanloop
    nop

    cmp  %l3, -1
    be   tune_failed
    nop

    /* Report result */
    set  data_delayrpt, %o0
    call printstr
    nop

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

    set  data_done, %o0
    call printstr
    nop

jump_main:
    /* Jump to real bootstrap code. */
    set  0xe0000000, %g1
    jmp  %g1
    nop

tune_failed:
    /* Tuning failed. Reset delay and hope for the best. */
    set  data_failed, %o0
    call printstr
    nop

    call resetdelay
    nop

    ba   jump_main
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
    set  data_testwords, %o1
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
    set  data_testwords, %o1
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
    .asciz "\r\nAHBROM: "

data_delayrpt:
    .asciz " ddr2_delay = 0x"

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

