
This leon3 design is tailored to the Xilinx Virtex5 ML501 board
---------------------------------------------------------------------

Design specifics:

* System reset is mapped to the CPU RESET button. When programming
  the FPGA only, the CPU RESET button must be pressed once before
  connecting grmon to reset the DCM clock generators.

* The serial port is connected to the console UART (UART 1) when
  dip switch 8 on the GPIO DIP switch is off. Otherwise it is 
  connected to the DSU UART. The DSU BREAK input is mapped
  on the 'south' push-button.

* The JTAG DSU interface is enabled and works well with
  GRMON and Xilinx parallel cable III or IV .

* The GRETH core is enabled and runs without problems at 100 Mbit.
  Using 1 Gbit is also possible with the commercial grlib version.
  Ethernet debug link is enabled, default IP is 192.168.0.51.

* DDR2 is supported either by the DDR2SPA core or by the Xilinx MIG.

   DDR2SPA:  The default frequency is 140 MHz but it's
   possible to go higher. When changing frequency the delay on the
   data signals might need to be changed too. How to do this is
   described in the DDR2SPA section of grip.pdf (see description of
   SDCFG3 register). To select the DDR2SPA core, load the ddr2spa.cfg
   file in xconfig menu 'Load configuration file'.

   MIG: selecting the MIG controller is done in xconfig. To create
   the MIG files, do 'make mig' and then 'make scripts'. This will
   only work with ISE-13 or later. To simulate the template design,
   the Xilinx SecureIP library must be installed. Use this command
   to generate the MIG and install SecureIP:

   make xconfig   (select MIG, deselect DDR2SPA)
   make distclean install-secureip mig
   make sim
   
   The MIG memory parameters can be changed in of ahb2mig_ml50x.vhd,
   without having to regenerate the MIG itself. The default settings
   are compatible with the provided 256 Mbyte SODIMM.

   It is essential to use ISE 14.7. MIG generation is not supported
   for any other ISE version in this design.

* The SSRAM can be interfaced with the LEON2 Memory controller. 
  Start GRMON with -ramrws 1 when the LEON2 controller is used.

* The FLASH memory can be accessed and programmed through grmon

* The LEON3 processor can run up to 80 - 90 MHz on the board
  in the typical configuration.

* An I2C master is connected to the 'Main' I2C bus. An EEPROM (M24C08)
  can be accessed at I2C address 0x50.

* The SVGACTRL core is enabled and is connected to the DVI 
  transmitter. When one, or both, of the VGA cores is enabled an extra 
  I2C master is automatically instantiated. This I2C master is utilized
  to initialize the DVI transmitter. A special GRMON command exists to
  initialize the Chrontel CH7301C. See below for an example.
  Adjustment of the delay before latching input data may be needed. This
  can be done using the 'i2c 1 dvi delay [dec|inc]' command. 
  NOTE: If the the VGA cores are disabled the constraints on the VGA 
  clocks must be removed from the leon3mp.ucf file.

* Sample output from GRMON is:

$ grmon -eth -ip 192.168.0.51 -u -nb 

 GRMON LEON debug monitor v1.1.52 professional version (debug)

 Copyright (C) 2004-2011 Aeroflex Gaisler - all rights reserved.
 For latest updates, go to http://www.gaisler.com/
 Comments or bug-reports to support@gaisler.com

 This debug version will expire on 28/12/2012

 ethernet startup.
 Device ID: : 0x501
 GRLIB build version: 4114

 initialising ....................
 detected frequency:  80 MHz
 SRAM waitstates: 2

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug UART                       Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 SVGA Controller                      Gaisler Research
 GR Ethernet MAC                      Gaisler Research
 DDR2 Controller                      Gaisler Research
 AHB/APB Bridge                       Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 LEON2 Memory Controller              European Space Agency
 System ACE I/F Controller            Gaisler Research
 AMBA Wrapper for System Monitor      Gaisler Research
 Generic APB UART                     Gaisler Research
 Multi-processor Interrupt Ctrl       Gaisler Research
 Modular Timer Unit                   Gaisler Research
 PS/2 interface                       Gaisler Research
 PS/2 interface                       Gaisler Research
 General purpose I/O port             Gaisler Research
 AMBA Wrapper for OC I2C-master       Gaisler Research
 AMBA Wrapper for OC I2C-master       Gaisler Research
 AHB status register                  Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> inf sys
00.01:003   Gaisler Research  LEON3 SPARC V8 Processor (ver 0x0)
             ahb master 0
01.01:007   Gaisler Research  AHB Debug UART (ver 0x0)
             ahb master 1
             apb: 80000700 - 80000800
             baud rate 115200, ahb frequency 80.00
02.01:01c   Gaisler Research  AHB Debug JTAG TAP (ver 0x1)
             ahb master 2
03.01:063   Gaisler Research  SVGA Controller (ver 0x0)
             ahb master 3
             apb: 80000600 - 80000700
             clk0: 25.00 MHz  clk1: 25.00 MHz  clk2: 40.00 MHz  clk3: 65.00 MHz  
04.01:01d   Gaisler Research  GR Ethernet MAC (ver 0x0)
             ahb master 4, irq 12
             apb: 80000b00 - 80000c00
             Device index: dev0
             1000 Mbit capable
             edcl ip 192.168.0.51, buffer 8 kbyte
00.01:02e   Gaisler Research  DDR2 Controller (ver 0x1)
             ahb: 40000000 - 60000000
             ahb: fff00100 - fff00200
             64-bit DDR2 : 1 * 256 Mbyte @ 0x40000000, 4 internal banks
                          140 MHz, col 10, ref 7.8 us, trfc 135 ns
01.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)
             ahb: 80000000 - 80100000
02.01:004   Gaisler Research  LEON3 Debug Support Unit (ver 0x1)
             ahb: 90000000 - a0000000
             AHB trace 128 lines, 32-bit bus, stack pointer 0x4ffffff0
             CPU#0 win 8, hwbp 2, itrace 128, V8 mul/div, srmmu, lddel 1, GRFPU-lite
                   icache 2 * 8 kbyte, 32 byte/line rnd
                   dcache 4 * 4 kbyte, 16 byte/line rnd
03.04:00f   European Space Agency  LEON2 Memory Controller (ver 0x1)
             ahb: 00000000 - 20000000
             ahb: 20000000 - 40000000
             ahb: c0000000 - c2000000
             apb: 80000000 - 80000100
             16-bit prom @ 0x00000000
             32-bit static ram: 1 * 1024 kbyte @ 0xc0000000
04.01:067   Gaisler Research  System ACE I/F Controller (ver 0x0)
             irq 13
             ahb: fff00200 - fff00300
05.01:066   Gaisler Research  AMBA Wrapper for System Monitor (ver 0x0)
             irq 10
             ahb: fff00300 - fff00400
             ahb: fff00400 - fff00600
             SYSMON registers are on word boundaries
01.01:00c   Gaisler Research  Generic APB UART (ver 0x1)
             irq 2
             apb: 80000100 - 80000200
             baud rate 38461, DSU mode (FIFO debug)
02.01:00d   Gaisler Research  Multi-processor Interrupt Ctrl (ver 0x3)
             apb: 80000200 - 80000300
03.01:011   Gaisler Research  Modular Timer Unit (ver 0x0)
             irq 8
             apb: 80000300 - 80000400
             8-bit scaler, 2 * 32-bit timers, divisor 80
04.01:060   Gaisler Research  PS/2 interface (ver 0x2)
             irq 4
             apb: 80000400 - 80000500
05.01:060   Gaisler Research  PS/2 interface (ver 0x2)
             irq 5
             apb: 80000500 - 80000600
08.01:01a   Gaisler Research  General purpose I/O port (ver 0x1)
             apb: 80000800 - 80000900
09.01:028   Gaisler Research  AMBA Wrapper for OC I2C-master (ver 0x3)
             irq 14
             apb: 80000900 - 80000a00
             Controller index for use in GRMON: 1
0c.01:028   Gaisler Research  AMBA Wrapper for OC I2C-master (ver 0x3)
             irq 11
             apb: 80000c00 - 80000d00
             Controller index for use in GRMON: 2
0f.01:052   Gaisler Research  AHB status register (ver 0x0)
             irq 7
             apb: 80000f00 - 80001000
grlib> fla

 Intel-style 16-bit flash on D[31:16]

 Manuf.    Intel               
 Device    Strataflash P30   

 Device ID 006f43f18bdcffff    
 User   ID ffffffffffffffff    


 1 x 32 Mbyte = 32 Mbyte total @ 0x00000000


 CFI info
 flash family  : 1
 flash size    : 256 Mbit
 erase regions : 2
 erase blocks  : 259
 write buffer  : 64 bytes
 lock-down     : yes
 region  0     : 255 blocks of 128 Kbytes
 region  1     : 4 blocks of 32 Kbytes

grlib>  i2c 2 scan

Scanning 7-bit address space on I2C bus:
 Detected I2C device at address 0x2c
 Detected I2C device at address 0x50
 Detected I2C device at address 0x51
 Detected I2C device at address 0x52
 Detected I2C device at address 0x53
Scan of I2C bus completed. 5 devices found

grlib>  i2c 2 read 0x50 0x10 16

 10:    ff      ff      ff      ff
 14:    ff      ff      30      30
 18:    31      00      ff      58
 1c:    43      35      56      4c

grlib>  i2c 1 dvi init_ml50x_dvi

 Transmitter was not set to Chrontel CH7301C (AS=0), changing..

 DVI transmitter set to Chrontel CH7301C (AS=0)

 Initializing CH7301 for LEON/GRLIB design..
 Initialization done..

grlib>  i2c 1 dvi showreg

 Registers for Chrontel CH7301C (AS=0) DVI transmitter:

        0x1c:   04
        0x1d:   45
        0x1e:   d0
        0x1f:   8a
        0x20:   00
        0x21:   00
        0x23:   00
        0x31:   80
        0x33:   08
        0x34:   16
        0x35:   30
        0x36:   60
        0x37:   00
        0x48:   18
        0x49:   c0
        0x4a:   95
        0x4b:   17
        0x56:   00


