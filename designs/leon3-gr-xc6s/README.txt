This leon3 design is tailored to the Pender Spartan-6 XC6S-LX75 board

http://www.pender.ch/

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

This will ONLY work with correct version of ISE installed, and the
XILINX variable properly set in the shell. For ISE13 it is recommened
to use the 'ise' make target and for ISE14 to use the 'planahead'
target. To synthesize the design, do

  make ise (ISE13)

or

  make planahead (ISE14)

and then

  make ise-prog-fpga

to program the FPGA.

To simulate and run systest.c on the Leon design using the memory 
controller from Xilinx use the make targets:

  make soft
  make sim-launch

Design specifics
----------------

* System reset is mapped to the CPU RESET button

* The AHB and processor is clocked from the 50 MHz clock, while
  the DDR2 controller runs at 250 MHz (DDR2-500).

* The GRETH core is enabled and runs without problems at 100 Mbit.
  Ethernet debug link is enabled and has IP 192.168.0.59.
  1 Gbit operation is also possible (requires grlib com release).
  If GRETH_GBIT is to be included, do it via xconfig and not by
  editing config.vhd directly, otherwise the appropriate constraints
  will not be included.

* 8-bit flash prom can be read at address 0. It can be programmed
  with GRMON version 1.1.16 or later.

* DDR2 is working with the provided Xilinx MIG DDR2 controller.
  If you want to simulate this design, first install the secure 
  IP models with:

  make install-secureip

  Then rebuild the scripts and simulation model:

  make distclean vsim

  Modelsim v6.5e or newer is required to build the secure IP models.

* The application UART1 is connected to the RS232 connector

* The SVGA frame buffer uses a separate port on the DDR2 controller,
  and therefore does not noticeably affect the performance of the processor.
  Default output is analog VGA, to switch to DVI mode execute this
  command in grmon:

  i2c dvi init_l4itx_vga

* The JTAG DSU interface is enabled and accesible via the USB/JTAG port.
  Start grmon with -xilusb or "-eth -ip 192.168.0.59" to connect.

* The four LEDS (D1 - D4) are mapped as follows:

  D1:     Debug mode
  D2:     Cpu halted due to error
  D4:D3   Ethernet speed. 00=10M, 01=100M, 10=1G

* This template design previously contained USB controllers.
  Due to the timing of the FPGA, the USB transceiver having an IO
  voltage of 1.8V and the design of the USB device core it is
  unlikely that the required timing for the USB interface can be
  reached. The kit is not suitable for use with the USB IP cores.
 
* Example output from GRMON is:

$ grmon -eth -ip 192.168.0.51 -nb -u
  
  GRMON2 LEON debug monitor v2.0.39 internal version
  
  Copyright (C) 2013 Aeroflex Gaisler - All rights reserved.
  For latest updates, go to http://www.gaisler.com/
  Comments or bug-reports to support@gaisler.com
  

Parsing -eth
Parsing -ip 192.168.0.51
Parsing -nb
Parsing -u

Commands missing help:
 datacache

 Ethernet startup...
  GRLIB build version: 4133
  Detected frequency:  50 MHz
  
  Component                            Vendor
  LEON3 SPARC V8 Processor             Aeroflex Gaisler
  AHB Debug UART                       Aeroflex Gaisler
  JTAG Debug Link                      Aeroflex Gaisler
  GR Ethernet MAC                      Aeroflex Gaisler
  LEON2 Memory Controller              European Space Agency
  AHB/APB Bridge                       Aeroflex Gaisler
  LEON3 Debug Support Unit             Aeroflex Gaisler
  Xilinx MIG DDR2 Controller           Aeroflex Gaisler
  AHB/APB Bridge                       Aeroflex Gaisler
  Generic UART                         Aeroflex Gaisler
  Multi-processor Interrupt Ctrl.      Aeroflex Gaisler
  Modular Timer Unit                   Aeroflex Gaisler
  PS2 interface                        Aeroflex Gaisler
  PS2 interface                        Aeroflex Gaisler
  SVGA frame buffer                    Aeroflex Gaisler
  AMBA Wrapper for OC I2C-master       Aeroflex Gaisler
  General Purpose I/O port             Aeroflex Gaisler
  General Purpose I/O port             Aeroflex Gaisler
  General Purpose I/O port             Aeroflex Gaisler
  AHB Status Register                  Aeroflex Gaisler
  Unknown device                       Aeroflex Gaisler
  
  Use command 'info sys' to print a detailed report of attached cores

grmon2> info sys
  cpu0      Aeroflex Gaisler  LEON3 SPARC V8 Processor    
            AHB Master 0
  ahbuart0  Aeroflex Gaisler  AHB Debug UART    
            AHB Master 1
            APB: 80000700 - 80000800
            Baudrate 115200, AHB frequency 50.00 MHz
  ahbjtag0  Aeroflex Gaisler  JTAG Debug Link    
            AHB Master 2
  greth0    Aeroflex Gaisler  GR Ethernet MAC    
            AHB Master 3
            APB: 80000E00 - 80000F00
            IRQ: 6
            1000 Mbit capable
            edcl ip 192.168.0.51, buffer 16 kbyte
  mctrl0    European Space Agency  LEON2 Memory Controller    
            AHB: 00000000 - 20000000
            APB: 80000000 - 80000100
            8-bit prom @ 0x00000000
  apbmst0   Aeroflex Gaisler  AHB/APB Bridge    
            AHB: 80000000 - 80100000
  dsu0      Aeroflex Gaisler  LEON3 Debug Support Unit    
            AHB: 90000000 - A0000000
            AHB trace: 256 lines, 32-bit bus
            CPU0:  win 8, hwbp 2, itrace 256, V8 mul/div, srmmu, lddel 1
                   stack pointer 0x47fffff0
                   icache 2 * 8 kB, 32 B/line rnd
                   dcache 2 * 4 kB, 16 B/line rnd
  mig0      Aeroflex Gaisler  Xilinx MIG DDR2 Controller    
            AHB: 40000000 - 48000000
            APB: 80100000 - 80100100
            SDRAM: 128 Mbyte
  apbmst1   Aeroflex Gaisler  AHB/APB Bridge    
            AHB: 80100000 - 80200000
  uart0     Aeroflex Gaisler  Generic UART    
            APB: 80000100 - 80000200
            IRQ: 2
            Baudrate 38343
  irqmp0    Aeroflex Gaisler  Multi-processor Interrupt Ctrl.    
            APB: 80000200 - 80000300
  gptimer0  Aeroflex Gaisler  Modular Timer Unit    
            APB: 80000300 - 80000400
            IRQ: 8
            8-bit scalar, 2 * 32-bit timers, divisor 50
  ps2ifc0   Aeroflex Gaisler  PS2 interface    
            APB: 80000400 - 80000500
            IRQ: 4
  ps2ifc1   Aeroflex Gaisler  PS2 interface    
            APB: 80000500 - 80000600
            IRQ: 5
  svga0     Aeroflex Gaisler  SVGA frame buffer    
            APB: 80000600 - 80000700
            clk0: 50.00 MHz  clk1:   inf MHz  clk2:   inf MHz  clk3:   inf MHz
  i2cmst0   Aeroflex Gaisler  AMBA Wrapper for OC I2C-master    
            APB: 80000900 - 80000A00
            IRQ: 3
  gpio0     Aeroflex Gaisler  General Purpose I/O port    
            APB: 80000A00 - 80000B00
  gpio1     Aeroflex Gaisler  General Purpose I/O port    
            APB: 80000B00 - 80000C00
  gpio2     Aeroflex Gaisler  General Purpose I/O port    
            APB: 80000C00 - 80000D00
  ahbstat0  Aeroflex Gaisler  AHB Status Register    
            APB: 80000D00 - 80000E00
            IRQ: 1
  adev20    Aeroflex Gaisler  Unknown device    
            APB: 80001000 - 80002000
  
grmon2> 

