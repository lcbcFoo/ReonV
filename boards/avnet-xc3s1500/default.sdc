# Synplicity, Inc. constraint file
# /home/jiri/ibm/vhdl/grlib/boards/gr-pci-xc2v/default.sdc
# Written on Fri Jul 30 18:56:40 2004
# by Synplify Pro, 7.6        Scope Editor

#
# Clocks
#
define_clock -name   {clk_66mhz} -freq 75.000 -clockgroup default_clkgroup
define_clock -name   {pci_clk}   -freq 40.000 -clockgroup pci_clkgroup
define_clock -name   {video_clk} -freq 25.000 -clockgroup vid_clkgroup -route 10
define_clock -name   {phy_rxck}  -freq 25.000 -clockgroup ethrx_clkgroup -route 5
define_clock -name   {phy_txck}  -freq 25.000 -clockgroup ethtx_clkgroup -route 5

#
# Clock to Clock
#

#
# Inputs/Outputs
#
#define_output_delay      -default  1.00 -improve 0.00 -route 0.00 -ref {clk_66mhz:r}
#define_input_delay       -default  1.00 -improve 0.00 -route 0.00 -ref {clk_66mhz:r}
#define_input_delay       -default  5.00 -improve 0.00 -route 0.00 -ref {clk_66mhz:r}
#define_input_delay       -default  5.00 -improve 0.00 -route 0.00 -ref {phy_rxck:r}
define_input_delay       {switches[4]}  0.00 -improve 0.00 -route 0.00 -ref {clk_66mhz:r}
define_input_delay       {phy_reset_l}  0.00 -improve 0.00 -route 0.00 -ref {clk_66mhz:r}
define_input_delay       -default  18.00 -improve 0.00 -route 0.00 -ref {pci_clk:r}
define_output_delay      -default  14.00 -improve 0.00 -route 0.00 -ref {pci_clk:r}
define_input_delay       {pci_rst}  0.00 -improve 0.00 -route 0.00 -ref {pci_clk:r}

define_clock_delay -rise pci_clk -rise clk_66mhz -false
define_clock_delay -rise pci_clk -rise phy_rxck -false
define_clock_delay -rise pci_clk -rise phy_txck -false

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
