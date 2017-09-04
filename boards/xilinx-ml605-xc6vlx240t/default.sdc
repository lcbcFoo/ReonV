# Synopsys, Inc. constraint file
# /home/jiri/vhdl/grlib-gpl-1.1.0-b4107/boards/xilinx-ml605-xc6vlx240t/default.sdc
# Written on Wed Mar  9 23:14:02 2011
# by Synplify Pro, D-2010.03-SP1-1 Scope Editor

#
# Collections
#

#
# Clocks
#
define_clock -disable   {clk27} -name {clk27}  -freq 30 -clockgroup default_clkgroup_0 -route 0
define_clock   {clk_ref_p} -name {clk_ref_p}  -freq 200 -clockgroup ddr2_clkgroup -route 0
define_clock -disable   {clkm} -name {clkm}  -freq 80 -clockgroup main_clkgroup -route 0
define_clock -disable   {clkml} -name {clkml}  -freq 135 -clockgroup ddr_clkgroup -route 0
define_clock -disable   {etx_clk} -name {etx_clk}  -freq 25 -clockgroup phy_rx_clkgroup -route 0
define_clock -disable   {erx_clk} -name {erx_clk}  -freq 25 -clockgroup phy_tx_clkgroup -route 0

#
# Clock to Clock
#

#
# Inputs/Outputs
#
define_output_delay -disable     -default  10.00 -improve 0.00 -route 0.00 -ref {clk:r}
define_input_delay -disable      -default  10.00 -improve 0.00 -route 0.00 -ref {clk:r}

#
# Registers
#

#
# Delay Paths
#

#
# Attributes
#
define_global_attribute  {syn_useioff} {1}

#
# I/O Standards
#

#
# Compile Points
#

#
# Other
#
