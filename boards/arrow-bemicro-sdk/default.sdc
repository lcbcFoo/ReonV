# Synplicity, Inc. constraint file

#
# Collections
#

#
# Clocks
#
define_clock  -name {clk_fpga_50m}  -freq 50.000 -clockgroup default_clkgroup -route 5
define_clock  -name {rx_clk} -freq 25.000 -clockgroup erx_clkgroup -route 5
define_clock  -name {tx_clk} -freq 25.000 -clockgroup etx_clkgroup -route 5


#
# Inputs/Outputs
#

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
