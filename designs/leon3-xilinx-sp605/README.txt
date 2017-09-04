This leon3 design is tailored to the Xilinx SP605 Spartan6 board

Simulation and synthesis
------------------------

The design uses the Xilinx MIG memory interface and Xilinx PCI Express endpoint
with an AHB-2.0 interface. The source code cannot be distributed due to the
prohibitive Xilinx license, so they must be re-generated with 
coregen before simulation and synthesis can be done.

To generate the MIG and PCI Express using ISE13 and install the Xilinx unisim simulation
library, do as follows:

  make mig
  make pcie(do if PCI Express is enabled)
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

* The AHB and processor is clocked by a 55 MHz clock, generated
  from the 33 MHz SYSACE clock using a DCM. You can change the frequency
  generation in the clocks menu of xconfig. The DDR3 (MIG) controller
  runs at 667 MHz.

* The GRETH core is enabled and runs without problems at 100 Mbit.
  Ethernet debug link is enabled and has IP 192.168.0.51.
  1 Gbit operation is also possible (requires grlib com release),
  uncomment related timing constraints in the leon3mp.ucf first.

* 16-bit flash prom can be read at address 0. It can be programmed
  with GRMON version 1.1.16 or later.

* DDR3 is working with the provided Xilinx MIG DDR3 controller.
  If you want to simulate this design, first install the secure 
  IP models with:

  make install-secureip

  Then rebuild the scripts and simulation model:

  make distclean sim

  Modelsim v6.6e or newer is required to build the secure IP models.

* The application UART1 is connected to the USB/UART connector

* LED #0 is inverted DSU active (debug mode) indicator

* LED #1 is CPU error mode indicator

* LED #2 is calibration done signal from MIG DDR2 memory controller

* LED #3 is PLL lock indicator

* The SVGA frame buffer uses a separate port on the DDR3 controller,
  and therefore does not noticeably affect the performance of the processor.
  Default output is analog VGA, to switch to DVI mode execute this
  command in grmon:

  i2c dvi init_l4itx_vga

* The JTAG DSU interface is enabled and accesible via the USB/JTAG port.
  Start grmon with -xilusb to connect.

* The GRACECTRL core is instantiated and connected to the System ACE
  device. GRACECTRL is configured to fake a 16-bit System ACE i/f
  while the boards actual interface is 8-bit wide.

* Output from GRMON is:

$ grmon -xilusb -u

  GRMON2 LEON debug monitor v2.0.32 internal version
  
  Copyright (C) 2012 Aeroflex Gaisler - All rights reserved.
  For latest updates, go to http://www.gaisler.com/
  Comments or bug-reports to support@gaisler.com
  

Parsing -xilusb
Parsing -u

Commands missing help:
 debug

Xilusb: Cable type/rev : 0x3 
 JTAG chain (2): xc6slx45t xccace 
  GRLIB build version: 4121
  Detected frequency:  60 MHz
  
  Component                            Vendor
  LEON3 SPARC V8 Processor             Aeroflex Gaisler
  JTAG Debug Link                      Aeroflex Gaisler
  GR Ethernet MAC                      Aeroflex Gaisler
  LEON2 Memory Controller              European Space Agency
  AHB/APB Bridge                       Aeroflex Gaisler
  LEON3 Debug Support Unit             Aeroflex Gaisler
  Xilinx MIG DDR2 Controller           Aeroflex Gaisler
  System ACE I/F Controller            Aeroflex Gaisler
  Generic UART                         Aeroflex Gaisler
  Multi-processor Interrupt Ctrl.      Aeroflex Gaisler
  Modular Timer Unit                   Aeroflex Gaisler
  SVGA frame buffer                    Aeroflex Gaisler
  AMBA Wrapper for OC I2C-master       Aeroflex Gaisler
  General Purpose I/O port             Aeroflex Gaisler
  AHB Status Register                  Aeroflex Gaisler
  
  Use command 'info sys' to print a detailed report of attached cores

grmon2> mem 0x40000000
  0x40000000  40000000  40000004  40000008  ffff0000    @...@...@.......
  0x40000010  40000010  037007f0  57c016c0  16f416f0    @....p..W.......
  0x40000020  40000020  17f037f2  97c015f0  16e017e0    @.. ..7.........
  0x40000030  07f01370  17b103f0  54dc94b0  157217f8    ...p....T....r..
  
grmon2> lo /usr/local32/apps/bench/leon3/
164.gzip.leon3        aocs.leon3            dhry.leon3            grmon.bat             linpack.dp.leon3      ut699_res.txt        
176.gcc.leon3         basicmath_large.leon3 gr712rc_res.txt       l4ft.ods              results.txt           whetstone.leon3      
256.bzip2.leon3       coremark.exe.leon3    gr712rc_res2.txt      l4ft.txt              swim_bc              
grmon2> lo /usr/local32/apps/bench/leon3/dhry.leon3
  40000000 .text                     54.7kB /  54.7kB   [===============>] 100%
  4000DAF0 .data                      2.7kB /   2.7kB   [===============>] 100%
  Total size: 57.44kB (1.53Mbit/s)
  Entry point 0x40000000
  Image /usr/local32/apps/bench/leon3/dhry.leon3 loaded
  
grmon2> run
Execution starts, 1000000 runs through Dhrystone
Total execution time:                          5.2 s
Microseconds for one run through Dhrystone:    5.2 
Dhrystones per Second:                      194169.1 

Dhrystones MIPS      :                       110.5 


  Program exited normally.
  
grmon2> exit
  
Exiting GRMON

