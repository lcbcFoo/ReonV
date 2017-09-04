# Synplicity, Inc. constraint file
# /home/jiri/ibm/vhdl/grlib/boards/gr-xc3s-1500/default.sdc
# Written on Thu May 11 15:07:16 2006
# by Synplify Pro, 7.1.1       Scope Editor

#
# Clocks
#
define_clock            -name {clk_ref_p}  -freq 225.000 -route 0.0  -clockgroup sysclk_clkgroup
define_clock            -name {gmiiclk_p}  -freq 125.000 -route 1.0  -clockgroup gmiiclk_clkgroup
define_clock            -name {clk_33}  -freq 33.333 -route 5.0  -clockgroup sysace_clkgroup
define_clock            -name {n:clkm}  -freq 120.000 -route 0.0  -clockgroup ahb_clkgroup
define_clock            -name {n:clk100}  -freq 100.000 -route 2.0  -clockgroup svga_clkgroup
define_clock            -name {n:clk125}  -freq 125.000 -route 2.0  -clockgroup svga_clkgroup
define_clock            {n:clkvga} -name {leon3mp|clkvga}  -freq 65 -route 4 -clockgroup vga_clkgroup

#
# Inputs/Outputs
#
#define_clock_delay  -rise {clk3} -rise {vga_clkgen|clkgen65.clk0B_derived_clock} -false
#define_clock_delay  -rise {vga_clkgen|clkgen65.clk0B_derived_clock} -rise {clk3} -false
#define_clock_delay  -rise {leon3mp|clkgen0.xc3s_v.clk0B_derived_clock} -rise {leon3mp|clk50} -false
#define_clock_delay  -rise {leon3mp|clk50} -rise {leon3mp|clkgen0.xc3s_v.clk0B_derived_clock} -false
#
#define_output_delay -disable     -default  10.00 -improve 0.00 -route 0.00 -ref clk:r
#define_input_delay -disable      -default  10.00 -improve 0.00 -route 0.00 -ref clk:r
#define_output_delay 8.00 -improve 0.00 -route 0.00 -ref {usb_clkout:r}
#define_input_delay  8.00 -improve 0.00 -route 0.00 -ref {usb_clkout:r}

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
