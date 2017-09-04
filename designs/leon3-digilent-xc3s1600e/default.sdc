# Synplicity, Inc. constraint file
# /home/jiri/ibm/vhdl/grlib/designs/leon3-digilent-xc3s1600e/default.sdc
# Written on Thu Jan 25 01:39:56 2007
# by Synplify Pro, Synplify Pro 8.8 Scope Editor

#
# Collections
#

#
# Clocks
#
define_clock            {etx_clk} -name {etx_clk}  -freq 25 -route 10 -clockgroup phy_rx_clkgroup
define_clock            {erx_clk} -name {erx_clk}  -freq 25 -route 10 -clockgroup phy_tx_clkgroup
define_clock            {ddr_clk_fb} -name {ddr_clk_fb}  -freq 125 -clockgroup ddr_read_group
define_clock            {n:clkml} -name {clkml}  -freq 125 -clockgroup ddr_clkgroup
define_clock            {n:clkm} -name {clkm}  -freq 50 -clockgroup ahb_clkgroup
define_clock            {clk_50mhz} -name {clk_50mhz}  -freq 55 -route 2 -clockgroup clk50_clkgroup

#
# Clock to Clock
#
#define_clock_delay           -rise {leon3mp|ddrsp0.ddrc.ddr_phy0.ddr_phy0.clk} -rise {clkm} -false
#define_clock_delay           -rise {clk_50mhz} -rise {leon3mp|ddrsp0.ddrc.ddr_phy0.ddr_phy0.clk} -false
#define_clock_delay           -rise {leon3mp|clkgen0.xc3s.v.clk0B_derived_clock} -rise {leon3mp|ddrsp0.ddrc.ddr_phy0.ddr_phy0.clk} -false
#define_clock_delay           -rise {leon3mp|clkgen0.xc3s.v.clk0B_derived_clock} -rise {leon3mp|clkgen0.xc3s.v.clk_x_derived_clock} -false
#define_clock_delay           -rise {leon3mp|clkgen0.xc3s.v.clk0B_derived_clock} -rise {ddrspa|ddr_phy0.ddr_phy0.xc3se.ddr_phy0.clk_270ro_derived_clock} -false

#
# Inputs/Outputs
#
define_output_delay -disable     -default  10.00 -improve 0.00 -route 0.00 -ref {clk:r}
define_input_delay -disable      -default  10.00 -improve 0.00 -route 0.00 -ref {clk:r}

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
