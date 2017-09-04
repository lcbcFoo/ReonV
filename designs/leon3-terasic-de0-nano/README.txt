LEON3 Template design for TerASIC Altera DE0-Nano
------------------------------------------------------

0. Introduction
---------------

The LEON3 design can be synthesized with quartus or synplify, and can
reach 50 - 70 MHz depending on configuration and synthesis
options. Use 'make quartus' or 'make quartus-synp' to run the complete
flow. To program the FPGA in batch mode, use 'make quartus-prog-fpga'
or 'make quartus-prog-fpga-ref (reference config).  On linux, you
might need to start jtagd as root to get the proper port permissions.

* System reset is mapped to Key 0
* DSU break is mapped to Key 1
* SW 0 is mapped to DSU enable
* DSU active is mapped to LED 7
* Processor error mode indicator is mapped to LED 6

The output from grmon should look something like this:

  GRMON2 LEON debug monitor v2.0.24b-19-g3c2d5b6
  
  Copyright (C) 2012 Aeroflex Gaisler - All rights reserved.
  For latest updates, go to http://www.gaisler.com/
  Comments or bug-reports to support@gaisler.com
  
 JTAG chain (1): EP3C25/EP4CE22 

  GRLIB build version: 4114
  Detected frequency:  50 MHz
  
  Component                            Vendor
  LEON3 SPARC V8 Processor             Aeroflex Gaisler
  JTAG Debug Link                      Aeroflex Gaisler
  SPI Memory Controller                Aeroflex Gaisler
  AHB/APB Bridge                       Aeroflex Gaisler
  LEON3 Debug Support Unit             Aeroflex Gaisler
  PC133 SDRAM Controller               Aeroflex Gaisler
  Generic UART                         Aeroflex Gaisler
  Multi-processor Interrupt Ctrl.      Aeroflex Gaisler
  Modular Timer Unit                   Aeroflex Gaisler
  AMBA Wrapper for OC I2C-master       Aeroflex Gaisler
  SPI Controller                       Aeroflex Gaisler
  General Purpose I/O port             Aeroflex Gaisler
  General Purpose I/O port             Aeroflex Gaisler
  General Purpose I/O port             Aeroflex Gaisler
  AHB Status Register                  Aeroflex Gaisler
  
  Use command 'info sys' to print a detailed report of attached cores

grmon2> info sys
  cpu0      Aeroflex Gaisler  LEON3 SPARC V8 Processor    
            AHB Master 0
  ahbjtag0  Aeroflex Gaisler  JTAG Debug Link    
            AHB Master 1
  spim0     Aeroflex Gaisler  SPI Memory Controller    
            AHB: FFF00200 - FFF00300
            AHB: 00000000 - 10000000
            IRQ: 9
            SPI memory device read command: 0x0b
  apbmst0   Aeroflex Gaisler  AHB/APB Bridge    
            AHB: 80000000 - 80100000
  dsu0      Aeroflex Gaisler  LEON3 Debug Support Unit    
            AHB: 90000000 - A0000000
            AHB trace: 128 lines, 32-bit bus
            CPU0:  win 8, hwbp 2, itrace 128, V8 mul/div, lddel 1
                   stack pointer 0x40fffff0
                   icache 2 * 4 kB, 32 B/line rnd
                   dcache 1 * 4 kB, 16 B/line 
  sdctrl0   Aeroflex Gaisler  PC133 SDRAM Controller    
            AHB: 40000000 - 42000000
            AHB: FFF00100 - FFF00200
            32-bit sdram: 1 * 0 Mbyte @ 0x40000000, 
            col 8, cas 2, ref 7.8 us
  uart0     Aeroflex Gaisler  Generic UART    
            APB: 80000100 - 80000200
            IRQ: 2
            Baudrate 38343
  irqmp0    Aeroflex Gaisler  Multi-processor Interrupt Ctrl.    
            APB: 80000200 - 80000300
  gptimer0  Aeroflex Gaisler  Modular Timer Unit    
            APB: 80000300 - 80000400
            IRQ: 8
            16-bit scalar, 2 * 32-bit timers, divisor 50
  i2cmst0   Aeroflex Gaisler  AMBA Wrapper for OC I2C-master    
            APB: 80000400 - 80000500
            IRQ: 3
  spi0      Aeroflex Gaisler  SPI Controller    
            APB: 80000500 - 80000600
            IRQ: 5
            FIFO depth: 4, 1 slave select signals
            Maximum word length: 32 bits
            Supports 3-wire mode
            Controller index for use in GRMON: 0
  grgpio0   Aeroflex Gaisler  General Purpose I/O port    
            APB: 80000900 - 80000A00
  grgpio1   Aeroflex Gaisler  General Purpose I/O port    
            APB: 80000A00 - 80000B00
  grgpio2   Aeroflex Gaisler  General Purpose I/O port    
            APB: 80000B00 - 80000C00
  ahbstat0  Aeroflex Gaisler  AHB Status Register    
            APB: 80000F00 - 80001000
            IRQ: 1
            non-correctable read error of size 0 by master 0 at 0x00000000
  
grmon2> spim flash detect
  Got manufacturer ID 0x20 and device ID 0x2017
  Detected device: ST/Numonyx M25P64
  
1. SDRAM interface
---------------

The SDRAM is available via the MCTRL controller.

2. Flash memory
---------------

Boot Flash is provided via SPIMCTRL from the board's EPCS device.

The design can also use on-chip ROM via the AHBROM core. Note that the
SPI memory controller must be disabled to include the AHBROM core in
the design. If both cores are enabled in xconfig only the SPI memory
controller will be instantiated in leon3mp.vhd.

The rest of this section explains how to work with SPIMCTRL in this
design:

Typically the lower part of the EPCS device will hold the
configuration bitstream for the FPGA. The SPIMCTRL core is configured
with an offset value that will be added to the incoming AHB address
before the address is propagated to the EPCS device. The default
offset is 0x50000 (this value is set via xconfig and the constant is
called CFG_SPIMCTRL_OFFSET). When the processor starts after power-up
it will read address 0x0, this will be translated by SPIMCTRL to
0x50000. (See section 8 below for how to program the FPGA configuration
bitstream into the EPCS device).

SPIMCTRL can only add this offset to accesses made via the core's
memory area. For accesses made via the register interface the offset
must be taken into account. This means that if we want to program the
Flash with an application which is linked to address 0x0 (our typical
bootloader) then we need to add the offset 0x50000 before programming
the file with GRMON. We load the Flash with our application starting
at 0x50000 and SPIMCTRL will then translate accesses from AMBA address
0x0 + n to Flash address 0x50000 + n.

The example below shows how to program prom.srec, which should be
present at AMBA address 0x0 to a SPI Flash device where SPIMCTRL adds
an offset to the incoming address.

First we check which offset that SPIMCTRL adds:

user@host:~/gaisler/grlib_git/designs/leon3-terasic-de0-nano$ grep SPIMCTRL_OFFSET config.vhd
  constant CFG_SPIMCTRL_OFFSET : integer := 16#50000#;

.. SPIMCTRL will add 0x50000 to the AMBA address. We now create a
S-REC file where we add this offset to our data. There are several
tools that allow us to do this (including search and replace in a text
editor) here we use srec_cat to create prom_off.srec:

user@host:~/grlib/designs/leon3-terasic-de0-nano$ srec_cat prom.srec -offset 0x50000 -o prom_off.srec
user@host:~/grlib/designs/leon3-terasic-de0-nano$ srec_info prom.srec 
Format: Motorola S-Record
Header: "prom.srec"
Execution Start Address: 00000000
Data:   0000 - 022F
user@host:~/grlib/designs/leon3-terasic-de0-nano$ srec_info prom_off.srec 
Format: Motorola S-Record
Header: "prom.srec"
Execution Start Address: 00050000
Data:   050000 - 05022F
user@host:~/grlib/designs/leon3-terasic-de0-nano$ 

We then use GRMON2 to load the S-REC. First we check that our Flash device does not
contain data at (AMBA) address 0x0:

grmon2> mem 0
  0x00000000  ffffffff  ffffffff  ffffffff  ffffffff    ................
  0x00000010  ffffffff  ffffffff  ffffffff  ffffffff    ................
  0x00000020  ffffffff  ffffffff  ffffffff  ffffffff    ................
  0x00000030  ffffffff  ffffffff  ffffffff  ffffffff    ................

If all data is not 0xff at this address then either there is
configuration data at the specified offset (and the design can be
synthesized with a larger offset), or the Flash has previously been
programmed with application data.

If the Flash is erased (all 0xFF) we can proceed with loading our S-REC:

grmon2> spim flash detect
  Got manufacturer ID 0x20 and device ID 0x2017
  Detected device: ST/Numonyx M25P64
  
grmon2> spim flash load prom_off.srec
  00050000 prom.srec                  1.4kB /   1.4kB   [===============>] 100%
  Total size: 560B (1.52kbit/s)
  Entry point 0x50000
  Image /home/user/grlib/designs/leon3-terasic-de0-nano/prom_off.srec loaded

The data has been loaded and is available at address 0x0:

grmon2> mem 0
  0x00000000  81d82000  03000004  821060e0  81884000    .. .......`...@.
  0x00000010  81900000  81980000  81800000  a1800000    ................
  0x00000020  01000000  03002040  8210600f  c2a00040    ...... @..`....@
  0x00000030  84100000  01000000  01000000  01000000    ................
  
grmon2> 

The "verify" command in GRMON performs normal memory accesses. Using
this command we can check that what the processor will see matches
what we have in the (unmodified) prom.srec:

grmon2> verify prom.srec
  00000000 prom.srec                  1.5kB /   1.5kB   [===============>] 100%
  Total size: 560B (10.64kbit/s)
  Entry point 0x0
  Image of /home/user/grlib/designs/leon3-terasic-de0-nano/prom.srec verified without errors
  
grmon2> 

The flash can be cleared using the GRMON command "spim flash erase".
Note that this will erase the entire Flash device, including the FPGA
configuration bitstream.

For simulation, the spi_flash simulation Model in testbench.vhd knows
about the offset and will subtract the offset value before accessing
its internal memory array. To illustrate:

1. Processor AMBA address ->  SPIMCTRL
2. SPIMCTRL creates Flash address = Amba address + CFG_SPIMCTRL_OFFSET 
    and sends to spi_flash 
3. spi_flash calculates: Memory array address = Flash address-CFG_SPIMCTRL_OFFSET = AMBA address
4. spi_flash returns data, which is prom.srec[AMBA address]

3. UART
---------------

The design has one UART, which is not mapped to the outside world.

4. I2C
---------------

One I2CMST core is connected to the board's I2C bus where the EEPROM
and accelerometer can be accessed:


grmon2> i2c scan
  Scanning 7-bit address space on I2C bus:
  Detected I2C device at address 0x1d
  Detected I2C device at address 0x50
  Detected I2C device at address 0x51
  Detected I2C device at address 0x52
  Detected I2C device at address 0x53
  Detected I2C device at address 0x54
  Detected I2C device at address 0x55
  Detected I2C device at address 0x56
  Detected I2C device at address 0x57
  
  Scan of I2C bus completed. 9 devices found
  
grmon2> 

The g_sensor_int signalis mapped to the GRGPIO2 core (see below)

g_sensor_cs_n is constant HIGH.

5. ADC
---------------

A SPICTRL SPI controller core is connected to the board's ADC

6. GPIO
---------------

The design has four GRGPIO ports.

GRGPIO0 is connected to board signal GPIO_0[31:0]
GRGPIO1 is connected to board signal GPIO_1[31:0]
GRGPIO2 is connected as follows:

 GRGPIO2 line(s)  Direction   Board signal
   12:0             <->        GPIO_2[12:0]
   15:13            <-         GPIO_2_IN[2:0]
   17:16            <->        GPIO_0[33:32]
   19:18            <-         GPIO_0_IN[1:0]
   21:20            <->        GPIO_1[33:32]
   23:22            <-         GPIO_1_IN[1:0]
   29:24             ->        LED[5:0]
    30              <-         g_sensor_int

The instantiation and configuration if GRFPIO0 and GRFPIO1 can be
controlled via xconfig. GRGPIO2 is always included in the design.

7. Other functions
---------------

SW[3:1] are unused.


8. Programming the EPCS device
-------------------------------

For instructions on programming the serial configuration device refer
to the DE0 user manual (convert leon3mp.sof to a .jic file, targeting
EPCS16, enable compression for the SOF, and write the generated file
to the EPCS device).

