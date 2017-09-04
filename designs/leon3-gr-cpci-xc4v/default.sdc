# Synplicity, Inc. constraint file
# /home/jiri/ibm/vhdl/grlib/boards/gr-cpci-xc2v/default.sdc
# Written on Mon Feb 14 11:45:37 2005
# by Synplify Pro, Synplify Pro 8.0 Scope Editor

#
# Collections
#

#
# Clocks
#
define_clock  -name {clk}  -freq 65.000 -clockgroup default_clkgroup
define_clock  -name {pci_clk}  -freq 33.000 -clockgroup pci_clkgroup -route 6

#
# Clock to Clock
#

#
# Inputs/Outputs
#
define_output_delay -disable    -default  14.00 -improve 0.00 -route 0.00 -ref {clk:r}
define_input_delay -disable      -default  14.00 -improve 0.00 -route 0.00 -ref {clk:r}
define_output_delay      -default  19.00 -improve 0.00 -route 4.00 -ref {pci_clk:r}
define_input_delay       -default  23.00 -improve 0.00 -route 3.00 -ref {pci_clk:r}
define_input_delay       {pci_rst}  0.00 -improve 0.00 -route 0.00 -ref {pci_clk:r}
define_input_delay       {pci_host}  0.00 -improve 0.00 -route 0.00 -ref {pci_clk:r}

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
# Path Delay
#

#
# Attributes
#
define_global_attribute          syn_useioff {1}

#
# I/O standards
#

#
# Compile Points
#

#
# Other Constraints
#
