
# Create clocks

create_clock -period  20.0 CLKIN_50

derive_pll_clocks

set ahbclks [ get_clocks { clkgen0* clkin_50 } ]
set_clock_groups -asynchronous -group $ahbclks

