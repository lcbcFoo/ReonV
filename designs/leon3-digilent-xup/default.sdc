# Clocks
#
#define_clock            -name {clk}  -freq 100.000 -route 1.0 -clockgroup default_clkgroup
define_clock            -name {etx_clk}  -freq 25.000 -route 10.0 -clockgroup phy_rx_clkgroup
define_clock            -name {erx_clk}  -freq 25.000 -route 10.0 -clockgroup phy_tx_clkgroup
define_clock            -name {ddr_clk_fb} -freq 125.000 -clockgroup -route 1.0 ddr_read_group
define_clock            -name {n:clkvga} -freq 65.000 -route 4.0 -clockgroup clkvga_group

define_clock            -name {n:clkml} -freq 125.000 -route 1.0 -clockgroup ddr_clkgroup
define_clock            -name {n:clkm} -freq 100.000 -route 1.0 -clockgroup cpu_clkgroup
#define_clock            -name {leon3mp|ddrsp0.ddr0.ddr_phy0.clk} -freq 100.000 -route 1.0 -clockgroup ddr_clkgroup
#define_clock            -name {leon3mp|clkgen0.clkin}  -freq 100.000 -route 1.0 -clockgroup ahb_clkgroup
#
# Clock to Clock
#
#define_clock_delay           -rise {ddr_clk_fb} -rise {leon3mp|clkgen0.clkin} 4.0

#define_clock_delay -rise leon3mp|clkgen0.xc2v.v.clk0B_derived_clock  -rise ddrspa|ddr_phy0.ddr_phy0.xc2v.ddr_phy0.clk_270ro_derived_clock -false
#define_clock_delay -rise ddrspa|ddr_phy0.ddr_phy0.xc2v.ddr_phy0.clk_0ro_derived_clock -rise leon3mp|clkgen0.xc2v.v.clk0B_derived_clock -false
#define_clock_delay -rise ddrspa|ddr_phy0.ddr_phy0.xc2v.ddr_phy0.clk_270ro_derived_clock -rise leon3mp|clkgen0.xc2v.v.clk0B_derived_clock -false

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
