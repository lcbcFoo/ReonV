This leon3 design is tailored to the Xilinx Spartan-6 SP601 board

http://www.xilinx.com/sp601

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

and then

  make ise-prog-fpga

to program the FPGA.

Design specifics
----------------

* System reset is mapped to the CPU RESET button

* The AHB and processor is clocked from the 27 MHz clock, while
  the DDR2 controller runs of the 200 MHz clock.

* DSU break is mapped to GPIO button 0 

* LED 2 indicates processor in debug mode

* LED 0 indicates processor in error mode

* The GRETH core is enabled and runs without problems at 100 Mbit.
  Ethernet debug link cannot not be enabled when the MIG DDR2
  controller is enabled due to limited area of the LX16 device.
  There are issues with the auto negotiation with the PHY. If the
  board is connected to a gigabit switch this may lead to the phy
  settling in gigabit mode and the 10/100 GRETH will not be able to
  communicate. The PHY can be forced into 100 Mbit operation with
  the GRMON command 'wmdio 7 0 0x2000'. This command can be issued
  when connecting with the UART or JTAG debug link.

* 8-bit flash prom can be read at address 0. It can be programmed
  with GRMON version 1.1.16 or later.

* DDR2 is working with the provided Xilinx MIG DDR2 controller.
  If you want to simulate this design, first install the secure 
  IP models with:

  make install-secureip

  Then rebuild the scripts and simulation model:

  make distclean sim

  Modelsim v6.5e or newer is required to build the secure IP models.

* The application UART1 is connected to the USB/RS232 connector

* The JTAG DSU interface is enabled and accesible via the USB/JTAG port.
  Start grmon with -xilusb to connect.

* Output from GRMON is:

grmon -xilusb -u
                                                                                    
  GRMON2 LEON debug monitor v2.0.32 internal version
  
  Copyright (C) 2012 Aeroflex Gaisler - All rights reserved.
  For latest updates, go to http://www.gaisler.com/
  Comments or bug-reports to support@gaisler.com
  

Parsing -xilusb
Parsing -u

Commands missing help:
 debug

Xilusb: Cable type/rev : 0x3 
 JTAG chain (1): xc6slx16 
  Device ID:           0x601
  GRLIB build version: 4121
  Detected frequency:  54 MHz
  
  Component                            Vendor
  LEON3 SPARC V8 Processor             Aeroflex Gaisler
  JTAG Debug Link                      Aeroflex Gaisler
  GR Ethernet MAC                      Aeroflex Gaisler
  AHB/APB Bridge                       Aeroflex Gaisler
  LEON3 Debug Support Unit             Aeroflex Gaisler
  Xilinx MIG DDR2 Controller           Aeroflex Gaisler
  LEON2 Memory Controller              European Space Agency
  Generic UART                         Aeroflex Gaisler
  Multi-processor Interrupt Ctrl.      Aeroflex Gaisler
  Modular Timer Unit                   Aeroflex Gaisler
  General Purpose I/O port             Aeroflex Gaisler
  
  Use command 'info sys' to print a detailed report of attached cores

grmon2> lo /usr/local32/apps/bench/leon3/dhry.leon3
  40000000 .text                     54.7kB /  54.7kB   [===============>] 100%
  4000DAF0 .data                      2.7kB /   2.7kB   [===============>] 100%
  Total size: 57.44kB (1.57Mbit/s)
  Entry point 0x40000000
  Image /usr/local32/apps/bench/leon3/dhry.leon3 loaded
  
grmon2> run
Execution starts, 1000000 runs through Dhrystone
Total execution time:                         10.3 s
Microseconds for one run through Dhrystone:   10.3 
Dhrystones per Second:                      97539.4 

Dhrystones MIPS      :                        55.5 


  Program exited normally.
  
grmon2> exit
  
Exiting GRMON
