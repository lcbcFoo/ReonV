This LEON3 design is tailored to the ZTEX USB-FPGA module 1.15

http://www.ztex.de/usb-fpga-1/usb-fpga-1.15.e.html

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

* DSU break is mapped to PIN A11

* DSU active out is mapped to PIN C13

* DDR2 is working with the provided Xilinx MIG DDR2 controller.

* The application UART1 is connected to PIN A18 (rx) and PIN D17 (tx)

* The UART DSU interface ie enabled and connected to PIN A17 (rx) and PIN C14 (tx)
  Start GRMON with -uart /dev/ttyUSB0 -baud 460800

* The JTAG DSU interface is enabled and accesible via the USB/JTAG port.
  Start GRMON with -xilusb to connect

* The processor boots from on-chip AHBROM. See the GRIP manual for
  how to re-generate ahbrom.vhd

* The default configuration has the floating-point unit (FPU) enabled.
  In order to build or simulate the design, the GRLIB netlist package
  must be installed, or the FPU must be disabled via make xconfig.

* Output from GRMON should look similar to this:

-bash-3.2$ grmon-int -xilusb -u

 GRMON LEON debug monitor v1.1.51 professional version

 Copyright (C) 2004-2011 Aeroflex Gaisler - all rights reserved.
 For latest updates, go to http://www.gaisler.com/
 Comments or bug-reports to support@gaisler.com

 This debug version will expire on 2/10/2012
 Xilinx cable: Cable type/rev : 0x3 
 JTAG chain: xc2c32a xc6slx75 

 GRLIB build version: 4112

 initialising .............
 detected frequency:  73 MHz

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
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
 SPI Controller                       Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> load ~/tests/hello
section: .text at 0x40000000, size 39968 bytes
section: .data at 0x40009c20, size 2940 bytes
total size: 42908 bytes (821.9 kbit/s)
read 208 symbols
entry point: 0x40000000
grlib> run
Hello world!

Program exited normally.
grlib> 

