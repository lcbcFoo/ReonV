# Synplicity, Inc. constraint file
# /home/jiri/ibm/vhdl/grlib/boards/gr-pci-xc2v/default.sdc
# Written on Fri Jul 30 18:56:40 2004
# by Synplify Pro, 7.6        Scope Editor

#
# Clocks
#
define_clock -name   {clk}  -freq 70.000 -clockgroup default_clkgroup
#define_clock -name   {pci_clk}  -freq 40.000 -clockgroup pci_clkgroup

#
# Clock to Clock
#

#
# Inputs/Outputs
#
define_output_delay -disable     -default  14.00 -improve 0.00 -route 0.00 -ref {clk:r}
define_input_delay -disable      -default  14.00 -improve 0.00 -route 0.00 -ref {clk:r}

#
# Registers
#

#
# Multicycle Path
#

#
# False Path
#

#
# Delay Path
#

#
# Attributes
#
define_global_attribute          syn_useioff {1}

#
# Compile Points
#

#
# Other Constraints
#
