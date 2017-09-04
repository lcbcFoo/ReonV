Overview
--------

This LEON3 design is tailored for the Altera CycloneV E Development
kit and builds with Quartus 13.

Design contains:
  * LEON3 running at 95 MHz
  * 512 MiB DDR3 running at 300 MHz using Quartus soft memory controller IP
  * 256 MiB LPDDR2 running at 300 MHz using Quartus soft IP
  * JTAG debug link connected to on-board USB blaster II
  * One debug UART (AHBUART) and one standard UART (APBUART). Either
    connected to the serial port or the USB-to-UART converter on the
    board.
  * Memory controller to access the on-board flash via GRMON (read-only)
  * Two GRETH 10/100 Ethernet cores with EDCL


Important notes
---------------

  * The Ethernet interface needs to be changed to MII/GMII mode to be used
    with the GRETH. This can be done permanently by changing the R113/R114
    resistor on the board (see schematics). It can also be done temporarily
    (until next reset) through grmon by the following commands:

     for first Ethernet IF (on connector J8):
      wmdio 0 27 0x848f greth0; wmdio 0 0 0xb100 greth0

     for secondary Ethernet IF (on connector J9):
      wmdio 1 27 0x848f greth1; wmdio 1 0 0xb100 greth1

    Note: The EDCL blocks the MDIO interface until link has been established.
    Therefore, you may get "Timeout!" errors when doing the above commands
    if EDCL is enabled and the board has not yet been connected to anything.

  * The flash/SSRAM fm_d[2] pin has been located too close to the 125 MHz clock
    input in violation with the Cyclone V differential pin placement rules.
    Quartus 13.0SP1 refuses to build the design with this pin as output, and
    therefore the data bus has been configured as input only. That means you
    can still read the flash but it is not detected by the flash grmon command
    and it can not be written.


  * The flash memory is also used by the board's firmware and to store
    the FPGA designs. Only the PROM ranges 0x00000000-0x0003ffff and
    0x023C0000-03FDFFFF can be used for LEON3 boot code, the rest
    should be left untouched. If unsure, do not change the flash
    contents at all. See Appendix A of the board's User Guide for details.


Design details
--------------

LED assignments:
  LED3 - CPU in error mode
  LED2 - DSU active
  LED1 - unused
  LED0 - PLL lock

Push button assignments:
  S4 "CPU RESET" - Reset LEON system
  S8 "USER PB3"  - DSU Break
  S7 "USER PB2"  - unused
  S6 "USER PB1"  - unused
  S5 "USER PB0"  - unused

DIP switches (SW3):
  3 - unused
  2 - unused
  1 - unused
  0 - Select UART mapping:
    ON  (left, 0) - USB uart (J13) is debug UART, serial port (J12) is normal UART
    OFF (right,1) - serial port (J12) is debug UART, USB-uart (J13) is debug UART

Memory map:
  0x00000000-0x03FFFFFF  SSRCTRL    Flash memory (see note above)
  0x04000000-0x3FFFFFFF             Unmapped
  0x40000000-0x5FFFFFFF  MEMCTRL1   DDR3 memory
  0x60000000-0x6FFFFFFF  MEMCTRL2   LPDDR2 memory
  0x80000000-0x800FFFFF  APBCTRL    APB register area
         000-       0FF    SSRCTRL    SSRCTRL registers
         100-       1FF    APBUART    UART registers
         200-       2FF    IRQMP      IRQ controller regs
         300-       3FF    GPTIMER    Timer registers
         400-       4FF    I2CMST     I2C master registers
         500-       6FF               Unused
         700-       7FF    AHBUART    Debug UART registers
         800-       AFF               Unused
         B00-       BFF    GRETH1     Ethernet MAC registerrs
         C00-       CFF    GRETH2     Ethernet MAC registerrs
         C00-     FEFFF               Unused
       FF000-     FFFFF    APBCTRL    APB plug'n'play information ROM
  0x80100000-0x8FFFFFFF             Unmapped
  0x90000000-0x9FFFFFFF  DSU3       Debug support unit
  0xA0000000-0xFFFFEFFF             Unmapped
  0xFFFFF000-0xFFFFFFFF  AHBCTRL    Plug'n'play information ROM

Interrupts:
  2 - UART
  4 - I2CMST
  8 - Timer
  12 - GRETH #1
  13 - GRETH #2


Simulation
----------

The standard GRLIB flow with "make sim" can be used to simulate the
design. The megafunctions are replaced with simple simulation models
that only simulate the minimum necessary to make the simulation work.


Programming
-----------

To synthesize the design, first build the megafunctions using "make
qwiz", then use the "make quartus" command to synthesize.

The "make quartus-prog-fpga" command has been tested to work with the
embedded USB-Blaster II interface on J10 (just needing a USB cable to
the computer). Programming through the JTAG connector has not been
tested.

Debugging can be done over the same interface using grmon -altjtag.

No make target to permanently store the design to flash has been
implemented. This can be done using the "design update portal" method
described in Appendix A in the board's user manual. To summarize:

  1. Use the sof2flash utility to generate a flash file for the design
  2. Power off the board. Set the "FAC_LOAD" (SW4:3) switch to on
     (left), connect the board to your network and power up the board
  3. Connect with a web browser to the IP address shown on the display
     and upload the flash file through the web interface.
  4. Power off the board, set the "FAC_LOAD" switch to off.

See Appendix A "Programming the Flash Memory Device" in the kit's user
manual for more details on how to do this.


