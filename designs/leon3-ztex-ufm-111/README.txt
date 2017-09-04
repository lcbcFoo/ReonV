This LEON3 design is tailored to the ZTEX USB-FPGA module 1.11

http://www.ztex.de/usb-fpga-1/usb-fpga-1.11.e.html

This design was contributed by Oleg Belousov <belousov.oleg@gmail.com>
and was downloaded from the ZTEX wiki at:

http://wiki.ztex.de/doku.php?id=en:projects:leon3

Note that this design, which is distrubuted with GRLIB, may not be
identical to the design available via the ZTEX wiki.

Simulation and synthesis
------------------------

The design uses the Xilinx MIG memory interface with an AHB-2.0
interface. The MIG source code cannot be distributed due to the
prohibitive Xilinx license, so the MIG must be re-generated with 
coregen before simulation and synthesis can be done.

To generate the MIG using ISE13 and install the Xilinx unisim simulation
library, do as follows:

  make mig
  make install-secureip

To generate the MIG using ISE14 and install the Xilinx unisim simulation
library, do as follows:

  make mig39
  make install-secureip

This will ONLY work with correct version of ISE installed, and the XILINX variable
properly set in the shell. For ISE13 it is recommened to use the 'ise' make target
and for ISE14 to use the 'planahead' target. To synthesize the design, do

  make ise (ISE13)

or

  make planahead (ISE14)

The FPGA can be programmed via JTAG using:

make ise-prog-fpga

or with the ZTEX FWLoader using one of the following commands:
  
  make ztex-upload
  make ztex-upload-fw  (load standalone firmware and upload bitstream)
  make sudo-ztex-upload
  make sudo-ztex-upload-fw

.. where the prefix "sudo-" calls FWLoader using sudo.

Note that the ZTEX environment variable must be set to the ZTEX SDK
directory for the make *ztex* targets to work. This variable can be
set in the shell or in the design's Makefile.

Design specifics
----------------

* The AHB and processor is clocked from the 72 MHz clock, while
  the DDR2 controller runs of the 200 MHz clock.

* DSU break is mapped to PIN C10

* DSU active out is mapped to PIN B12

* DDR2 is working with the provided Xilinx MIG DDR2 controller.

* The application UART1 is connected to PIN A14 (rx) and PIN C13 (tx)

* The UART DSU interface ie enabled and connected to PIN D12 (rx) and PIN E11 (tx)
  Start GRMON with -uart /dev/ttyUSB0 -baud 460800

* The JTAG DSU interface is enabled and accesible via the USB/JTAG port.
  Start GRMON with -xilusb to connect

* The processor boots from on-chip AHBROM. See the GRIP manual for
  how to re-generate ahbrom.vhd

* The default configuration has the floating-point unit (FPU) enabled.
  In order to build or simulate the design, the GRLIB netlist package
  must be installed, or the FPU must be disabled via make xconfig.

* A SPICTRL core is connected to the SD card slot. SD card interaction
  on HW has not yet been tested. Note that GRLIB also contains a
  SPIMCTRL core that has hardware support for interacting with SD cards.
  See the leon3-altera-ep3c25-eek design for an example.

* Output from GRMON should look similar to this:

 GRMON LEON debug monitor v1.1.49 evaluation version

 Copyright (C) 2004-2011 Aeroflex Gaisler - all rights reserved.
 For latest updates, go to http://www.gaisler.com/
 Comments or bug-reports to support@gaisler.com

 This evaluation version will expire on 20/1/2012
 using port /dev/ttyUSB0 @ 460800 baud

 Device ID: : 0x601
 GRLIB build version: 4108

 initialising ............
 detected frequency:  74 MHz

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug UART                       Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 AHB/APB Bridge                       Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 AHB static ram                       Gaisler Research
 Xilinx MIG DDR2 controller           Gaisler Research
 AHB ROM                              Gaisler Research
 Generic APB UART                     Gaisler Research
 Multi-processor Interrupt Ctrl       Gaisler Research
 Modular Timer Unit                   Gaisler Research
 General purpose I/O port             Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> info sys
00.01:003   Gaisler Research  LEON3 SPARC V8 Processor (ver 0x0)
             ahb master 0
01.01:007   Gaisler Research  AHB Debug UART (ver 0x0)
             ahb master 1
             apb: 80000700 - 80000800
             baud rate 460800, ahb frequency 74.00
02.01:01c   Gaisler Research  AHB Debug JTAG TAP (ver 0x1)
             ahb master 2
01.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)
             ahb: 80000000 - 80100000
02.01:004   Gaisler Research  LEON3 Debug Support Unit (ver 0x1)
             ahb: 90000000 - a0000000
             stack pointer 0x43fffff0
             CPU#0 win 8, V8 mul/div, srmmu, lddel 2, GRFPU-lite
                   icache 1 * 4 kbyte, 32 byte/line 
                   dcache 1 * 4 kbyte, 32 byte/line 
03.01:00e   Gaisler Research  AHB static ram (ver 0xc)
             ahb: a0000000 - a0100000
             4 kbyte AHB ram @ 0xa0000000
04.01:06b   Gaisler Research  Xilinx MIG DDR2 controller (ver 0x0)
             ahb: 40000000 - 44000000
             apb: 80000500 - 80000600
             DDR2: 64 Mbyte
06.01:01b   Gaisler Research  AHB ROM (ver 0x0)
             ahb: 00000000 - 00100000
01.01:00c   Gaisler Research  Generic APB UART (ver 0x1)
             irq 2
             apb: 80000100 - 80000200
             baud rate 38381
02.01:00d   Gaisler Research  Multi-processor Interrupt Ctrl (ver 0x3)
             apb: 80000200 - 80000300
03.01:011   Gaisler Research  Modular Timer Unit (ver 0x0)
             irq 8
             apb: 80000300 - 80000400
             8-bit scaler, 2 * 32-bit timers, divisor 74
0b.01:01a   Gaisler Research  General purpose I/O port (ver 0x1)
             apb: 80000b00 - 80000c00
grlib> 
