
This LEON3 design is tailored to the Altera/Arrow/Hitex BeMicro SDK kit

0. Introduction
---------------

The design can be synthesized with Quartus II, Use 'make quartus' to
run the complete flow. To program the FPGA in batch mode, use 
'make quartus-prog-fpga' or 'make quartus-prog-fpga-ref (LEON3 
reference config).

* System reset is mapped to the "Reset" push button

* DSU break is mapped to the "User" push button

* DSU active is connected to LED8

* Processor in error mode is connected to LED7

* LED[6:1] is connected to GPIO[5:0].

1. Boot ROM
-----------

Boot Flash is provided via SPIMCTRL from the board's EPCS device.

The design can also use on-chip ROM via the AHBROM core. Note that the
SPI memory controller must be disabled to include the AHBROM core in
the design. If both cores are enabled in xconfig only the AHBROM core
will be instantiated in leon3mp.vhd.

The rest of this section explains how to work with SPIMCTRL in this
design:

Typically the lower part of the EPCS device will hold the
configuration bitstream for the FPGA. The SPIMCTRL core is configured
with an offset value that will be added to the incoming AHB address
before the address is propagated to the EPCS device. The default
offset is 0x50000 (this value is set via xconfig and the constant is
called CFG_SPIMCTRL_OFFSET). When the processor starts after power-up
it will read address 0x0, this will be translated by SPIMCTRL to
0x50000. (See section below for how to program the FPGA configuration
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

user@host$ grep SPIMCTRL_OFFSET config.vhd
  constant CFG_SPIMCTRL_OFFSET : integer := 16#50000#;

.. SPIMCTRL will add 0x50000 to the AMBA address. We now create a
S-REC file where we add this offset to our data. There are several
tools that allow us to do this (including search and replace in a text
editor) here we use srec_cat to create prom_off.srec:

user@host$ srec_cat prom.srec -offset 0x50000 -o prom_off.srec
user@host$ srec_info prom.srec 
Format: Motorola S-Record
Header: "prom.srec"
Execution Start Address: 00000000
Data:   0000 - 022F
user@host$ srec_info prom_off.srec 
Format: Motorola S-Record
Header: "prom.srec"
Execution Start Address: 00050000
Data:   050000 - 05022F
user@host$ 

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
 Got manufacturer ID 0x20 and Device ID 0x2015
 No device match for READ ID instruction, trying RES instruction..
 Found matching device: ST/Numonyx M25P16
  
grmon2> spim flash load prom_off.srec
  00050000 prom.srec                  1.4kB /   1.4kB   [===============>] 100%
  Total size: 560B (1.52kbit/s)
  Entry point 0x50000
  Image prom_off.srec loaded

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
  Image of prom.srec verified without errors
  
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

2. Simulation
--------------

In most designs, the testbench includes a module connected via a
memory controller that is accessed by system software in order to
present output to the simulator console.  In this design the leon3mp
entity will include a AHBREP module mapped at address 0x20000000 that
is used by system test software. This module will not be included when
the design is synthesized.

3. UART
--------

The BeMicro SDK does not have an external UART connector and the UART
cores i GRLIB cannot be used to directly interface with the FTDI USB
interface. An APBUART core is still included in the design. The core
can be used in loopback mode with GRMON in order to get a working
console for software.

3. System
---------

The output from grmon should look something like this:

$ ./grmon-eval.exe -altjtag -jtagdevice 1 -u

 GRMON LEON debug monitor v1.1.44 evaluation version

 Copyright (C) 2004-2010 Aeroflex Gaisler - all rights reserved.
 For latest updates, go to http://www.gaisler.com/
 Comments or bug-reports to support@gaisler.com

 This evaluation version will expire on 7/7/2011
 using Altera JTAG cable
 Selected cable 1 - USB-Blaster [USB-0]
JTAG chain:
@1: EP3C25/EP4CE22 (0x020F30DD)

 GRLIB build version: 4106

 initialising .............
 detected frequency:  50 MHz

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 GR Ethernet MAC                      Gaisler Research
 DDR266 Controller                    Gaisler Research
 AHB/APB Bridge                       Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 AHB ROM                              Gaisler Research
 General purpose I/O port             Gaisler Research
 Generic APB UART                     Gaisler Research
 Multi-processor Interrupt Ctrl       Gaisler Research
 Modular Timer Unit                   Gaisler Research
 SPI Controller                       Gaisler Research
 SPI Controller                       Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> info sys
00.01:003   Gaisler Research  LEON3 SPARC V8 Processor (ver 0x0)
            ahb master 0
01.01:01c   Gaisler Research  AHB Debug JTAG TAP (ver 0x1)
            ahb master 1
02.01:01d   Gaisler Research  GR Ethernet MAC (ver 0x0)
            ahb master 2, irq 10
            apb: 80000600 - 80000700
00.01:025   Gaisler Research  DDR266 Controller (ver 0x0)
            ahb: 40000000 - 50000000
            ahb: fff00100 - fff00200
            16-bit DDR : 1 * 64 Mbyte @ 0x40000000
                         100 MHz, col 10, ref 7.8 us, trfc 80 ns
01.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)
            ahb: 80000000 - 80100000
02.01:004   Gaisler Research  LEON3 Debug Support Unit (ver 0x1)
            ahb: 90000000 - a0000000
            AHB trace 128 lines, 32-bit bus, stack pointer 0x43fffff0
            CPU#0 win 8, hwbp 2, itrace 128, V8 mul/div, srmmu, lddel 1, GRFPU-lite
                  icache 2 * 4 kbyte, 32 byte/line lrr
                  dcache 2 * 4 kbyte, 16 byte/line lrr
03.01:01b   Gaisler Research  AHB ROM (ver 0x0)
            ahb: 00000000 - 00100000
00.01:01a   Gaisler Research  General purpose I/O port (ver 0x1)
            apb: 80000000 - 80000100
01.01:00c   Gaisler Research  Generic APB UART (ver 0x1)
            irq 2
            apb: 80000100 - 80000200
            baud rate 38343, DSU mode (FIFO debug)
02.01:00d   Gaisler Research  Multi-processor Interrupt Ctrl (ver 0x3)
            apb: 80000200 - 80000300
03.01:011   Gaisler Research  Modular Timer Unit (ver 0x0)
            irq 8
            apb: 80000300 - 80000400
            8-bit scaler, 2 * 32-bit timers, divisor 50
04.01:02d   Gaisler Research  SPI Controller (ver 0x2)
            irq 9
            apb: 80000400 - 80000500
            FIFO depth: 16, 1 slave select signals
            Maximum word length: 32 bits
            Controller index for use in GRMON: 1
05.01:02d   Gaisler Research  SPI Controller (ver 0x2)
            irq 11
            apb: 80000500 - 80000600
            FIFO depth: 16, 1 slave select signals
            Maximum word length: 32 bits
            Controller index for use in GRMON: 2
grlib> load hello
section: .text at 0x40000000, size 39968 bytes
section: .data at 0x40009c20, size 2940 bytes
total size: 42908 bytes (877.9 kbit/s)
read 208 symbols
entry point: 0x40000000
grlib> run
Hello world!

Program exited normally.
grlib>

4. DDR interface
----------------

The mobile DDR SDRAM interface is supported and runs at 100 MHz.

5. Temperature sensor
---------------------

The first SPICTRL SPI controller core is connected to the on-board
temperature sensor. The controller is hardcoded to support 3-wire mode
and this mode must be enabled via the core's register interface in
order to interact with the temperature sensor. An example of reading
the temperature from the sensor via GRMON is given below:

grlib> spi 1 set ms cpol cpha rev len 15 tw tto asel

 Current SPI controller configuration:

 Automated mode: Not available
 Automatic slave select: Enabled
 Automatic slave select change in clock gap: Disabled
 Loop mode: Disabled (normal operation)
 Clock polarity: Idle high (1)
 Clock phase: 1 (Data is read on second transition)
 Divide by 16: Disabled
 PM Factor field: 0 (factor = 4)
 Reverse data: MSB sent first (1)
 M/S: Master
 Enabled: No
 Character length: 16 (field value: 0xf)
 Prescale modulus: 0
 Clock gap: 0
 SCK is system clock divided by 4
 Core is configured for 3-wire mode
 3-wire mode transfer order: Slave sends first
 Pad mode: Normal

grlib> spi 1 aslvsel 0
grlib> spi 1 en

 SPI controller is now enabled

grlib> spi 1 tx 0
grlib> spi 1 tx 0
grlib> spi 1 tx 0
grlib> spi 1 tx 0
grlib> spi 1 rx 0

 Receive data: 0x0dff0000

grlib> spi 1 rx 0

 Receive data: 0x0dff0000

grlib> spi 1 rx 0

 Receive data: 0x0dff0000

grlib> spi 1 rx 0

 Receive data: 0x0dff0000

grlib> 

The read 16-bit value 0x0dff corresponds to approximately 28 deg
Celsius.


6. SPI SD Card interface
----------------

The design can be modified to include a SPIMCTRL core that is
connected to the SD card slot. The SPIMCTRL core allows reading from
a SD card without software support. This means that the SD card can be
used as a boot PROM if a PROM file is written in raw mode directly to
the start of card.

Suitable configuration values for SPIMCTRL are; SD Card = 1, Clock
divisor = 2, Alt. clock divisor = 7. Note that the SPIMCTRL core will
insert a large amount of wait states on the system bus if AMBA SPLIT
support is not enabled.

If the SD card will be used under an OS, it is better to use a SPICTRL
core connected to the SD card slot. The SPICTRL core will be higher
performance when accessing the SD card, but requires software
support. If the design is configured to include more than one SPI
controller, the second SPI controller will be connected to the SD card
slot.

In the current version of this design the SPIMCTRL connected to the
SD card has been commented out. To interface with the SD card either:
1) Enable both SPICTRL cores and use the second core to communicate
with the SD card, or
2) Modify leon3mp.vhd and include the instantiations of the, now
commented out, SPIMCTRL core connected to the SD card signals.

7. Ethernet interface
---------------------

The default design configuration instantiates a GRETH 10/100 Mbit
Ethernet MAC.


