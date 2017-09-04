This folder includes the .vhd design files of the custom FIR filter AHB/APB peripheral, the associated netlists (.ngc), a tcl script implementing the PR design flow, and a C test program used for demonstrating partial reconfiguration on LEON3.

Issue make dprc-demo in the template design directory to execute the entire partial reconfiguration design flow, after instantiating DPRC controller in the design (use make xconfig).
Issue make dprc-demo-prog to program the fpga with the first configuration.

The test program assumes that DPRC is mapped at 0x80000B00 in the APB address space, while FIR peripheral at 0x80000C00.

Connect to the board using GRMON and run the test program located in <template directory>/dpr_demo/dpr_test. For each program run, two reconfigurations are triggered. The first reconfiguration swaps the fast FIR (fir_v1.vhd) with the slow FIR (fir_v2.vhd), while the second reconfiguration does the opposite. To notice the different behaviour of the two filter versions, look at "Elapsed Clock Cycles" field, which shows the filtering execution time.

As mentioned in DPRC user guide, it is expected that the first reconfiguration fails with status code 0x8.

grmon -uart /dev/ttyUSB0 -baud 460800 -u

  GRMON2 LEON debug monitor v2.0.55r2 internal version
  
  Copyright (C) 2014 Aeroflex Gaisler - All rights reserved.
  For latest updates, go to http://www.gaisler.com/
  Comments or bug-reports to support@gaisler.com
  
  This internal version will expire on 28/07/2015

Parsing -uart /dev/ttyUSB0
Parsing -baud 460800
Parsing -u

Commands missing help:
 bdump
 datacache

  using port /dev/ttyUSB0 @ 460800 baud
  GRLIB build version: 4150
  Detected frequency:  59 MHz
  
  Component                            Vendor
  LEON3 SPARC V8 Processor             Aeroflex Gaisler
  AHB Debug UART                       Aeroflex Gaisler
  Contributed core 1                   Various contributions
  Contributed core 2                   Various contributions
  LEON2 Memory Controller              European Space Agency
  AHB/APB Bridge                       Aeroflex Gaisler
  LEON3 Debug Support Unit             Aeroflex Gaisler
  Generic UART                         Aeroflex Gaisler
  Multi-processor Interrupt Ctrl.      Aeroflex Gaisler
  Modular Timer Unit                   Aeroflex Gaisler
  General Purpose I/O port             Aeroflex Gaisler
  Generic UART                         Aeroflex Gaisler
  AHB Status Register                  Aeroflex Gaisler
  
  Use command 'info sys' to print a detailed report of attached cores

grmon2> info sys
  cpu0      Aeroflex Gaisler  LEON3 SPARC V8 Processor    
            AHB Master 0
  ahbuart0  Aeroflex Gaisler  AHB Debug UART    
            AHB Master 1
            APB: 80000700 - 80000800
            Baudrate 460800, AHB frequency 59.00 MHz
  adev2     Various contributions  Contributed core 1    
            AHB Master 3
            APB: 80000B00 - 80000C00
  adev3     Various contributions  Contributed core 2    
            AHB Master 4
            APB: 80000C00 - 80000D00
  mctrl0    European Space Agency  LEON2 Memory Controller    
            AHB: 00000000 - 20000000
            AHB: 20000000 - 40000000
            AHB: 40000000 - 80000000
            APB: 80000000 - 80000100
            32-bit prom @ 0x00000000
            64-bit sdram: 2 * 128 Mbyte @ 0x40000000
            col 9, cas 2, ref 7.8 us
  apbmst0   Aeroflex Gaisler  AHB/APB Bridge    
            AHB: 80000000 - 80100000
  dsu0      Aeroflex Gaisler  LEON3 Debug Support Unit    
            AHB: 90000000 - A0000000
            AHB trace: 128 lines, 32-bit bus
            CPU0:  win 8, hwbp 2, itrace 128, V8 mul/div, lddel 1
                   stack pointer 0x4ffffff0
                   icache 2 * 16 kB, 32 B/line lrr
                   dcache 2 * 4 kB, 32 B/line lrr
  uart0     Aeroflex Gaisler  Generic UART    
            APB: 80000100 - 80000200
            IRQ: 2
            Baudrate 38411
  irqmp0    Aeroflex Gaisler  Multi-processor Interrupt Ctrl.    
            APB: 80000200 - 80000300
  gptimer0  Aeroflex Gaisler  Modular Timer Unit    
            APB: 80000300 - 80000400
            IRQ: 8
            8-bit scalar, 3 * 32-bit timers, divisor 59
  gpio0     Aeroflex Gaisler  General Purpose I/O port    
            APB: 80000600 - 80000700
  uart1     Aeroflex Gaisler  Generic UART    
            APB: 80000900 - 80000A00
            IRQ: 3
            Baudrate 38411
  ahbstat0  Aeroflex Gaisler  AHB Status Register    
            APB: 80000F00 - 80001000
            IRQ: 1


grmon2> load dpr_demo/dpr_test 
  40000000 .text                    132.7kB / 132.7kB   [===============>] 100%
  400212B0 .data                      2.9kB /   2.9kB   [===============>] 100%
  Total size: 135.54kB (375.11kbit/s)
  Entry point 0x40000000
  Image /home/pascal/v2GRLIB_repo/grlib-pascal-1.3.9-b4150/designs/leon3-gr-cpci-xc4v/dpr_demo/dpr_test loaded
  
grmon2> run
Starting test...
Fast FIR filter results...
825 997 1169 1341 1513 1685 1857 2029 2201 2373 2545 2717 2889 3061 3233 3405 3577 3749 3921 4093 4265 4437 4609 4781 4953 5125 5297 5469 5641 5813 5985 6157 6329 6501 6673 6845 7017 7189 7361 7533 7705 7877 8049 8221 8393 8565 8737 8909 9081 9253 9425 9597 9769 9941 10113 10285 10457 10629 10801 10973 11145 11317 11489 11661 11833 12005 12177 12349 12521 12693 12865 13037 13209 13381 13553 13725 13897 14069 14241 14413 14585 14757 14929 15101 15273 15445 15617 15789 15961 16133 16305 
Elapsed clock cycles: 308
Partial Reconfiguration ended...Status:8
Partial Reconfiguration ended...Status:15
Fast FIR filter results...
825 997 1169 1341 1513 1685 1857 2029 2201 2373 2545 2717 2889 3061 3233 3405 3577 3749 3921 4093 4265 4437 4609 4781 4953 5125 5297 5469 5641 5813 5985 6157 6329 6501 6673 6845 7017 7189 7361 7533 7705 7877 8049 8221 8393 8565 8737 8909 9081 9253 9425 9597 9769 9941 10113 10285 10457 10629 10801 10973 11145 11317 11489 11661 11833 12005 12177 12349 12521 12693 12865 13037 13209 13381 13553 13725 13897 14069 14241 14413 14585 14757 14929 15101 15273 15445 15617 15789 15961 16133 16305 
Elapsed clock cycles: 321
  
  Program exited normally.
  
grmon2> run
Starting test...
Fast FIR filter results...
825 997 1169 1341 1513 1685 1857 2029 2201 2373 2545 2717 2889 3061 3233 3405 3577 3749 3921 4093 4265 4437 4609 4781 4953 5125 5297 5469 5641 5813 5985 6157 6329 6501 6673 6845 7017 7189 7361 7533 7705 7877 8049 8221 8393 8565 8737 8909 9081 9253 9425 9597 9769 9941 10113 10285 10457 10629 10801 10973 11145 11317 11489 11661 11833 12005 12177 12349 12521 12693 12865 13037 13209 13381 13553 13725 13897 14069 14241 14413 14585 14757 14929 15101 15273 15445 15617 15789 15961 16133 16305 
Elapsed clock cycles: 308
Partial Reconfiguration ended...Status:15
Slow FIR filter results...
825 997 1169 1341 1513 1685 1857 2029 2201 2373 2545 2717 2889 3061 3233 3405 3577 3749 3921 4093 4265 4437 4609 4781 4953 5125 5297 5469 5641 5813 5985 6157 6329 6501 6673 6845 7017 7189 7361 7533 7705 7877 8049 8221 8393 8565 8737 8909 9081 9253 9425 9597 9769 9941 10113 10285 10457 10629 10801 10973 11145 11317 11489 11661 11833 12005 12177 12349 12521 12693 12865 13037 13209 13381 13553 13725 13897 14069 14241 14413 14585 14757 14929 15101 15273 15445 15617 15789 15961 16133 16305 
Elapsed clock cycles: 1230
Partial Reconfiguration ended...Status:15
Fast FIR filter results...
825 997 1169 1341 1513 1685 1857 2029 2201 2373 2545 2717 2889 3061 3233 3405 3577 3749 3921 4093 4265 4437 4609 4781 4953 5125 5297 5469 5641 5813 5985 6157 6329 6501 6673 6845 7017 7189 7361 7533 7705 7877 8049 8221 8393 8565 8737 8909 9081 9253 9425 9597 9769 9941 10113 10285 10457 10629 10801 10973 11145 11317 11489 11661 11833 12005 12177 12349 12521 12693 12865 13037 13209 13381 13553 13725 13897 14069 14241 14413 14585 14757 14929 15101 15273 15445 15617 15789 15961 16133 16305 
Elapsed clock cycles: 321
  
  Program exited normally.


