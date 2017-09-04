
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

create_clock -period  8.0 diff_clkin_top_125_p
create_clock -period 20.0 clkin_50_fpga_right
create_clock -period 20.0 clkin_50_fpga_top

create_clock -period 40.0 eneta_tx_clk
create_clock -period 40.0 eneta_rx_clk
create_clock -period 40.0 enetb_tx_clk
create_clock -period 40.0 enetb_rx_clk

derive_pll_clocks

set ahbclks [ get_clocks { clkgen0* } ]
set aficlk1 [ get_clocks { ddr3if0|*|pll_afi_clk } ]
set aficlk2 [ get_clocks { lpddr2if0|*|pll_afi_clk } ]

# I/O 

# MII constraints for 100 Mbit Ethernet
#  RX 10 ns setup & 10 ns hold
#  TX 0-25 ns delay from tx_clk
#  CRS/COL are asynchronous
#  MDIO mac->phy 10 ns setup & 10 ns hold (guaranteed by design)
#  MDIO phy->mac 0-300 ns delay i.e. 700 ns margin, no need to constrain

foreach eif { eneta enetb } {
    set_input_delay -min -clock ${eif}_rx_clk 10.0 [get_ports [list ${eif}_rx_d* ${eif}_rx_er] ]
    set_input_delay -max -clock ${eif}_rx_clk 30.0 [get_ports [list ${eif}_rx_d* ${eif}_rx_er] ] 
    set_output_delay -min -clock ${eif}_tx_clk 0.0 [get_ports [list ${eif}_tx_en ${eif}_tx_d* ${eif}_tx_er] ]
    set_output_delay -max -clock ${eif}_tx_clk 15.0 [get_ports [list ${eif}_tx_en ${eif}_tx_d* ${eif}_tx_er] ]
    set_false_path -to [ get_ports [list ${eif}_rx_crs ${eif}_rx_col] ]
    set_false_path -from [list ${eif}_mdio ${eif}_mdc]
    set_max_delay -to ${eif}_mdio 100.0
}

# Timing ignored
set_false_path -from cpu_resetn -to $ahbclks
set_false_path -from { user_dipsw dip_3p3V user_pb header_p header_n header_d }
set_false_path -to { user_led overtemp_fpga }


# Internal 


constrain_cdc $ahbclks 11.0 $aficlk1 6.0
constrain_cdc $ahbclks 11.0 $aficlk2 6.0
constrain_cdc $ahbclks 11.0 eneta_tx_clk 40.0
constrain_cdc $ahbclks 11.0 eneta_rx_clk 40.0
constrain_cdc $ahbclks 11.0 enetb_tx_clk 40.0
constrain_cdc $ahbclks 11.0 enetb_rx_clk 40.0

if { $sta_mode } {
    # Timing-ignore reset synchronizers inside GRETH
    set_false_path -from [ get_registers "*ethc*|r.ctrl.reset *rstgen0|rstoutl" ] -to [ get_clocks enet*_clk ]
}
