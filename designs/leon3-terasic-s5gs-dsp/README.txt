
LEON3 Template design for TerASIC DSP Development Kit, Stratix V GX Edition
---------------------------------------------------------------------------

1. Overview
-----------
The design contains:
  * LEON3 running at 150 MHz
  * 1 GiB DDR3 running at 400 MHz using Quartus soft memory controller IP
  * JTAG debug link connected to on-board USB blaster II
  * GRETH 10/100 MBit Ethernet link with EDCL.
  * Standard UART (APBUART), not connected to any external connector.
  * Memory controller to access the on-board flash via GRMON

2. Important notes
------------------
* The flash memory is also used by the board's firmware and to store
  the FPGA designs. It is recommended to not erase the whole flash.
* The Level-2 cache can be enabled in the design. This requires a
  GRLIB release that includes the Level-2 cache.
* The altjtag has only been tested on Linux with LD_LIBRARY_PATH
  pointing to a Quartus 13.1 version. Debugging through the
  Ethernet interface has also been tested and should work on all
  platforms.

3. Design details
-----------------
* Processor error output is mapped to LED 0

* DSU enable is tied HIGH internally
* DSU break is mapped to push button 0
* DSU active is mapped to LED 1


LED assignments:
    LED7 - mapped to GRGPIO pin 3
    LED6 - mapped to GRGPIO pin 2
    LED5 - mapped to GRGPIO pin 1
    LED4 - mapped to GRGPIO pin 0
    LED3 - unused
    LED2 - Lock status (red=not locked, green=locked)
    LED1 - DSU active (red=DSU active, green=CPU running)
    LED0 - DBG error  (red=error, green=no error)

Push button assignments:
    CPU RST     - Reset LEON system
    PB1     - Mapped to GRGPIO pin 5
    PB0     - DSU Break , also mapped to GRGPIO pin 4

4. Building and running the design
----------------------------------

Building has been tested with Quartus version 16.0.

To synthesize the design, first build the megafunctions using "make
qwiz", then use the "make quartus" command to synthesize.

To program the design to the FPGA, use "make quartus-prog-fpga".
This has been tested to work with the embedded USB-Blaster II
interface on J10 (just needing a USB cable to the computer).
Programming through the separate JTAG connector has not been tested.

After programming the design, you can connect with "grmon -altjtag".
Or, connect an Ethernet cable and connect with
"grmon -eth 192.168.0.51".


5. Simulating
-------------

The standard GRLIB flow with "make sim" can be used to simulate the
design. The DDR3 controller is replaced with a simple simulation models
that only simulate the minimum necessary to make the simulation work.



6. How to program the flash prom with a FPGA programming file
-------------------------------------------------------------

There are two methods to program the board's flash permanently with an
FPGA design, one using the board firmware ("board update portal") and
one using grmon's flash functionality. Both have the equivalent result.
The board update portal is recommended but the GRMON method will work
even if the flash has been erased.

The procedures below show how to program the design into the "User
hardware 1" partition of the flash. To autostart this design on power-up
instead of the factory firmware (board update portal) you can then
change the switch SW5-3 labeled FACTORY on the bottom side of the board.


Method A: Using the board update portal:

  Step A1. Create a flash file.
  ----------------------------

  Launch a Nios II Command Shell, which is part of your Quartus
  installation. On Windows it's in the Start menu, under Nios II. On
  Linux you can run $QUARTUS_INST_DIR/nios2eds/nios2_command_shell.sh,
  that will launch a shell where it will be in your path.

  In the Nios II shell execute the following command:

    sof2flash --input=leon3mp_quartus.sof --output=leon3mp_quartus.flash --offset=0x020C0000 --pfl --optionbit=0x00030000 --programmingmode=PS

  At the end of this step you will have generated two files:
    - leon3mp_quartus.flash
    - leon3mp_quartus.map.flash

  Step A2. Connect to board update portal
  ---------------------------------------

  Make sure the board is set to load the board update portal on power-up
  (SW5-3 is in the off position).

  Connect to board to your local network with an Ethernet cable and power
  on the board. The board should load the firmware and then get an IP
  address automatically (through DHCP) and display that address on the
  LCD display. This should take about 30 seconds.

  Open a web browser on a computer connected to the same local network and
  type in the IP address shown on the LCD display. A web page for the board
  update portal should come up.

  Step A3. Upload flash image
  ---------------------------

  In the web page, click on the Hardware file name "Browse..." button
  and select the leon3mp_quartus.flash file that was generated during
  step A1. Then click "Upload".

  Progress should be displayed on the LCD screen and on the web page.
  Uploading takes a few minutes.

  Step A4. Programming done
  -------------------------

  Complete!


Method B: Using GRMON

  Step B1. Create a flash file.
  ----------------------------

  This uses the sof2flash utility the same way as the other method, see step A1.

  Step B2. Pad flash file.
  ------------------------

  The flash file needs to be padded to a 1KiB boundary using below command:
    objcopy -I srec -O srec --pad-to=0x03a52000 leon3mp_quartus.flash leon3mp_quartus_pad.flash

  Step B3. Connect with GRMON
  ---------------------------

  Load this FPGA design into the FPGA (using make quartus-prog-fpga) and connect
  to it with GRMON.

  Step B4. Update flash
  ---------------------

  In GRMON, do:
    flash unlock 0x020C0000 0x03ffffff
    flash erase  0x020C0000 0x03ffffff
    flash load leon3mp_quartus_pad.flash
    verify leon3mp_quartus.flash

  Step B4. Programming done
  -------------------------

  Complete! Exit GRMON and power cycle the board.



7. Programming the flash with LEON software
-------------------------------------------

The 14 MiB address range 0x071C0000-0x07BFFFFF in the flash is reserved for
user software in the board's memory map and the LEON3 processor in this
design has been configured to boot from the beginning of this range.

Below is an example where we have a simple bare-C program that blinks a few LEDs:

int main(int argc, char **argv)
{
        volatile unsigned long *gpioregs = (volatile unsigned long *)0x80000900;
        int i=0,led1,led2,c;
        while (1) {
              /* Update GPIO */
              led1 = i; led2 = (i+1)&3;
              gpioregs[2] = (1<<led1) | (1<<led2);
              gpioregs[1] = (1<<led1);
              /* Delay loop */
              for (c=0; c<3000000; c++) { asm volatile("nop"); }
              /* Increment index */
              i = (i+1)&3;
        }
}


  Step 1. Compile
  ---------------

  sparc-elf-gcc -msoft-float blinkled.c -o blinkled.exe -Wall -O2

  Step 2. Make PROM image
  -----------------------

  mkprom2 -msoft-float -stack 0x7FFFFFF0 -rstaddr 0x071C0000 -romwidth 32 -romws 15 -freq 150 blinkled.exe -o blinkled.prom

  Step 3. Program flash
  ---------------------

  With the design running in the FPGA and with GRMON connected to it:
    flash unlock 0x071C0000 0x07BFFFFF
    flash erase  0x071C0000 0x07BFFFFF
    flash load blinkled.prom
    verify blinkled.prom

  Step 4. Done
  ------------

  You should now be able to exit GRMON and then reset with the CPU_RST button and
  the blinkled program will run automatically.


