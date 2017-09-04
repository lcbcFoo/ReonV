
# --- Detect if we're running in synthesis or STA

set sta_mode 0
if { $::TimeQuestInfo(nameofexecutable) == "quartus_sta" } {
        set sta_mode 1
} 

# --- Routine to constrain CDC to allow a maximum skew of one clock cycle
#     of the faster clock. For synthesis we just timing-ignore the CDC.

if { !$sta_mode } {
	proc constrain_cdc { clks1 per1 clks2 per2 } {
		set_clock_groups -asynchronous -group $clks1 -group $clks2
	}
} else {
	proc constrain_cdc { clks1 per1 clks2 per2 } {
		set_max_delay -from $clks1 -to $clks2 50.0
		set_max_delay -from $clks2 -to $clks1 50.0
		set_min_delay -from $clks1 -to $clks2 -20.0
		set_min_delay -from $clks2 -to $clks1 -20.0
		set minper [ expr { ($per1>$per2)?$per2:$per1 } ]
		set_max_skew -from_clock $clks1 -to_clock $clks2 $minper
		set_max_skew -from_clock $clks2 -to_clock $clks1 $minper
	}
}


# ---------------------------------------------

# Create clocks

create_clock -period  20.0 OSC_50_BANK2
create_clock -period  20.0 OSC_50_BANK3
create_clock -period  20.0 OSC_50_BANK4
create_clock -period  20.0 OSC_50_BANK5
create_clock -period  20.0 OSC_50_BANK6
create_clock -period  20.0 OSC_50_BANK7
create_clock -period  10.0 PLL_CLKIN_p

derive_pll_clocks

set ahbclks [ get_clocks { clkgen0* } ]
set eth0clks [ get_clocks { \eth0:e0|sgmii0|pma0|* } ]
set eth1clks [ get_clocks { \eth1:e1|sgmii0|pma0|* } ]
set aficlk [ get_clocks { \l2cdis:ddr2cen:ddr2c|*|pll_afi_clk } ]

set_clock_groups -exclusive -group $ahbclks -group $aficlk

constrain_cdc $ahbclks 10.0 $eth0clks 8.0
constrain_cdc $ahbclks 10.0 $eth1clks 8.0
