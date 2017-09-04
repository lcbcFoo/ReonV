
LEON3 design for Digilent Atlys board
-------------------------------------

This is a LEON3 design for the Digilent Atlys board with
Xilinx Spartan-6 LX45 FPGA.

http://www.digilentinc.com/

This design was contributed by Joris van Rantwijk.

Simulation and synthesis
------------------------

To synthesize the design, run
  $ make xconfig
  $ make ise (or make ise-synp to use Synplify for synthesis)

The FPGA can be programmed directly using "make ise-prog-fpga".

Design specifics
----------------

* System reset is mapped to the RESET button.

* DSU-enable is mapped to switch SW7 (slide up to enable DSU)
  DSU-break is mapped to switch SW6  (slide up to force DSU break)
  DSU-active is indicated on LED LD6 (LED on when CPU in debug mode)
  Error is indicated on LED LD7      (LED on when CPU in error mode)

* The AHB and processor are clocked at 50 MHz.

* The GRETH core is enabled and runs without problems at 100 Mbit.
  Ethernet debug link is enabled and has IP 192.168.0.51.

  1 Gbit operation is currently not implemented.

* DDR2 memory runs at 150 MHz, phase-locked to the AHB clock.
  The read delay in the DDR2SPA controller MUST be tuned by software
  at boot time before the DDR2 memory can be used.

* SPI flash memory is mapped at 0x00000000 if the AHBROM core is
  disabled (default configuration) or 0xe0000000 if the AHBROM
  core is enabled.
  This memory is used for the FPGA configuration bitstream and
  also as LEON3 ROM area.

* The console UART1 is connected to the on-board serial-to-USB adapter.
  It is also possible to connect the GRMON debug UART to the USB adapter
  instead of UART1. This requires a change in the pre-synthesis
  configuration (make xconfig).

* LEDs LD0 to LD5 are mapped to GPIO bits 0 to 5.
  Switches SW0 to SW5 are mapped to GPIO bits 8 to 13.
  Buttons BTNU, BTNL, BTND, BTNR, BTNC are mapped to GPIO bits 16 to 20.
  The PMODA port is mapped to GPIO bits 24 to 31.

* HDMI output is supported via APBVGA or SVGACTRL.
  SVGACTRL video modes are limited to 640x480 or 800x600 with 8-bit
  or 16-bit color (due to TMDS bitrate and AHB bus loading).

* PS/2 keyboard emulation works.
  PS/2 mouse emulation seems to have some problems.

* The LEON processor will be kept in reset until the SPIMCTRL is
  initialized (spmo.initialized is asserted).

* Audio is not supported (yet).


DDR2 memory
-----------

The Atlys board contains 128 MByte DDR2 memory.
The DDR2SPA controller from GRLIB is used to access the memory.

Memory organization of the DDR2 chip is as follows:
 * 16-bit data bus
 * 8 banks
 * 13-bit row address
 * 10-bit column address

The DDR2SPA controller is configured as follows:
 DDR2 clock frequency = 150 MHz, phase-locked to the 50 MHz AHB clock
 CAS latency = 3 CK
 tREFRESH    = 7.8 us (1170 CK)
 tRCD        = 2 CK
 tRP         = 2 CK
 tRFC        = 130 ns = 20 CK
 tRTP        = 2 CK
 tRAS        = 6 CK
 read delay  = 1

This translates to the following values for the DDR2 configuration registers:
  DDR2CFG1 = 0x82208491
  DDR2CFG3 = 0x02c50000
  DDR2CFG4 = 0x00000100
  DDR2CFG5 = 0x00470004

The Spartan-6 version of the DDR2SPA controller uses IODELAY2 components
to capture read data from the memory chip. These delays MUST be tuned
by software at boot time before the DDR2 memory is usable.

Optimum delay tuning may vary from board to board. The following
configuration gives good results on one test board:

  Write DDR2CFG3 <- 0x82c50000      (reset IODELAY2)
  Repeat 72 times:
      Write DDR2CFG3 <- 0x02c5ffff  (increment delay)

A small program is available to tune the DDR2 memory from GRMON:
  grlib> load bin/ddrtune.exe
  grlib> run

This must be done after board power-on and after each AHB reset If
GRMON did not correctly detect the RAM size (visiable via info sys),
then you MUST exit GRMON and start it again so that GRMON will
properly detect the DDR2 SDRAM.


SPI flash memory
----------------

The Atlys board contains a Numonyx N25Q128 16 MByte SPI flash memory.
This memory is used to store the FPGA bitstream, and may also
be used as a ROM device for the LEON3. In order to use the SPI memory
device with the LEON system, JP11 on the board must be closed. This
means that the FPGA will not load its configuration from the SPI
memory. It appears that the FPGA leaves the Flash in QSPI mode and
this mode is not supported by the SPIMCTRL memory controller. A fix
for this is under development.

Note: If the SPIMCTRL is disabled (via xconfig or by directly editing
config.vhd then the SPICTRL core can be included in the design).

The SPIMCTRL component from GRLIB is used to access SPI flash memory.
The ROM area is mapped at address 0xe0000000.  The first 2 MByte of
this area are reserved for the FPGA bitstream. Currently the design
cannot use the SPI memory if the FPGA has been configured for SPI so
this offset is ignored.The SPIMCTRL memory controller can
automatically adjusts for this and 0x200000 can be added to the
address when accessing the memory-mapped Flash area.

The SPI memory may be used to store a boot image. In this case there are
a few board-specific issues that need attention:

 * The DDR2SPA controller must be tuned for correct read timing before
   the DDR2 memory can be used.

 * Note that if the AHBROM core is enabled in the design (it is disabled in
   the default configuration) then the SPI flash memory is mapped at
   0xe0000000 instead of at address 0.


MKPROM2 may be used to generate a ROM image for the SPI memory.  For
example, a PROM image may be generated and loaded into the SPI memory
as follows:

  $ sparc-elf-gcc -c bdinit.S
  $ mkprom2 -msoft-float -baud 38400 -leon3 -freq 50 -rstaddr 0x00000000 \
            -nosram -ddrram 128 -ddrbanks 1 -ddrfreq 150 -ddrcol 1024 \
            -bdinit program.exe -o program.prom
  
  An example how to load an image to SPI flash using GRMON2 is shown
  in the first GRMON example session further down in this readme file.
  The commands that need to be used are:
  
  spim flash detect
  spim flash erase
  spim flash load <file>

Note that if the AHBROM core is enabled and the SPIMCTRL memory area is
moved to 0xe0000000 then the -rstaddr argument above needs to be changed
to -rstaddr 0xe0000000.

AHBROM contents
---------------

The AHBROM core can be optionally enabled in the design. If this core
is enabled then it will provide a ROM at address 0. Enabling AHBROM
will also move the SPIMCTRL memory area from address 0 to address
0xe0000000.

Wen the AHBROM is enabled, the code in ahbrom.S is embedded in an
AHBROM block and synthesized into the FPGA firmware. The AHBROM block
is mapped at address 0x00000000 and performs the following functions:

 * waits until SPIMCTRL is initialized;
 * tunes DDR2 read timing;
 * jumps to MKPROM2 boot loader at address 0xe0000000.

If the AHBROM core is enabled then the default test bench will fail
due to the testbench being adapted for SPIMCTRL at address 0 and no
change in DDR2 SDRAM read timing.

GRMON output
------------

NOTE: When connecting with GRMON you may see messages like:

Cannot continue, processor not in debug mode

when GRMON cannot immediately get control of the CPU as the CPU has an
access ongoing toward the SPI memory interface. To avoid this, enable
the DSU and set DSU break.


-bash-4.1$ grmon2cli -xilusb -u -nb

  GRMON2 LEON debug monitor v2.0.70 32-bit internal version
  
  Copyright (C) 2016 Cobham Gaisler - All rights reserved.
  For latest updates, go to http://www.gaisler.com/
  Comments or bug-reports to support@gaisler.com
  

Xilusb: Cable type/rev : 0x3 
 JTAG chain (1): xc6slx45 

  GRLIB build version: 4163
  Detected frequency:  50 MHz
  
  Component                            Vendor
  LEON3 SPARC V8 Processor             Cobham Gaisler
  JTAG Debug Link                      Cobham Gaisler
  GR Ethernet MAC                      Cobham Gaisler
  AHB/APB Bridge                       Cobham Gaisler
  LEON3 Debug Support Unit             Cobham Gaisler
  SPI Memory Controller                Cobham Gaisler
  Single-port DDR2 controller          Cobham Gaisler
  Single-port AHB SRAM module          Cobham Gaisler
  Generic UART                         Cobham Gaisler
  Multi-processor Interrupt Ctrl.      Cobham Gaisler
  Modular Timer Unit                   Cobham Gaisler
  PS2 interface                        Cobham Gaisler
  PS2 interface                        Cobham Gaisler
  VGA controller                       Cobham Gaisler
  General Purpose I/O port             Cobham Gaisler
  AHB Status Register                  Cobham Gaisler
  
  Use command 'info sys' to print a detailed report of attached cores

grmon2> info sys spim0
  spim0     Cobham Gaisler  SPI Memory Controller    
            AHB: FFF00200 - FFF00300
            AHB: 00000000 - 01000000
            IRQ: 11
            SPI memory device read command: 0x03
  
grmon2> spim flash detect
  Got manufacturer ID 0x20 and device ID 0xba18
  Detected device: ST/Numonyx N25Q128
  
grmon2> spim flash erase
  Erase successful!
  
grmon2> spim flash load hello.srec 
  .srec 00000000 hello.srec          82.2kB /  82.2kB   [===============>] 100%
  Total size: 29.86kB (20.16kbit/s)
  Entry point 0x0
  Image /home/jan/GRLIB/master/designs/leon3-digilent-atlys/hello.srec loaded
  
grmon2> verify hello.srec
  .srec 00000000 hello.srec          82.2kB /  82.2kB   [===============>] 100%
  Total size: 29.86kB (64.00kbit/s)
  Entry point 0x0
  Image of /home/jan/GRLIB/master/designs/leon3-digilent-atlys/hello.srec verified without errors
  
grmon2> 








Connecting via Ethernet and tuning the DDR2 read delay:




bash-4.1$ grmon2cli -eth 192.168.0.51 

  GRMON2 LEON debug monitor v2.0.70 32-bit internal version
  
  Copyright (C) 2016 Cobham Gaisler - All rights reserved.
  For latest updates, go to http://www.gaisler.com/
  Comments or bug-reports to support@gaisler.com
  
 Ethernet startup...
  GRLIB build version: 4163
  Detected frequency:  50 MHz
  
  Component                            Vendor
  LEON3 SPARC V8 Processor             Cobham Gaisler
  JTAG Debug Link                      Cobham Gaisler
  GR Ethernet MAC                      Cobham Gaisler
  AHB/APB Bridge                       Cobham Gaisler
  LEON3 Debug Support Unit             Cobham Gaisler
  SPI Memory Controller                Cobham Gaisler
  Single-port DDR2 controller          Cobham Gaisler
  Single-port AHB SRAM module          Cobham Gaisler
  Generic UART                         Cobham Gaisler
  Multi-processor Interrupt Ctrl.      Cobham Gaisler
  Modular Timer Unit                   Cobham Gaisler
  PS2 interface                        Cobham Gaisler
  PS2 interface                        Cobham Gaisler
  VGA controller                       Cobham Gaisler
  General Purpose I/O port             Cobham Gaisler
  AHB Status Register                  Cobham Gaisler
  
  Use command 'info sys' to print a detailed report of attached cores

grmon2> info sys ddr2spa0

   ddr2spa0  Cobham Gaisler  Single-port DDR2 controller    
            AHB: 40000000 - 48000000
            AHB: FFF00100 - FFF00200
            No SDRAM found
  
grmon2> 
grmon2> load bin/ddrtune.exe 
  A0000000 .text                      896B              [===============>] 100%
  Total size: 896B (0.00bit/s)
  Entry point 0xa0000000
  Image /home/jan/GRLIB/master/designs/leon3-digilent-atlys/bin/ddrtune.exe loaded
  
grmon2> run
  Program exited normally.
  
grmon2> ^DExiting GRMON
bash-4.1$ grmon2cli -eth 192.168.0.51 

< output removed >

  GRMON2 LEON debug monitor v2.0.70 32-bit internal version
  
  Copyright (C) 2016 Cobham Gaisler - All rights reserved.
  For latest updates, go to http://www.gaisler.com/
  Comments or bug-reports to support@gaisler.com

grmon2> info sys ddr2spa0
  ddr2spa0  Cobham Gaisler  Single-port DDR2 controller    
            AHB: 40000000 - 48000000
            AHB: FFF00100 - FFF00200
            16-bit DDR2 : 1 * 128 MB @ 0x40000000, 8 internal banks
            150 MHz, col 10, ref 7.8 us, trfc 133 ns
  
grmon2> 




