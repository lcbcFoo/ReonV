# Synopsys, Inc. constraint file
# /home/jiri/ibm/vhdl/grlib/boards/xilinx-spa3-dsp1800a/default.sdc
# Written on Wed Apr  7 16:52:58 2010
# by Synplify Pro, D-2009.12 Scope Editor

#
# Collections
#

#
# Clocks
#
define_clock   {clk_in} -name {clk_in}  -freq 135 -clockgroup clkin_clkgroup -route 0
define_clock   {n:clkm} -name {clkm}  -freq 60 -clockgroup main_clkgroup -route 0
#define_clock   {n:clkml} -name {clkml}  -freq 135 -clockgroup ddr_clkgroup -route 0
define_clock   {ddr_clk_fb} -name {ddr_clk_fb}  -freq 135 -clockgroup ddr_fb_clkgroup -route 0
define_clock   {clk_vga} -name {clk_vga}  -freq 25 -clockgroup vga_clkgroup -route 0
define_clock   {etx_clk} -name {etx_clk}  -freq 25 -clockgroup phy_rx_clkgroup -route 0
define_clock   {erx_clk} -name {erx_clk}  -freq 25 -clockgroup phy_tx_clkgroup -route 0

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
