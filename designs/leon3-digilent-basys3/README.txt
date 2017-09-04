This LEON design is tailored to the Digilent Basys3 board
---------------------------------------------------------

Simulation and synthesis
------------------------

The design currently supports synthesis with Xilinx Vivado (tested
with Vivado 2015.2, 2015.3 and 2015.4).

Currently the design won't simulate correctly with the provided ram.srec, since this is too large for the RAM and will result in a trap.

To simulate using XSIM and run systest.c on the LEON design use the make targets:

  make soft
  make vivado-launch

To simulate using Modelsim/Aldec and run systest.c on the Leon ise:

  make sim (only required if Modelsim/Aldec is used as simulator)
  make soft
  make sim-launch

To simulate using Aldec Riviera use the following make targets:

  make riviera
  make soft
  make riviera-launch

To synthesize the design, do

  make vivado (or make vivado-launch for the GUI flow)

Finally, to program the FPGA:
  
  make vivado-prog-fpga

Design specifics
----------------

* This design is experimental. IP cores such as SVGACTRL could make
  a nice addition to this design.

* The default configuration sets the system frequency to 70 MHz.

* System reset is mapped to the center button

* SW 0 selects if UART should be connected to the system UART
  or debug UART (AHBUART)

* In order to connect through the USB JTAG-interface run "grmon -digilent".

* The JTAG DSU interface is enabled and accessible via the USB/JTAG port
  and USB/UART.
  Start grmon with -digilent to connect with USB/JTAG.

* The on-board SPI-Flash memory is interfaced through the Gaisler SPI
  memory controller, and it is mapped at address 0x0.  By default, the
  simulation assumes that the boot-code is read from the SPI-Flash.
  To enable it issue "make xconfig" and set the SPI Memory controller
  tab. The following configuration has been tested on hardware:

- Enable SD card support:              No
- Read instruction:                    0B
- Dummy byte:                          No
- Dual output:                         No
- Address offset:                      0
- Clock divisor for device clock:      2
- Clock divisor for alt. device clock: 2

Example GRMON output:

-bash-4.1$ grmon2cli -digilent -u

  GRMON2 LEON debug monitor v2.0.70 32-bit internal version
  
  Copyright (C) 2016 Cobham Gaisler - All rights reserved.
  For latest updates, go to http://www.gaisler.com/
  Comments or bug-reports to support@gaisler.com
  
 JTAG chain (1): xc7a35t 
  GRLIB build version: 4162
  Detected frequency:  90 MHz
  
  Component                            Vendor
  LEON3 SPARC V8 Processor             Cobham Gaisler
  AHB Debug UART                       Cobham Gaisler
  JTAG Debug Link                      Cobham Gaisler
  SPI Memory Controller                Cobham Gaisler
  AHB/APB Bridge                       Cobham Gaisler
  LEON3 Debug Support Unit             Cobham Gaisler
  Single-port AHB SRAM module          Cobham Gaisler
  Generic UART                         Cobham Gaisler
  Multi-processor Interrupt Ctrl.      Cobham Gaisler
  Modular Timer Unit                   Cobham Gaisler
  
  Use command 'info sys' to print a detailed report of attached cores

grmon2> load ~/tests/hello
  40000000 .text                     39.0kB /  39.0kB   [===============>] 100%
  40009C20 .data                      2.9kB /   2.9kB   [===============>] 100%
  Total size: 41.90kB (449.89kbit/s)
  Entry point 0x40000000
  Image /home/jan/tests/hello loaded
  
grmon2> run
Hello world!
  
  Program exited normally.
  
grmon2> info sys
  cpu0      Cobham Gaisler  LEON3 SPARC V8 Processor    
            AHB Master 0
  ahbuart0  Cobham Gaisler  AHB Debug UART    
            AHB Master 1
            APB: 80000700 - 80000800
            Baudrate 115200, AHB frequency 90.00 MHz
  ahbjtag0  Cobham Gaisler  JTAG Debug Link    
            AHB Master 2
  spim0     Cobham Gaisler  SPI Memory Controller    
            AHB: FFF70000 - FFF70100
            AHB: 00000000 - 01000000
            IRQ: 7
            SPI memory device read command: 0x0b
  apbmst0   Cobham Gaisler  AHB/APB Bridge    
            AHB: 80000000 - 80100000
  dsu0      Cobham Gaisler  LEON3 Debug Support Unit    
            AHB: 90000000 - A0000000
            AHB trace: 64 lines, 32-bit bus
            CPU0:  win 8, hwbp 2, itrace 64, V8 mul/div, lddel 1
                   stack pointer 0x4001fff0
                   icache 2 * 4 kB, 32 B/line
                   dcache 2 * 4 kB, 32 B/line
  ahbram0   Cobham Gaisler  Single-port AHB SRAM module    
            AHB: 40000000 - 40100000
            32-bit static ram: 128 kB @ 0x40000000
  uart0     Cobham Gaisler  Generic UART    
            APB: 80000100 - 80000200
            IRQ: 2
            Baudrate 38395, FIFO debug mode
  irqmp0    Cobham Gaisler  Multi-processor Interrupt Ctrl.    
            APB: 80000200 - 80000300
  gptimer0  Cobham Gaisler  Modular Timer Unit    
            APB: 80000300 - 80000400
            IRQ: 8
            8-bit scalar, 2 * 32-bit timers, divisor 90
  
grmon2> spim flash detect
  Got manufacturer ID 0x01 and device ID 0x0215
  Detected device: ST/Numonyx M25P32
  
grmon2> ^DExiting GRMON
