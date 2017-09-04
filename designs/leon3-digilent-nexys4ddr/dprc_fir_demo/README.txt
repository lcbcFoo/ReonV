This folder includes the .vhd design files of the custom FIR filter AHB/APB peripheral, a tcl script implementing the PR design flow in VIVADO 2014.4.1, and a C test program used for demonstrating partial reconfiguration on LEON3.

Issue make dprc-demo in the template design directory to execute the entire partial reconfiguration design flow, after instantiating DPRC controller in the design (use make xconfig).
Issue make dprc-demo-prog to program the fpga with the first full configuration.

The test program assumes that DPRC is mapped at 0x80000E00 in the APB address space, while FIR peripheral at 0x80000D00.

Connect to the board using GRMON and run the test program located in <template directory>/dpr_demo/dpr_test. For each program run, two reconfigurations are triggered. The first reconfiguration swaps the fast FIR (fir_v1.vhd) with the slow FIR (fir_v2.vhd), while the second reconfiguration does the opposite. To notice the different behaviour of the two filter versions, look at "Elapsed Clock Cycles" field, which shows the filtering execution time.

 > grmon -uart /dev/ttyUSB1 -baud 460800 -u

Parsing -uart /dev/ttyUSB1
Parsing -baud 460800
Parsing -u

Commands missing help:
 bdump
 datacache

  using port /dev/ttyUSB1 @ 460800 baud
  GRLIB build version: 4151
  Detected frequency:  74 MHz
  
  Component                            Vendor
  LEON3 SPARC V8 Processor             Aeroflex Gaisler
  AHB Debug UART                       Aeroflex Gaisler
  JTAG Debug Link                      Aeroflex Gaisler
  GR Ethernet MAC                      Aeroflex Gaisler
  Contributed core 1                   Various contributions
  Contributed core 2                   Various contributions
  AHB/APB Bridge                       Aeroflex Gaisler
  LEON3 Debug Support Unit             Aeroflex Gaisler
  Single-port DDR2 controller          Aeroflex Gaisler
  SPI Memory Controller                Aeroflex Gaisler
  Generic UART                         Aeroflex Gaisler
  Multi-processor Interrupt Ctrl.      Aeroflex Gaisler
  Modular Timer Unit                   Aeroflex Gaisler
  
  Use command 'info sys' to print a detailed report of attached cores

grmon2> load ./dpr_demo/dpr_test
  40000000 .text                    279.0kB / 279.0kB   [===============>] 100%
  40045BE0 .data                      2.9kB /   2.9kB   [===============>] 100%
  Total size: 281.84kB (372.81kbit/s)
  Entry point 0x40000000
  Image /home/pascal/150108/grlib-pascal-1.3.9-b4151/designs/leon3-digilent-nexys4ddr/dpr_demo/dpr_test loaded
  
grmon2> run
Starting test...
Fast FIR filter results...
825 997 1169 1341 1513 1685 1857 2029 2201 2373 2545 2717 2889 3061 3233 3405 3577 3749 3921 4093 4265 4437 4609 4781 4953 5125 5297 5469 5641 5813 5985 6157 6329 6501 6673 6845 7017 7189 7361 7533 7705 7877 8049 8221 8393 8565 8737 8909 9081 9253 9425 9597 9769 9941 10113 10285 10457 10629 10801 10973 11145 11317 11489 11661 11833 12005 12177 12349 12521 12693 12865 13037 13209 13381 13553 13725 13897 14069 14241 14413 14585 14757 14929 15101 15273 15445 15617 15789 15961 16133 16305 
Elapsed clock cycles: 470
Partial Reconfiguration ended...Status:15
Slow FIR filter results...
825 997 1169 1341 1513 1685 1857 2029 2201 2373 2545 2717 2889 3061 3233 3405 3577 3749 3921 4093 4265 4437 4609 4781 4953 5125 5297 5469 5641 5813 5985 6157 6329 6501 6673 6845 7017 7189 7361 7533 7705 7877 8049 8221 8393 8565 8737 8909 9081 9253 9425 9597 9769 9941 10113 10285 10457 10629 10801 10973 11145 11317 11489 11661 11833 12005 12177 12349 12521 12693 12865 13037 13209 13381 13553 13725 13897 14069 14241 14413 14585 14757 14929 15101 15273 15445 15617 15789 15961 16133 16305 
Elapsed clock cycles: 1358
Partial Reconfiguration ended...Status:15
Fast FIR filter results...
825 997 1169 1341 1513 1685 1857 2029 2201 2373 2545 2717 2889 3061 3233 3405 3577 3749 3921 4093 4265 4437 4609 4781 4953 5125 5297 5469 5641 5813 5985 6157 6329 6501 6673 6845 7017 7189 7361 7533 7705 7877 8049 8221 8393 8565 8737 8909 9081 9253 9425 9597 9769 9941 10113 10285 10457 10629 10801 10973 11145 11317 11489 11661 11833 12005 12177 12349 12521 12693 12865 13037 13209 13381 13553 13725 13897 14069 14241 14413 14585 14757 14929 15101 15273 15445 15617 15789 15961 16133 16305 
Elapsed clock cycles: 453
  
  Program exited normally.

