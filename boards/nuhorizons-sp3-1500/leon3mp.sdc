#
# Clocks
#
define_clock  -name {pll_clk}  -freq 60.000 -clockgroup default_clkgroup

#
# Inputs/Outputs
#
define_output_delay -disable -default  14.00 -improve 0.00 -route 0.00 -ref pll_clk:r
define_input_delay  -disable -default  10.00 -improve 0.00 -route 0.00 -ref pll_clk:r

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

#
#  Order of waveforms 
#
