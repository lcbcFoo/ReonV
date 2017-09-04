
This leon3 design is tailored to the Digilent Virtex2-Pro XUP board

[Design specifics]

* System reset is mapped to the RESET/RELOAD button

* The DSU break input is mapped to the CENTER pushbutton

* LED 0 indicates LEON3 in debug mode.

* LED 1 indicates LEON3 in error mode.

* LED 2 and 3 indicates UART RX and TX activity.

* The serial port is connected to the console UART (UART 1) when
  dip switch 0 on SW7 is on. Otherwise it is connected to the
  DSU UART.

* The JTAG DSU interface is enabled and works well with
  GRMON and Xilinx parallel cable III or IV . The on-board
  USB connection can also be used if grmon is started with
  -xilusb, but is very slow. Cable drivers from ISE-9.2 or later
  are necessary.

* The GRETH core is enabled and runs without problems at 100 Mbit.
  Ethernet debug link is enabled, default IP is 192.168.0.51.

* DDR is mapped at address 0x40000000. Any PC2100 DDR DIMM between
  128 - 1024 Mbyte can be used. Note that the DIMM must
  support CL=2 and run on 2.5 V. The DDR frequency should
  be set to 100 MHz.  The processor and AMBA system 
  runs on a different clock, and can typically reach 70 - 90 MHz.

* IMPORTANT : If you download a new bitfile to the FPGA, make sure you
  press the reset button shortly to reset the clock DLLs. Otherwise
  the design will NOT work.

* The XUP board has no flash prom. To boot the system during
  simultion, an on-chip AHBROM core is used. The AHBROM is 
  filled with the contents of prom.exe. It and can be re-built with:

	make soft
	rm ahbrom.vhd
	make ahbrom.vhd
	make sim

  See further down in this file for instructions on how to include
  an application for running on real hardware.

* If you have problems meeting the required timing it may help to
  uncomment the line '#ISEMAPOPT=-timing' in the Makefile.

* If the VGA cores are disabled the clkvga constraints in leon3mp.ucf
  should be commented out.

* Typical output from GRMON info sys is:

grmon -eth -ip 192.168.0.51


 ethernet startup.
 GRLIB build version: 4090

 initialising ...............
 detected frequency:  65 MHz 

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug UART                       Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 SVGA Controller                      Gaisler Research
 GR Ethernet MAC                      Gaisler Research
 AHB ROM                              Gaisler Research
 AHB/APB Bridge                       Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 DDR266 Controller                    Gaisler Research
 System ACE I/F Controller            Gaisler Research
 Generic APB UART                     Gaisler Research
 Multi-processor Interrupt Ctrl       Gaisler Research
 Modular Timer Unit                   Gaisler Research
 PS/2 interface                       Gaisler Research
 PS/2 interface                       Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> inf sys
00.01:003   Gaisler Research  LEON3 SPARC V8 Processor (ver 0x0)
             ahb master 0                                       
01.01:007   Gaisler Research  AHB Debug UART (ver 0x0)          
             ahb master 1                                       
             apb: 80000400 - 80000500                           
             baud rate 115200, ahb frequency 65.00              
02.01:01c   Gaisler Research  AHB Debug JTAG TAP (ver 0x0)      
             ahb master 2                                       
03.01:063   Gaisler Research  SVGA Controller (ver 0x0)         
             ahb master 3                                       
             apb: 80000600 - 80000700                           
             clk0: 25.00 MHz  clk1: 50.00 MHz  clk2: 65.00 MHz  
04.01:01d   Gaisler Research  GR Ethernet MAC (ver 0x0)         
             ahb master 4, irq 12                               
             apb: 80000b00 - 80000c00                           
             edcl ip 192.168.0.53, buffer 2 kbyte               
00.01:01b   Gaisler Research  AHB ROM (ver 0x0)                 
             ahb: 00000000 - 00100000                           
01.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)          
             ahb: 80000000 - 80100000                           
02.01:004   Gaisler Research  LEON3 Debug Support Unit (ver 0x1)
             ahb: 90000000 - a0000000                           
             AHB trace 256 lines, 32-bit bus, stack pointer 0x4ffffff0
             CPU#0 win 8, hwbp 2, itrace 256, V8 mul/div, srmmu, lddel 1, GRFPU-lite
                   icache 2 * 8 kbyte, 32 byte/line lru
                   dcache 2 * 4 kbyte, 32 byte/line lru
03.01:025   Gaisler Research  DDR266 Controller (ver 0x0)
             ahb: 40000000 - 80000000
             ahb: fff00100 - fff00200
             64-bit DDR : 2 * 128 Mbyte @ 0x40000000
                          100 MHz, col 10, ref 7.8 us, trfc 80 ns
05.01:067   Gaisler Research  System ACE I/F Controller (ver 0x0)
             irq 13
             ahb: fff00300 - fff00400
01.01:00c   Gaisler Research  Generic APB UART (ver 0x1)
             irq 2
             apb: 80000100 - 80000200
             baud rate 38325, DSU mode (FIFO debug)
02.01:00d   Gaisler Research  Multi-processor Interrupt Ctrl (ver 0x3)
             apb: 80000200 - 80000300
03.01:011   Gaisler Research  Modular Timer Unit (ver 0x0)
             irq 8
             apb: 80000300 - 80000400
             8-bit scaler, 2 * 32-bit timers, divisor 65
05.01:060   Gaisler Research  PS/2 interface (ver 0x2)
             irq 5
             apb: 80000500 - 80000600
07.01:060   Gaisler Research  PS/2 interface (ver 0x2)
             irq 4
             apb: 80000700 - 80000800
grlib>


[Booting the system in hardware]

To boot the system in hardware you need to include start-up code that 
initializes the system and then executes your application. Here we will 
use mkprom2 to generate a PROM image, mkprom2 can be downloaded from 
http://www.gaisler.com.

The steps below will take a small executable that is intended to run in RAM and
use mkprom2 to create a PROM image which will initialize the system, copy the 
application to RAM, and start executing the application from RAM. For mkprom2 to
initialize the system it needs to know some parameters. The parameters given 
below are for a design where GRMON 'info sys' reports:

03.01:025   Gaisler Research  DDR266 Controller (ver 0x0)
             ahb: 40000000 - 80000000
             ahb: fff00100 - fff00200
             64-bit DDR : 2 * 128 Mbyte @ 0x40000000
                          100 MHz, col 10, ref 7.8 us, trfc 80 ns


The application that will be included in the PROM image looks like:

#include <stdio.h>

int main(void) 
{
        printf("Hello World!\n");

        return 0;
}

To compile the program, issue:

user@host:~/grlib/designs/leon3-digilent-xup$ sparc-elf-gcc -Wall -msoft-float -o hello hello.c

Then generate the PROM image. Please see the mkprom2 manual for additional 
information and a description of the parameters. The default name for the 
created image  is 'prom.out':

user@host:~/grlib/designs/leon3-digilent-xup$ mkprom2 -baud 38400 -freq 65 -ddrram 128 -ddrfreq 100 -ddrcol 1024 -msoft-float hello

The next step is to remove the existing ahbrom.vhd from the template design:

user@host:~/grlib/designs/leon3-digilent-xup$ rm ahbrom.vhd

Create a new ahbrom.vhd from the contents of prom.out, which was generated 
by mkprom2:

user@host:~/grlib/designs/leon3-digilent-xup$ make ahbrom.vhd FILE=prom.out
make[1]: Entering directory `/home/user/grlib/designs/leon3-digilent-xup'
make[1]: `ahbrom' is up to date.
make[1]: Leaving directory `/home/user/grlib/designs/leon3-digilent-xup'
sparc-elf-objcopy -O binary prom.out ahbrom.bin
./ahbrom ahbrom.bin ahbrom.vhd
Creating ahbrom.vhd : file size: 34240 bytes, address bits 16

Now the prom.out image has been placed in ahbrom.vhd and can be synthesized 
together with the rest of the system. After the FPGA has been programmed with
the new bitfile and the system has been reset, the following should be output 
on the serial port with 38400 8N1:

  MkProm2 boot loader v2.0
  Copyright Gaisler Research - all rights reserved

  system clock   : 65.0 MHz
  baud rate      : 38325 baud
  prom           : 512 K, (2/2) ws (r/w)
  sram           : 2048 K, 1 bank(s), 0/0 ws (r/w)

  decompressing .text to 0x40000000
  decompressing .data to 0x4000adc0

  starting hello

Hello World!


