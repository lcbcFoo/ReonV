
LEON3 Template design for TerASIC Altera DE2-115 board
------------------------------------------------------

0. Introduction
---------------

The leon3 design can be synthesized with quartus or synplify,
and can reach 50 - 70 MHz depending on configuration and synthesis
options. Use 'make quartus' or 'make quartus-synp' to run the
complete flow. To program the FPGA in batch mode, use 
'make quartus-prog-fpga' or 'make quartus-prog-fpga-ref (reference config).
On linux, you might need to start jtagd as root to get the proper
port permissions. LEON3 reset is mapped on KEY0.

The output from grmon should look something like this:


 GRMON LEON debug monitor v1.1.41 professional version

 Copyright (C) 2004-2008 Aeroflex Gaisler - all rights reserved.
 For latest updates, go to http://www.gaisler.com/
 Comments or bug-reports to support@gaisler.com

 ethernet startup.
 GRLIB build version: 4103

 initialising ............
 detected frequency:  50 MHz

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug UART                       Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 GR Ethernet MAC                      Gaisler Research
 LEON2 Memory Controller              European Space Agency
 AHB/APB Bridge                       Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 Generic APB UART                     Gaisler Research
 Multi-processor Interrupt Ctrl       Gaisler Research
 Modular Timer Unit                   Gaisler Research
 General purpose I/O port             Gaisler Research
 AHB status register                  Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> inf sys
00.01:003   Gaisler Research  LEON3 SPARC V8 Processor (ver 0x0)
             ahb master 0
01.01:007   Gaisler Research  AHB Debug UART (ver 0x0)
             ahb master 1
             apb: 80000700 - 80000800
             baud rate 115200, ahb frequency 50.00
02.01:01c   Gaisler Research  AHB Debug JTAG TAP (ver 0x1)
             ahb master 2
03.01:01d   Gaisler Research  GR Ethernet MAC (ver 0x0)
             ahb master 3, irq 14
             apb: 80000e00 - 80000f00
             edcl ip 192.168.0.56, buffer 2 kbyte
00.04:00f   European Space Agency  LEON2 Memory Controller (ver 0x1)
             ahb: 00000000 - 20000000
             ahb: 20000000 - 40000000
             ahb: 40000000 - 80000000
             apb: 80000000 - 80000100
             8-bit prom @ 0x00000000
             32-bit sdram: 1 * 128 Mbyte @ 0x40000000, col 10, cas 2, ref 7.8 us
01.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)
             ahb: 80000000 - 80100000
02.01:004   Gaisler Research  LEON3 Debug Support Unit (ver 0x1)
             ahb: 90000000 - a0000000
             AHB trace 128 lines, 32-bit bus, stack pointer 0x47fffff0
             CPU#0 win 8, hwbp 2, itrace 128, V8 mul/div, srmmu, lddel 1, GRFPU
                   icache 4 * 4 kbyte, 32 byte/line lru
                   dcache 4 * 4 kbyte, 16 byte/line lru
01.01:00c   Gaisler Research  Generic APB UART (ver 0x1)
             irq 2
             apb: 80000100 - 80000200
             baud rate 38343, DSU mode (FIFO debug)
02.01:00d   Gaisler Research  Multi-processor Interrupt Ctrl (ver 0x3)
             apb: 80000200 - 80000300
03.01:011   Gaisler Research  Modular Timer Unit (ver 0x0)
             irq 8
             apb: 80000300 - 80000400
             16-bit scaler, 2 * 32-bit timers, divisor 50
09.01:01a   Gaisler Research  General purpose I/O port (ver 0x1)
             apb: 80000900 - 80000a00
0f.01:052   Gaisler Research  AHB status register (ver 0x0)
             irq 1
             apb: 80000f00 - 80001000

1. SDRAM interface

The SDRAM works fine with the MCTRL controller, providing 128 Mbyte memory.

2. FLASH

The FLASH is also interfaced with MCTRL, in 8-bit mode. Programming
works fine with GRMON.

grlib> fla

 AMD-style 8-bit flash

 Manuf.    AMD                 
 Device    MX29LV128MB       

 1 x 8 Mbyte = 8 Mbyte total @ 0x00000000

 CFI info
 flash family  : 2
 flash size    : 64 Mbit
 erase regions : 2
 erase blocks  : 135
 write buffer  : 32 bytes
 lock-down     : yes
 region  0     : 8 blocks of 8 Kbytes
 region  1     : 127 blocks of 64 Kbytes

3. UART

The single RS232 port can be use as console when switch SW0 is
off, or as debug link for GRMON when SW0 is on.


4. Ethernet

The ethernet port 0 is supported in 10/100 Mbit MII mode. This requires
that the jumper JP1 is set to short ping 2-3, rather than the 1-2 as
is default. The ethernet debug link (EDCL) is enabled and set to IP
192.168.0.51.

5. SPI

Two SPI cores can be enabled in the design. The signal map is as follows:

SPICTRL SPI master controller:
Design signal  SPI signal   JP5 pin
  gpio(35)       miso         40
  gpio(34)       mosi         39
  gpio(33)       sck          38
  gpio(32)      slv. sel.     37

SPI2AHB SPI to AHB bridge:
Design signal  SPI signal   JP5 pin
  gpio(31)       miso         36
  gpio(30)       mosi         35
  gpio(29)       sck          34
  gpio(28)      slv. sel.     33

The general purpose I/O port (GRGPIO) is enabled by default in the
design and maps gpio(0) to gpio(30). If SPI2AHB is enabled then the
number of GPIO lines must be decreased to 28.

6. Other functions

Not yet supported: PS/2, SSRAM, VGA, video grabber, USB, audio ...
