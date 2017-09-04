# Synopsys, Inc. constraint file
# /home/jiri/ibm/vhdl/grlib/designs/leon3-gr-xc6s/default.sdc
# Written on Wed Mar 21 16:03:40 2012
# by Synplify Premier, F-2012.03 Scope Editor

#
# Collections
#

#
# Clocks
#
define_clock   {clk} -name {clk}  -freq 50 -clockgroup inclk_clkgroup
define_clock   {n:clkm} -name {n:clkm}  -freq 120 -clockgroup ahb_clkgroup
define_clock   {usb_clkout} -name {usb_clkout}  -freq 60 -clockgroup usb_clkgroup -route 4
define_clock   {n:clk50} -name {n:clk50}  -freq 50 -clockgroup vga_clkgroup -route 4
define_clock   {n:video_clk} -name {n:video_clk}  -freq 50 -clockgroup video_clkgroup -route 2

#
# Clock to Clock
#
define_clock_delay  -rise {clk3} -rise {vga_clkgen|clkgen65.clk0B_derived_clock} -false
define_clock_delay  -rise {vga_clkgen|clkgen65.clk0B_derived_clock} -rise {clk3} -false
define_clock_delay  -rise {leon3mp|clkgen0.xc3s_v.clk0B_derived_clock} -rise {leon3mp|clk50} -false
define_clock_delay  -rise {leon3mp|clk50} -rise {leon3mp|clkgen0.xc3s_v.clk0B_derived_clock} -false

#
# Inputs/Outputs
#
define_output_delay -disable     -default  10.00 -improve 0.00 -route 0.00 -ref {clk:r}
define_input_delay -disable      -default  10.00 -improve 0.00 -route 0.00 -ref {clk:r}
define_output_delay              {8.00} -improve 0.00 -route 0.00 -ref {usb_clkout:r}
define_input_delay               {8.00} -improve 0.00 -route 0.00 -ref {usb_clkout:r}

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
