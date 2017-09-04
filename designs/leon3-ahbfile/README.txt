LEON3 Template design with AHBFILE debug communication link
-----------------------------------------------------------

0. Introduction
---------------

The design can only be simulated with GHDL, GCC or LLVM versions. Version 0.33
for both GCC and LLVM has been tested. Synthesis is not supported by the
design.

To improve simulation speed, the design configuration is minimal. It contains a
LEON3, AHBRAM, IRQMP, GPTIMER and APBUART.


1. Analyse and elaborate
------------------------

Use 'make xconfig' to modify the configuration if needed.

Analyse and elaborate design:

$ make ghdl

This generates the executable file 'testbench'.


2. Create pseudoterminal files
------------------------------

Component ahbfile opens a file named 'slave_sim' and operates on the file with
the AHBUART debug link protocol. GRMON can be connected to the simulated design
over a pseudoterminal. The utility 'socat' is very helpful in establishing a
link between simulation and GRMON. (On a Debian based system, the utility can
be installed with 'apt-get install socat'.)

To create the pseudoterminal files, run the following command in a terminal:

$ socat -d PTY,raw,echo=0,link=slave_grmon PTY,raw,echo=0,link=slave_sim

This creates two symbolic links named 'slave_grmon' and 'slave_sim' which point
to two pseudoterminals connected together. Simulated design connects to
'slave_sim' and GRMON2 will later connect to 'slave_grmon'. A shortcut to the
above socat command line is provided in the shell script file named 'connect'.

(More options can be given to socat, for example to dump communication link
data to the terminal.)


3. Start simulation
-------------------

Simulation is started with:

$ make ghdl-run

[...]
LEON3 MP Demonstration design
GRLIB Version 1.4.1, build 4156
Target technology: inferred  , memory library: inferred  
ahbctrl: AHB arbiter/multiplexer rev 1
ahbctrl: Common I/O area at 0xfff00000, 1 Mbyte
ahbctrl: AHB masters: 2, AHB slaves: 3
ahbctrl: Configuration area at 0xfffff000, 4 kbyte
ahbctrl: mst0: Cobham Gaisler          LEON3 SPARC V8 Processor       
ahbctrl: mst1: Cobham Gaisler          Unknown Device                 
ahbctrl: slv0: Cobham Gaisler          LEON3 Debug Support Unit       
ahbctrl:       memory at 0x90000000, size 256 Mbyte
ahbctrl: slv1: Cobham Gaisler          Single-port AHB SRAM module    
ahbctrl:       memory at 0x40000000, size 1 Mbyte, cacheable, prefetch
ahbctrl: slv2: Cobham Gaisler          AHB/APB Bridge                 
ahbctrl:       memory at 0x80000000, size 1 Mbyte
apbctrl: APB Bridge at 0x80000000 rev 1
apbctrl: slv1: Cobham Gaisler          Generic UART                   
apbctrl:       I/O ports at 0x80000100, size 256 byte 
apbctrl: slv2: Cobham Gaisler          Multi-processor Interrupt Ctrl.
apbctrl:       I/O ports at 0x80000200, size 256 byte 
apbctrl: slv3: Cobham Gaisler          Modular Timer Unit             
apbctrl:       I/O ports at 0x80000300, size 256 byte 
ahbram1: AHB SRAM Module rev 1, 64 kbytes
gptimer3: Timer Unit rev 1, 8-bit scaler, 2 32-bit timers, irq 8
irqmp: Multi-processor Interrupt Controller rev 3, #cpu 1, eirq 0
apbuart1: Generic UART rev 1, fifo 1, irq 2, scaler bits 12
dsu3_0: LEON3 Debug support unit + AHB Trace Buffer, 2 kbytes
leon3_0: LEON3 SPARC V8 processor rev 3: iuft: 0, fpft: 0, cacheft: 0
leon3_0: icache 0*0 kbyte, dcache 0*0 kbyte
ahbfile1: File I/O debug communication link rev 1
ahbfile_init: Connecting to file `slave_sim`.
       16625 ns : cpu0: 0x00000000    unknown opcode: 0xXXXXXXXX  (trapped)


If disassembly output is enabled, we see that the CPU traps on address 0. No
memory is available here so this is OK. An AHBRAM is available at 0x40000000.


4. Connect with GRMON2
----------------------

GRMON2 can be connected to the simulation with the following command line:

$ grmon -uart slave_grmon -freq 4 -dsudelay 200 -u

- Parameter -uart selects our pseudoterminal. Baud rate does not matter.
- Parameter -freq 4 tells GRMON2 that the system frequency is 4 MHz. This is used to
  initialize the GPTIMER prescaler.
- Parameter -dsudelay 200 limits how often GRMON2 polls the DSU to detect if
  CPU has entered debug mode. Used to prevent steeling to many bus cycles from
  the simulated system.
- Parameter -u enables application console I/O forwarding to GRMON2.

The output from GRMON2 should look something like this:

  GRMON2 LEON debug monitor v2.0.69.1 32-bit eval version
  
  Copyright (C) 2015 Cobham Gaisler - All rights reserved.
  For latest updates, go to http://www.gaisler.com/
  Comments or bug-reports to support@gaisler.com
  
  This eval version will expire on 10/05/2016

  using port slave_grmon @ 115200 baud
  GRLIB build version: 4156
  Detected frequency:  4 MHz
  
  Component                            Vendor
  LEON3 SPARC V8 Processor             Cobham Gaisler
  Unknown device                       Cobham Gaisler
  LEON3 Debug Support Unit             Cobham Gaisler
  Single-port AHB SRAM module          Cobham Gaisler
  AHB/APB Bridge                       Cobham Gaisler
  Generic UART                         Cobham Gaisler
  Multi-processor Interrupt Ctrl.      Cobham Gaisler
  Modular Timer Unit                   Cobham Gaisler
  
  Use command 'info sys' to print a detailed report of attached cores

grmon2> info sys dsu0
  dsu0      Cobham Gaisler  LEON3 Debug Support Unit    
            AHB: 90000000 - A0000000
            AHB trace: 128 lines, 32-bit bus
            CPU0:  win 8, hwbp 2, itrace 128, lddel 1
                   stack pointer 0x400ffff0
                   icache 1 * 1 kB, 32 B/line
                   dcache 1 * 1 kB, 32 B/line
  
grmon2> info sys ahbram0
  ahbram0   Cobham Gaisler  Single-port AHB SRAM module    
            AHB: 40000000 - 40100000
            32-bit static ram: 1024 kB @ 0x40000000


5. Application loading
----------------------

Writing over the debug link from GRMON2 is fast but operating on the received
data in the simulation is slow, and there is buffering inbetween. This means
that when GRMON2 is done with a 'load' command, all data may not have arrived
on the AMBA bus yet. Starting another debug link transfers when there are many
outstanding writes on the debug link typically causes GRMON2 to recognize debug
link timeout.

To provide the user with information on debug link activity, the ahbfile
component prints progress (dots) on standard output.

Here are the steps for loading and running a program in GRMON2, using the
template design with ahbfile.

grmon2> load main
  40000000 .text                     24.0kB /  24.0kB   [===============>] 100%
  40005FE0 .data                      2.9kB /   2.9kB   [===============>] 100%
  Total size: 26.83kB (0.00bit/s)
  Entry point 0x40000000
  Image main loaded

grmon2>
[Now wait until simulator stops outputing dots.]
grmon2> run


6. Operation
------------
64 KiB (configurable) of AHBRAM is available at address 0x40000000.

DSU commands 'bp', 'step', 'reg', 'cont', 'inst' etc. works as usual.

The APBUART supports application I/O forwarding.

It is possible to generate waveform output from the testbench binary with the
--wave command line parameter (see GHDL manual or ./testbench --help). The
waveform can then be loaded into 'gtkwave' for inspection. This option slows
down simulation alot.


7. Limitations
--------------

- The ahb trace does not work for unknown reasons. Instruction trace works.
- 'make ghdl' does not track changes to file ahbfile_foreign.c properly. To
  regenerate the 'ghdl' target after ahbfile_foreign.c is updated, remove file
  testbench first.
- Component ahbfile polls the file slave_sim every simulated clock cycle. It is
  implemented with a read() call to the operating system in function
  ahbfile_getbyte. Before implementing buffering here, do a 'time make ghdl-run'
  to see how much time the simulation actually spends in the OS.

