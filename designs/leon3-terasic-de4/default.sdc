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
define_clock  -name {clock_50}  -freq 50.000 -clockgroup default_clkgroup -route 5
define_clock  -name {enet0_rx_clk} -freq 25.000 -clockgroup erx_clkgroup -route 5
define_clock  -name {enet0_tx_clk} -freq 25.000 -clockgroup etx_clkgroup -route 5

create_clock -name CLK_M1 -period "50 MHZ" [get_ports OSC_50_Bank3]
create_clock -name CLK_M2 -period "50 MHZ" [get_ports OSC_50_Bank4]

#define_clock  -name {clkm125} -freq 25.000 -clockgroup etx_clkgroup -route 5
#define_clock  -name {leon3mp|erx_clk} -freq 125.000 -clockgroup erx_clkgroup
#define_clock  -name {leon3mp|egtx_clk}  -freq 125.000 -clockgroup phy_egtx_clkgroup -route 2.000
#define_clock  -name {leon3mp|eth_macclk}  -freq 125.000 -clockgroup phy_egtx_clkgroup -route 2.000
#define_clock  -name {leon3mp|clkgen0.clkin}  -freq 50.000 -route 2.0 -clockgroup ahb_clkgroup
#
# Clock to Clock
#define_clock_delay -rise leon3mp|clkgen0.xc5l.v.clk0B_derived_clock -rise leon3mp|egtx_clk -false
#define_clock_delay -rise leon3mp|egtx_clk -rise leon3mp|clkgen0.xc5l.v.clk0B_derived_clock -false
#

#
# Inputs/Outputs
#
#define_output_delay -disable    -default  14.00 -improve 0.00 -route 0.00 -ref {clk:r}
#define_input_delay -disable      -default  14.00 -improve 0.00 -route 0.00 -ref {clk:r}
#define_output_delay      -default  19.00 -improve 0.00 -route 3.00 -ref {pci_clk:r}
#define_input_delay       -default  23.00 -improve 0.00 -route 2.00 -ref {pci_clk:r}
#define_input_delay       {pci_rst}  0.00 -improve 0.00 -route 0.00 -ref {pci_clk:r}
#define_input_delay       -default 6.50 -improve 0.00 -route 1.00 -ref {usb_clkout:r}
#define_output_delay      -default 6.50 -improve 0.00 -route 1.00 -ref {usb_clkout:r}
#define_output_delay      {usb_resetn} 0.00 -improve 0.00 -route 0.00 -ref {usb_clkout:r}
#define_input_delay       -default 2.00 -improve 0.00 -route 1.00 -ref {eth_macclk:r}
#define_output_delay      -default 5.50 -improve 0.00 -route 1.00 -ref {eth_macclk:r}


#
# Registers
#

#
# Multicycle Path
#

#
# False Path
#

set_false_path -from [get_clocks {clkgen0|\stra3:v|sdclk_pll|\nosd:altpll0|auto_generated|pll1|clk[0]}] -to [get_clocks {\eth1:pll0|altpll_component|auto_generated|pll1|clk[0]}]
set_false_path -from [get_clocks {\eth1:bridge1|lvds_rx|ALTLVDS_RX_component|auto_generated|rx_0|clk0}] -to [get_clocks {clkgen0|\stra3:v|sdclk_pll|\nosd:altpll0|auto_generated|pll1|clk[0]}]

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
