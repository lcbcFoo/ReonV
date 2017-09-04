# Synplicity, Inc. constraint file
# /home/jiri/ibm/vhdl/grlib/boards/gr-xc3s-1500/default.sdc
# Written on Thu May 11 15:07:16 2006
# by Synplify Pro, 7.1.1       Scope Editor

#
# Clocks
#
define_clock            -name {n:clkm}  -freq 50.000 -route 5.0  -clockgroup default_clkgroup
define_clock            -name {rxclki}  -freq 100.000 -route 2.0 -clockgroup rxclki_clkgroup
define_clock            -name {txclk}  -freq 100.000 -route 2.0  -clockgroup txclk_clkgroup
define_clock            -name {erx_clk}  -freq 25.000 -route 5.0  -clockgroup erx_clkgroup
define_clock            -name {etx_clk}  -freq 25.000 -route 5.0  -clockgroup etx_clkgroup
define_clock            -name {usb_clkout}  -freq 60.000 -route 4.0  -clockgroup usb_clkgroup
define_clock            -name {n:clk50}  -freq 50.000 -route 4.0  -clockgroup vga_clkgroup
define_clock            -name {ethclk}  -freq 25.000 -route 4.0  -clockgroup eth_clkgroup
define_clock            -name {clk3}  -freq 25.000 -route 2.0  -clockgroup eth_clkgroup
define_clock            -name {n:video_clk}  -freq 50.000 -route 2.0  -clockgroup video_clkgroup

#
# Inputs/Outputs
#
define_clock_delay  -rise {clk3} -rise {vga_clkgen|clkgen65.clk0B_derived_clock} -false
define_clock_delay  -rise {vga_clkgen|clkgen65.clk0B_derived_clock} -rise {clk3} -false
define_clock_delay  -rise {leon3mp|clkgen0.xc3s_v.clk0B_derived_clock} -rise {leon3mp|clk50} -false
define_clock_delay  -rise {leon3mp|clk50} -rise {leon3mp|clkgen0.xc3s_v.clk0B_derived_clock} -false

define_output_delay -disable     -default  10.00 -improve 0.00 -route 0.00 -ref clk:r
define_input_delay -disable      -default  10.00 -improve 0.00 -route 0.00 -ref clk:r
define_output_delay 8.00 -improve 0.00 -route 0.00 -ref {usb_clkout:r}
define_input_delay  8.00 -improve 0.00 -route 0.00 -ref {usb_clkout:r}

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
# Attributes
#
define_global_attribute          syn_useioff {1}

#
# Other Constraints
#
