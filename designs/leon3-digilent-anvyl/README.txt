LEON3 design for Digilent Anvyl board
-------------------------------------
This is a LEON3 design for the Digilent Anvyl board with Xilinx Spartan-6 LX45 FPGA.

This design was contributed by Dag Ströman, Stockholm, Sweden.

The design includes common GRLIB components. Of these, the following seem to be
working OK:

  LEON3 SPARC V8 Processor             
  JTAG Debug Link                      
  GR Ethernet MAC                      
  SVGA frame buffer                    
  AHB/APB Bridge                       
  LEON3 Debug Support Unit             
  Single-port DDR2 controller          
  Generic UART                         
  General Purpose I/O port             
  Multi-processor Interrupt Ctrl.      
  Modular Timer Unit                   
  AHB Status Register                  

The following are also included but have not been verified to work:
  SPI Memory Controller                
  Single-port AHB SRAM module          
  PS2 interface                       

Linux boots fine. A LinuxBuild config file is included. The SVGA framebuffer and
Ethernet driver work OK. PS2 driver not work. 


GRLIB Development environment
-----------------------------
- Win10
- Cygwin64
- grlib-gpl-1.5.0-b4164
- grmon-eval-2.0.81 64
- sparc-elf-3.4.4-mingw
- Xilinx ISE 14.7 Webpack


Simulation and synthesis
------------------------
To synthesize the design, run
  $ make xconfig
  $ make ise 

The FPGA can be programmed directly using "make ise-prog-fpga".

Simulation not yet supported.


Design specifics
----------------
* System reset is mapped to the BTN3 button.

* DSU-enable is mapped to switch SW7 (slide up to enable DSU)
  DSU-break is mapped to switch SW6  (slide up to force DSU break)
  DSU-active is indicated on LED LD6 (LED on when CPU in debug mode)
  Error is indicated on LED LD7      (LED on when CPU in error mode)

* The AHB and processor are clocked at 50 MHz.

* The GRETH core is enabled and runs without problems at 100 Mbit. ETH clock is
  provided from the PHY. Ethernet debug link is enabled and has IP 192.168.0.51.
  GRMON connection via -eth qualifier works fine.

* DDR2 memory works and runs at 150 MHz, phase-locked to the AHB clock.
  The read delay in the DDR2SPA controller MUST be tuned by software
  at boot time before the DDR2 memory can be used.

* SPI flash memory is included in design but not working (yet).
  Mapped at 0x00000000 if the AHBROM core is
  disabled (default configuration) or 0xe0000000 if the AHBROM
  core is enabled.
  This memory is used for the FPGA configuration bitstream and
  also as LEON3 ROM area.

* The console UART1 works and is connected to the on-board serial-to-USB adapter.

* GPIO works and is mapped as follows:
  - GPIO bits 0 to 5 to LEDS 0 to 5.
  - GPIO bits 6 to 11 to SWITCHES 0 to 5.
  - GPIO bits 12 to 17 to GYRLEDS 0 to 5.
  - GPIO bits 18 to 20 to BUTTONS 0 to 2.
  - GPIO bits 21 to 29 to DIPSWITCH 0 to 7.

* HDMI output is supported via SVGACTRL (APBVGA not yet tested).
  SVGACTRL video modes are limited to 640x480 or 800x600 with 8-bit
  or 16-bit color (due to TMDS bitrate and AHB bus loading).

* PS/2 keyboard/mouse via on board USB-HID controlers does not work (yet).

* The LEON processor will be kept in reset until the SPIMCTRL is
  initialized (spmo.initialized is asserted).

* Audio is not supported (yet).


DDR2 memory
-----------
The Anvyl board contains 128 MByte DDR2 memory.
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
Included, but not verified (yet).


AHBROM contents
---------------
Included, but not verified (yet).


GRMON output
------------
$ grmon -eth -nb

  GRMON2 LEON debug monitor v2.0.81 32-bit eval version

  Copyright (C) 2016 Cobham Gaisler - All rights reserved.
  For latest updates, go to http://www.gaisler.com/
  Comments or bug-reports to support@gaisler.com

  This eval version will expire on 08/06/2017

 Ethernet startup...
  GRLIB build version: 4164
  Detected frequency:  49 MHz

  Component                            Vendor
  LEON3 SPARC V8 Processor             Cobham Gaisler
  JTAG Debug Link                      Cobham Gaisler
  GR Ethernet MAC                      Cobham Gaisler
  SVGA frame buffer                    Cobham Gaisler
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
  General Purpose I/O port             Cobham Gaisler
  AHB Status Register                  Cobham Gaisler

  Use command 'info sys' to print a detailed report of attached cores

grmon2> info sys
info sys
  cpu0      Cobham Gaisler  LEON3 SPARC V8 Processor
            AHB Master 0
  ahbjtag0  Cobham Gaisler  JTAG Debug Link
            AHB Master 1
  greth0    Cobham Gaisler  GR Ethernet MAC
            AHB Master 2
            APB: 80000E00 - 80000F00
            IRQ: 12
            edcl ip 192.168.0.51, buffer 2 kbyte
  svga0     Cobham Gaisler  SVGA frame buffer
            AHB Master 3
            APB: 80000600 - 80000700
            clk0: 25.00 MHz  clk1: 40.00 MHz  clk2: 25.00 MHz  clk3: 40.00 MHz
  apbmst0   Cobham Gaisler  AHB/APB Bridge
            AHB: 80000000 - 80100000
  dsu0      Cobham Gaisler  LEON3 Debug Support Unit
            AHB: 90000000 - A0000000
            AHB trace: 256 lines, 32-bit bus
            CPU0:  win 8, hwbp 2, itrace 256, V8 mul/div, srmmu, lddel 1
                   stack pointer 0xa0003ff0
                   icache 2 * 8 kB, 32 B/line
                   dcache 2 * 4 kB, 16 B/line
  spim0     Cobham Gaisler  SPI Memory Controller
            AHB: FFF00200 - FFF00300
            AHB: 00000000 - 01000000
            IRQ: 11
            SPI memory device read command: 0x03
  ddr2spa0  Cobham Gaisler  Single-port DDR2 controller
            AHB: 40000000 - 48000000
            AHB: FFF00100 - FFF00200
            No SDRAM found
  ahbram0   Cobham Gaisler  Single-port AHB SRAM module
            AHB: A0000000 - A0100000
            32-bit static ram: 16 kB @ 0xa0000000
  uart0     Cobham Gaisler  Generic UART
            APB: 80000100 - 80000200
            IRQ: 2
            Baudrate 38281, FIFO debug mode
  irqmp0    Cobham Gaisler  Multi-processor Interrupt Ctrl.
            APB: 80000200 - 80000300
  gptimer0  Cobham Gaisler  Modular Timer Unit
            APB: 80000300 - 80000400
            IRQ: 8
            8-bit scalar, 2 * 32-bit timers, divisor 49
  ps2ifc0   Cobham Gaisler  PS2 interface
            APB: 80000400 - 80000500
            IRQ: 4
  ps2ifc1   Cobham Gaisler  PS2 interface
            APB: 80000500 - 80000600
            IRQ: 5
  gpio0     Cobham Gaisler  General Purpose I/O port
            APB: 80000A00 - 80000B00
  ahbstat0  Cobham Gaisler  AHB Status Register
            APB: 80000F00 - 80001000
            IRQ: 7

grmon2> load bin/ddrtune.exe
load bin/ddrtune.exe
  A0000000 .text                      896B              [===============>] 100%
  Total size: 896B (0.00bit/s)
  Entry point 0xa0000000
  Image C:/cygwin64/home/Dag/grlib-gpl-1.5.0-b4164/designs/leon3-digilent-anvyl/bin/ddrtune.exe loaded

grmon2> run
run

DDRTUNE:
...
0000000000000000
0000000000000000
0000000000000011
1111111111111111
1111111111111111
1111111111111111
1111111000000000
0000000000000000
0000000000000000
0000000011111111
0
delay = 0x4a, OK.

  Program exited normally.

grmon2>


Linux Build Environment
-----------------------
- Linux Mint 18 running on VMWare Workstation 12 Player
- LinuxBuild-1.0.8
- leon-linux-3.10-3.10.58-1.0.4

A Linux build config file is provided in lb_config_leon-linux-3.10_up_soft-anvyl.tar.bz2. Copy this to ./LinuxBuild-x.y.z/gaisler/configs/ and load it in LinuxBuild to select packages to be included in the image.

Linux Boot
----------
(contain error messages from apbps2 drivers. Will try to fix that in future releases).

PROMLIB: Sun Boot Prom Version 0 Revision 0
Linux version 3.10.58-00019-g29deef2 (dag@dag-vm) (gcc version 4.4.2 (sparc-linux-ct-leon_multilib_basic-0.0.7) ) #2 Wed Jan 11 15:27:45 CET 2017
bootconsole [earlyprom0] enabled
ARCH: LEON
TYPE: Leon3 System-on-a-Chip
Ethernet address: 00:00:7c:cc:01:45
CACHE: 2-way associative cache, set size 4k
OF stdout device is: /a::a
PROM: Built device tree with 16153 bytes of memory.
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 29598
Kernel command line: console=ttyS0,38400 video=grvga:800x600-8@60 init=/sbin/init
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Sorting __ex_table...
Memory: 116028k/131048k available (4128k kernel code, 15020k reserved, 1472k data, 5880k init, 0k highmem)
NR_IRQS:64
Console: colour dummy device 80x25
console [ttyS0] enabled, bootconsole disabled
console [ttyS0] enabled, bootconsole disabled
Calibrating delay loop... 48.53 BogoMIPS (lpj=242688)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switching to clocksource timer_cs
FS-Cache: Loaded
CacheFiles: Loaded
NET: Registered protocol family 2
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
FS-Cache: Netfs 'nfs' registered for caching
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
ROMFS MTD (C) 2007 Red Hat, Inc.
JFS: nTxBlock = 906, nTxLock = 7251
msgmni has been set to 226
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
grgpio ffd0f4cc: regs=0xfd001a00, base=227, ngpio=29, irqs=on
grlib-svgactrl ffd0fdfc: Aeroflex Gaisler framebuffer device (fb0), 800x600-8, using 937K of video memory @ f6000000
Console: switching to colour frame buffer device 100x75
Serial: GRLIB APBUART driver
ffd0f8bc: ttyS0 at MMIO 0x80000100 (irq = 4) is a GRLIB/APBUART
grlib-apbuart at 0x80000100, irq 4
brd: module loaded
loop: module loaded
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
uhci_hcd: USB Universal Host Controller Interface driver
usbcore: registered new interface driver usblp
usbcore: registered new interface driver usb-storage
usbcore: registered new interface driver usbserial
usbcore: registered new interface driver usbserial_generic
usbserial: USB Serial support registered for generic
usbcore: registered new interface driver belkin_sa
usbserial: USB Serial support registered for Belkin / Peracom / GoHubs USB Serial Adapter
usbcore: registered new interface driver ftdi_sio
usbserial: USB Serial support registered for FTDI USB Serial Device
grlib-apbps2 ffd0f65c: irq = 6, base = 0xfd005400
grlib-apbps2 ffd0f594: irq = 7, base = 0xfd006500
mousedev: PS/2 mouse device common for all mice
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
leon: power management initialized
/home/dag/linuxbuild-1.0.8/linux/linux-src/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 5880K (f057f000 - f0b3d000)
Starting logging: atkbd serio0: keyboard reset failed on apbps2_0
OK
Initializing random number generator... done.
Starting network...

Welcome to Buildroot
buildroot login: atkbd serio1: keyboard reset failed on apbps2_1
atkbd serio0: keyboard reset failed on apbps2_0
atkbd serio1: keyboard reset failed on apbps2_1

Welcome to Buildroot
buildroot login:

- eof -




