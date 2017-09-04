
This leon3 design is tailored to the Altera NiosII Startix2 
Development board, with 16-bit DDR SDRAM and 2 Mbyte of SSRAM. 

As of this time, the DDR interface only works up to 120 MHz.
At 130 MHz, DDR data can be read but not written. 

* The SMSC LAN91C111 10/100 Ethernet controller is attached
  to the I/O area of the memory controller at address 0x20000300.
  The ethernet interrupt is connected to GPIO[4], i.e. IRQ4.


* How to program the flash prom with a FPGA programming file

  1. Create a hex file of the programming file with Quartus.

  2. Convert it to srecord and adjust the load address:

	objcopy --adjust-vma=0x800000 output_file.hexout -O srec fpga.srec

  3. Program the flash memory using grmon:

      flash unlock all
      flash erase 0x800000 0xb00000
      flash load fpga.srec


* The SSRAM can be use if one waitstate is programmed in the memory controller.
  When using grmon, start with -ramws 1 .

* Sample output from GRMON is:

grmon -altjtag -u -ramws 1

 GRMON LEON debug monitor v1.1.34 professional version

 Copyright (C) 2004-2008 Aeroflex Gaisler - all rights reserved.
 For latest updates, go to http://www.gaisler.com/
 Comments or bug-reports to support@gaisler.com

 using Altera JTAG cable
 Selected cable 1 - USB-Blaster [USB 1-1.3]
JTAG chain:
@1: EP2S60 (0x120930DD)

 GRLIB build version: 3508

 initialising ...........
 detected frequency:  80 MHz

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 LEON2 Memory Controller              European Space Agency
 AHB/APB Bridge                       Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 DDR266 Controller                    Gaisler Research
 ATA Controller                       Gaisler Research
 Generic APB UART                     Gaisler Research
 Multi-processor Interrupt Ctrl       Gaisler Research
 Modular Timer Unit                   Gaisler Research
 General purpose I/O port             Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> info sys
00.01:003   Gaisler Research  LEON3 SPARC V8 Processor (ver 0x0)
             ahb master 0
01.01:01c   Gaisler Research  AHB Debug JTAG TAP (ver 0x0)
             ahb master 1
00.04:00f   European Space Agency  LEON2 Memory Controller (ver 0x0)
             ahb: 00000000 - 20000000
             ahb: 20000000 - 40000000
             ahb: a0000000 - b0000000
             apb: 80000000 - 80000100
             8-bit prom @ 0x00000000
01.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)
             ahb: 80000000 - 80100000
02.01:004   Gaisler Research  LEON3 Debug Support Unit (ver 0x1)
             ahb: 90000000 - a0000000
             AHB trace 128 lines, stack pointer 0x41fffff0
             CPU#0 win 8, hwbp 2, itrace 128, V8 mul/div, srmmu, lddel 1, GRFPU
                   icache 4 * 8 kbyte, 32 byte/line lru
                   dcache 4 * 4 kbyte, 16 byte/line lru
03.01:025   Gaisler Research  DDR266 Controller (ver 0x0)
             ahb: 40000000 - 50000000
             ahb: fff00100 - fff00200
             16-bit DDR : 1 * 32 Mbyte @ 0x40000000
                          100 MHz, col 9, ref 7.8 us, trfc 80 ns
05.01:024   Gaisler Research  ATA Controller (ver 0x0)
             irq 10
             ahb: fffa0000 - fffa0100
             Device 0: (None)
             Device 1: (None)
01.01:00c   Gaisler Research  Generic APB UART (ver 0x1)
             irq 2
             apb: 80000100 - 80000200
             baud rate 38461, DSU mode (FIFO debug)
02.01:00d   Gaisler Research  Multi-processor Interrupt Ctrl (ver 0x3)
             apb: 80000200 - 80000300
03.01:011   Gaisler Research  Modular Timer Unit (ver 0x0)
             irq 8
             apb: 80000300 - 80000400
             8-bit scaler, 2 * 32-bit timers, divisor 80
05.01:01a   Gaisler Research  General purpose I/O port (ver 0x0)
             apb: 80000500 - 80000600
grlib> fla

 AMD-style 8-bit flash

 Manuf.    AMD
 Device    MX29LV128MB

 1 x 16 Mbyte = 16 Mbyte total @ 0x00000000

 CFI info
 flash family  : 2
 flash size    : 128 Mbit
 erase regions : 1
 erase blocks  : 256
 write buffer  : 32 bytes
 region  0     : 256 blocks of 64 Kbytes

grlib>  

