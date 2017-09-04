LEON3 ASIC template design
---------------------------

Overview
--------

This LEON3 design demonstrates how to make use of the created GRLIB
scripts in Design Complier and to verify the generated netlist via
gate-level simulation and formal equivalence check.

Note: The Design Compiler flow and parts of this design are still
experimental. Currently the leon3-asic design configuration only has
support for a few of the techmap options available. Default is the
Synopsys 32/28nm Generic Library for Teaching i.e. SAED32. The library
can be downloaded from www.synopsys.com

To compile and simulate the design you will need to modify the file:

SAED32_EDK/lib/pll/verilog/PLL.v

and comment out the VDD and VSS ports.

Simulation and synthesis
------------------------

The user needs to specify the path to the installation of the ASIC
library used in the technology setup file. For SAED32 the user needs
to set the variable SAED32_HOME. This can be set directly in the
design's Makefile. SAED32_HOME should point at the directory
containing SAED32_EDK.

To simulate using Modelsim/Aldec and run systest.c on the LEON3 ASIC
design:

  make comp_saed32_sim (If SAED32 is used)
  make sim
  make soft
  make vsim-launch

Synthesis has been tested using Design Compiler 2013.3-SP1 installed or newer, and 
the SYNOPSYS variable properly set in the shell. To synthesize the design, do

  make dc

Simulation options
------------------

All options are set either by editing the testbench or specify/modify the generic 
default value when launching the simulator. For Modelsim use the option "-g" i.e.
to enable processor disassembly to console launch modelsim with the option: "-gdisas=1"

disas - Enable processor disassembly to console

Memory tests
------------

All on-chip RAM blocks are tested by writing and checking
the following values: 0x55555555, 0xAAAAAAAA, address pattern.
This will insure that all bits are tested to both 0 and 1,
and that the address decoder is tested. Additional patterns
can be added but will result in increased number of test
vectors.


Design specifics
----------------

* Simulation has been tested using Modelsim 10.1 or newer

* Synthesis should be done using Design Compiler 2013.3-SP1 or newer

* Formal verification should be done using Formality 2013.3-SP4 or newer

* ASIC Technology is expected to be integrated into GRLIB 

* Dual-use pins in test mode:

   scanin   -> dsurx
   scanout  -> dsutx
   scanen   -> dsubre
   testrst  -> dsuen
   inoutct  -> rxd1
   testmode -> test
   scanclk  -> clk

