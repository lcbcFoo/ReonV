
This LEON design is tailored to the Xilinx Virtex5 ML510 board
---------------------------------------------------------------------

NOTE1: With revision 1 of the DDR2SPA controller, the controller can 
       support both registered and unbuffered memory modules. The devices 
       delivered with the ML510 kit are registered, and when connecting with
       GRMON the flag -regmem should be specified.

NOTE2: The ML510 has a bug that prevents the use of 64 bit unbuffered DDR2. 
       See description of the DDR2 interface below.

NOTE3: To intialize the correct DDR2 delay values, issue the GRMON command:
       ddr2delay scan (see GRMON example below)

NOTE4: Synplify versions H/I/J (tested with J-2015.03) do not correctly
       synthesize this design. The tool adds a LUT1 between the CLK2X
       output and a BUFG in the Virtex5 CLKGEN. XST can successfully
       synthesize the design. Synplify F versions can also be used.

To simulate the design with ModelSim (or Aldec Riviera):

  make install-secureip
  make sim
  make sim-launch

Design specifics:

* System reset is mapped to the CPU RESET button

* The DSU UART is connected to UART 0. The DSU BREAK input is 
  mapped to position 1 on the GPIO DIP switch. When the switch is 'on'
  the DSU break signal is active. 

* The DSU error signal is connected to opb_bus_error. When the processor
  is in error mode the LED will be red. The DSU active signal is connected
  to plb_bus_error. When the DSU is active the LED will be red.

* The serial port is connected to UART 1.

* The JTAG DSU interface is enabled and works well with
  GRMON and Xilinx parallel and USB cables

* The GRGPIO port is mapped in the following way:
  gpio[0]   : SW5[1] (Input only)
  gpio[3:1] : SW5[4:2] / Green LEDs
  gpio[4]   : DVI GPIO
  gpio[5]   : sbr_intr_r        (input only)
  gpio[6]   : sbr_nmi_r         (input only)
  gpio[7]   : sbr_pwg_rsm_rstj 
  gpio[8]   : sbr_ide_rst_b
  gpio[9]   : iic_therm_b       (input only)
  gpio[10]  : iic_irq_b         (input only)
  gpio[11]  : iic_alert_b       (input only)
  
* The sbr_intr_r signal should be used as an interrupt source if
  the PCI south bridge is used. The GRPCI core is assigned interrupt
  line 5 and the PCI drivers will trigger on this IRQ. 

* The DSU registers are located at 0xd0000000. Normally these registers
  are mapped at 0x90000000. Some software may have hardcoded or default
  values for 0x90000000.

* The APB bridge start address is 0xc0000000. This address is
  normally 0x80000000 in Leon/GRLIB designs. Some software may
  default to, or use hard coded values for, 0x80000000.

* The GRETH core is enabled and runs without problems at 100 Mbit.
  The Ethernet debug link is enabled, default IP is 192.168.0.52.

* The second GRETH core is enabled and uses the high-speed serial SGMII bridge 
  to connect to the PHY. Due to mapping constraints of the FPGA, other cores 
  using a high number of global clock buffers can't be enabled contextually to 
  the second GRETH core (e.g. the SVGA core and relative constraints). The 
  Ethernet debug link is enabled on this core too, default IP is 192.168.0.52.

* DDR2 is supported and runs OK at 200 MHz. The default setting is
  to run the DDR controller on 2x the system clock. This leads to
  lower latencies since synchronization registers are not needed. 
  If the CFG_DDR2SP_NOSYNC generic is set to 0, the DDR2 runs 
  asynchronously and the DDR frequency can be set (in steps of 10 MHz)
  via xconfig. When changing frequency, the delay on the data signals
  might need to be changed too. How to do this is described in the DDR2SPA
  section of grip.pdf (see description of SDCFG3 register), see also the
  DDR2SPA section in the GRMON manual.

  The ML510 board has the DDR clk 1 inverted (DIMM*_DDR2_CK2_N and
  DIMM*_DDR2_CK2_P have been flipped). The DDR2 DIMMs shipped with the 
  ML510 use registered DDR2 and only makes use of DIMM*_DDR2_CK0_*, therefore
  they are not affected.

  For unbuffered DIMM:s, the upper half of the memory bus will not work due
  to this bug, and the DDR controller needs to be configured for 32 bits 
  operation in this case. The DDR2 data width of the core can be configured
  via xconfig.

  When connecting with GRMON it will set the stack pointer to the top of RAM 
  of the first memory controller. If you have 512 MB memory (or more) in 
  the first slot, you can make the OS access both DIMM:s as one big memory.
  To do this, the stack pointer needs to be manually set to the end of the 
  second memory controller's area. For this template design with 512 MB memory
  in both DIMM:s, the correct switch to GRMON is -stack 0x7ffffff0. 

* The FLASH memory can be programmed using GRMON

* The LEON processor can run up to 80 - 90 MHz on the board
  in the typical configuration.

* The design has two I2C masters. One is connected to the main IIC bus
  and one is connected to the video IIC bus. The I2C master connected
  to the main bus can be deactivated via xconfig. The I2C master connected
  to the video IIC bus is instantiated when a VGA core is included.

* The SVGACTRL core can be enabled and is connected to the DVI 
  transmitter. When one, or both, of the VGA cores is enabled an extra 
  I2C master is automatically instantiated. This I2C master is utilized
  to initialize the DVI transmitter. A special GRMON command exists to
  initialize the Chrontel CH7301C. See below for an example.
  Adjustment of the delay before latching input data may be needed. This
  can be done using the 'i2c 1 dvi delay [dec|inc]' command. 
  NOTE: If the the VGA cores are enabled the constraints on the VGA 
  clocks must be uncommented from the leonmp.ucf file.

* SPICTRL is attached to the SPI Flash memory device. To communicate with 
  the memory device, the core needs to be initialized to generate a SPI 
  clock of ~1 MHz. When using GRMON this can be attained with the command
  'spi set div16 pm 1'. When using GRMON the "Microchip 25AA640/25LC640" must
  be selected via the command 'spi flash select'.

* The design should be loaded from CompactFlash via System ACE. The FPGA can
  also be directly programmed with 'make ise-prog-fpga'. Make sure to set the
  value of SW3 appropriately.

* Sample output from GRMON is:

bash-3.2$ grmon2cli -eth -ip 192.168.0.52 -regmem -u

  GRMON2 LEON debug monitor v2.0.36-50-gf52dd46 internal version

  Copyright (C) 2013 Aeroflex Gaisler - All rights reserved.
  For latest updates, go to http://www.gaisler.com/
  Comments or bug-reports to support@gaisler.com

 Ethernet startup...
  Device ID:           0x510
  GRLIB build version: 4131
  Detected frequency:  80 MHz

  Component                            Vendor
  LEON3 SPARC V8 Processor             Aeroflex Gaisler
  LEON3 SPARC V8 Processor             Aeroflex Gaisler
  AHB Debug UART                       Aeroflex Gaisler
  JTAG Debug Link                      Aeroflex Gaisler
  SVGA frame buffer                    Aeroflex Gaisler
  GR Ethernet MAC                      Aeroflex Gaisler
  Fast 32-bit PCI Bridge               Aeroflex Gaisler
  PCI/AHB DMA controller               Aeroflex Gaisler
  Single-port DDR2 controller          Aeroflex Gaisler
  Single-port DDR2 controller          Aeroflex Gaisler
  LEON3 Debug Support Unit             Aeroflex Gaisler
  LEON2 Memory Controller              European Space Agency
  AHB/APB Bridge                       Aeroflex Gaisler
  System ACE I/F Controller            Aeroflex Gaisler
  Generic UART                         Aeroflex Gaisler
  Multi-processor Interrupt Ctrl.      Aeroflex Gaisler
  Modular Timer Unit                   Aeroflex Gaisler
  AMBA Wrapper for OC I2C-master       Aeroflex Gaisler
  General Purpose I/O port             Aeroflex Gaisler
  AMBA Wrapper for OC I2C-master       Aeroflex Gaisler
  SPI Controller                       Aeroflex Gaisler
  32-bit PCI Trace Buffer              Aeroflex Gaisler
  PCI Arbiter                          European Space Agency
  AHB Status Register                  Aeroflex Gaisler

  Use command 'info sys' to print a detailed report of attached cores

grmon2> ddr2delay scan
  DDR2 Delay calibration routine
  - Resetting delays
  - Trying read-delay 0 cycles
  Bits  63-56: ---------------------------------------------------------------- -1
  Bits  55-48: ---------------------------------------------------------------- -1
  Bits  47-40: ---------------------------------------------------------------- -1
  Bits  39-32: ---------------------------------------------------------------- -1
  Bits  31-24: ---------------------------------------------------------------- -1
  Bits  23-16: ---------------------------------------------------------------- -1
  Bits  15- 8: ---------------------------------------------------------------- -1
  Bits   7- 0: ---------------------------------------------------------------- -1
  - Trying read-delay 1 cycles
  Bits  63-56: OOOOOOOOOOOOOOO--O-O------------------------------------OOOOOOOO 3
  Bits  55-48: OOOOOOOOOOOOOOOOOO--------------------------------------OOOOOOOO 5
  Bits  47-40: OOOOOOOOOOOOOOOOOOO-O-----------------------------------OOOOOOOO 5
  Bits  39-32: OOOOOOOOOOOOOOOOO-OO------------------------------------OOOOOOOO 4
  Bits  31-24: OOOOOOOOOOOOOOOOOO-O------------------------------------OOOOOOOO 5
  Bits  23-16: OOOOOOOOOOOOOOOOOOOO------------------------------------OOOOOOOO 6
  Bits  15- 8: OOOOOOOOOOOOOOOOOOOO--O---------------------------------OOOOOOOO 6
  Bits   7- 0: OOOOOOOOOOOOOOOOOOO-------------------------------------OOOOOOOO 5
  - Verifying
  - Calibration done

grmon2> info sys
  cpu0      Aeroflex Gaisler  LEON3 SPARC V8 Processor
            AHB Master 0
  cpu1      Aeroflex Gaisler  LEON3 SPARC V8 Processor
            AHB Master 1
  ahbuart0  Aeroflex Gaisler  AHB Debug UART
            AHB Master 2
            APB: C0000700 - C0000800
            Baudrate 115200, AHB frequency 80.00 MHz
  ahbjtag0  Aeroflex Gaisler  JTAG Debug Link
            AHB Master 3
  svga0     Aeroflex Gaisler  SVGA frame buffer
            AHB Master 4
            APB: C0000E00 - C0000F00
            clk0: 25.00 MHz  clk1: 25.00 MHz  clk2: 40.00 MHz  clk3: 65.00 MHz
  greth0    Aeroflex Gaisler  GR Ethernet MAC
            AHB Master 5
            APB: C0000B00 - C0000C00
            IRQ: 4
            edcl ip 192.168.0.52, buffer 2 kbyte
  pci0      Aeroflex Gaisler  Fast 32-bit PCI Bridge
            AHB Master 6
            AHB: 80000000 - C0000000
            AHB: FFF40000 - FFF60000
            APB: C0000400 - C0000500
            IRQ: 5
  adev7     Aeroflex Gaisler  PCI/AHB DMA controller
            AHB Master 7
            APB: C0000500 - C0000600
  ddr2spa0  Aeroflex Gaisler  Single-port DDR2 controller
            AHB: 40000000 - 60000000
            AHB: FFF00100 - FFF00200
            64-bit DDR2 : 1 * 1 GB @ 0x40000000, 8 internal banks
            160 MHz, col 10, ref 7.8 us, trfc 131 ns
  ddr2spa1  Aeroflex Gaisler  Single-port DDR2 controller
            AHB: 60000000 - 80000000
            AHB: FFF00200 - FFF00300
            64-bit DDR2 : 1 * 512 MB @ 0x60000000, 4 internal banks
            160 MHz, col 10, ref 7.8 us, trfc 131 ns
  dsu0      Aeroflex Gaisler  LEON3 Debug Support Unit
            AHB: D0000000 - E0000000
            AHB trace: 128 lines, 32-bit bus
            CPU0:  win 8, hwbp 2, itrace 128, V8 mul/div, srmmu, lddel 1, GRFPU
                   stack pointer 0x7ffffff0
                   icache 4 * 8 kB, 32 B/line lru
                   dcache 4 * 4 kB, 16 B/line lru
            CPU1:  win 8, hwbp 2, itrace 128, V8 mul/div, srmmu, lddel 1, GRFPU
                   stack pointer 0x7ffffff0
                   icache 4 * 8 kB, 32 B/line lru
                   dcache 4 * 4 kB, 16 B/line lru
  mctrl0    European Space Agency  LEON2 Memory Controller
            AHB: 00000000 - 20000000
            AHB: 20000000 - 40000000
            APB: C0000000 - C0000100
            16-bit prom @ 0x00000000
  apbmst0   Aeroflex Gaisler  AHB/APB Bridge
            AHB: C0000000 - C0100000
  adev13    Aeroflex Gaisler  System ACE I/F Controller
            AHB: FFF00000 - FFF00100
            IRQ: 5
  uart0     Aeroflex Gaisler  Generic UART
            APB: C0000100 - C0000200
            IRQ: 2
            Baudrate 38461
  irqmp0    Aeroflex Gaisler  Multi-processor Interrupt Ctrl.
            APB: C0000200 - C0000300
  gptimer0  Aeroflex Gaisler  Modular Timer Unit
            APB: C0000300 - C0000400
            IRQ: 8
            8-bit scalar, 2 * 32-bit timers, divisor 80
  i2cmst0   Aeroflex Gaisler  AMBA Wrapper for OC I2C-master
            APB: C0000600 - C0000700
            IRQ: 6
            Index for use in GRMON: 0
  gpio0     Aeroflex Gaisler  General Purpose I/O port
            APB: C0000800 - C0000900
  i2cmst1   Aeroflex Gaisler  AMBA Wrapper for OC I2C-master
            APB: C0000900 - C0000A00
            IRQ: 3
            Index for use in GRMON: 1
  spi0      Aeroflex Gaisler  SPI Controller
            APB: C0000A00 - C0000B00
            IRQ: 12
            FIFO depth: 4, 1 slave select signals
            Maximum word length: 32 bits
            Supports 3-wire mode
            Controller index for use in GRMON: 0
  pcitrace0 Aeroflex Gaisler  32-bit PCI Trace Buffer
            APB: C0010000 - C0020000
            Trace buffer size: 1024 lines
  adev22    European Space Agency  PCI Arbiter
            APB: C0000D00 - C0000E00
  ahbstat0  Aeroflex Gaisler  AHB Status Register
            APB: C0000F00 - C0001000
            IRQ: 7

grmon2> fl
  ambiguous command name "fl": flash float flush

grmon2> fla

  Intel-style 16-bit flash on D[31:16]

  Manuf.        : Intel
  Device        : Strataflash P30
  Device ID     : 01c94716c26cffff
  User ID       : ffffffffffffffff

  1 x 32 Mbytes = 32 Mbytes total @ 0x00000000

  CFI information
  Flash family  : 1
  Flash size    : 256 Mbit
  Erase regions : 2
  Erase blocks  : 259
  Write buffer  : 64 bytes
  Lock-down     : Supported
  Region  0     : 255 blocks of 128 kbytes
  Region  1     : 4 blocks of 32 kbytes

grmon2> load /usr/local32/apps/bench/leon3/dhry.leon3
  40000000 .text                     54.7kB /  54.7kB   [===============>] 100%
  4000DAF0 .data                      2.7kB /   2.7kB   [===============>] 100%
  Total size: 57.44kB (29.41Mbit/s)
  Entry point 0x40000000
  Image /usr/local32/apps/bench/leon3/dhry.leon3 loaded

grmon2> verify /usr/local32/apps/bench/leon3/dhry.leon3
  40000000 .text                     54.7kB /  54.7kB   [===============>] 100%
  4000DAF0 .data                      2.7kB /   2.7kB   [===============>] 100%
  Total size: 57.44kB (27.68Mbit/s)
  Entry point 0x40000000
  Image of /usr/local32/apps/bench/leon3/dhry.leon3 verified without errors

grmon2> run
Execution starts, 1000000 runs through Dhrystone
Total execution time:                          5.1 s
Microseconds for one run through Dhrystone:    5.1
Dhrystones per Second:                      196738.5

Dhrystones MIPS      :                       112.0


  CPU 0:  Program exited normally.
  CPU 1:  Power down mode

grmon2> i2c 0 scan
  Scanning 7-bit address space on I2C bus:
  Detected I2C device at address 0x76

  Scan of I2C bus completed. 1 device found

grmon2> i2c 1 scan
  Scanning 7-bit address space on I2C bus:
  Detected I2C device at address 0x2e
  Detected I2C device at address 0x47
  Detected I2C device at address 0x50
  Detected I2C device at address 0x51
  Detected I2C device at address 0x53
  Detected I2C device at address 0x54

  Scan of I2C bus completed. 6 devices found

grmon2> i2c 0 dvi init_ml50x_dvi
Transmitter was not set to Chrontel CH7301C (AS=0), changing...
  Initialized CH7301 DVI output for LEON/GRLIB design.

grmon2> spi selftest
  Self test PASSED

grmon2> pci info

  GRPCI initiator/target (in system slot):

    Bus master:    yes
    Mem. space en: no
    Latency timer: 0x0
    Byte twisting: disabled

    MMAP:          0x0
    IOMAP:         0x0000

    BAR0:          0x00000000
    PAGE0:         0x40000001
    BAR1:          0x00000000
    PAGE1:         0x00000000


grmon2> 



* Example MKPROM2 command line, creating bootable image from the application
  "hello":

mkprom2 -v -dump -freq 80 -romws 15 -romwidth 16 -ddrram 512 -ddrbanks 8 \
-ddrfreq 160 -ddrcol 1024 -uart 0xc0000100 -baud 38400 -irqmp 0xc0000200 \
-gpt 0xc0000300 -memc 0xc0000000 -stack 0x5ffffff0 hello


Make sure that DIP switch 1 (DSU break) is OFF to allow the processor to
start execution after system reset.

