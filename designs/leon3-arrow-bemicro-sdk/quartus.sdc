# Clock constraints

create_clock -name "clk_fpga_50m" -period 20ns [get_ports {clk_fpga_50m}] -waveform {0.000ns 10.000ns}
create_clock -name "rx_clk" -period 40ns [get_ports {rx_clk}] -waveform {0.000ns 20.000ns}
create_clock -name "tx_clk" -period 40ns [get_ports {tx_clk}] -waveform {0.000ns 20.000ns}


# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

#create_generated_clock -name ahbclk -source [get_pins {clkgen0|\cyc3:v|sdclk_pll|\sden:altpll0|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 10 -divide_by 10 -master_clock {CLOCK_50} [get_pins {clkgen0|\cyc3:v|sdclk_pll|\sden:altpll0|auto_generated|pll1|clk[0]}] 
#create_generated_clock -name sdclk -source [get_pins {clkgen0|\cyc3:v|sdclk_pll|\sden:altpll0|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 10 -divide_by 10 -master_clock {CLOCK_50} [get_pins {clkgen0|\cyc3:v|sdclk_pll|\sden:altpll0|auto_generated|pll1|clk[1]}] 

set_false_path -from [get_clocks clk_fpga_50m] -to [get_clocks rx_clk]
set_false_path -from [get_clocks rx_clk] -to [get_clocks clk_fpga_50m]
set_false_path -from [get_clocks clk_fpga_50m] -to [get_clocks tx_clk]
set_false_path -from [get_clocks tx_clk] -to [get_clocks clk_fpga_50m]
set_false_path -from [get_clocks {clkgen0|\cyc3:v|sdclk_pll|\nosd:altpll0|auto_generated|pll1|clk[0]}] -to [get_clocks {tx_clk rx_clk}]
set_false_path -from [get_clocks {tx_clk}] -to  [get_clocks {clkgen0|\cyc3:v|sdclk_pll|\nosd:altpll0|auto_generated|pll1|clk[0]}]
set_false_path -from [get_clocks {rx_clk}] -to  [get_clocks {clkgen0|\cyc3:v|sdclk_pll|\nosd:altpll0|auto_generated|pll1|clk[0]}]
set_false_path -from [get_clocks {clkgen0|\cyc3:v|sdclk_pll|\nosd:altpll0|auto_generated|pll1|clk[0]}] -to [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\cyc3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]
set_false_path -from [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\cyc3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}] -to [get_clocks {clkgen0|\cyc3:v|sdclk_pll|\nosd:altpll0|auto_generated|pll1|clk[0]}]

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

# tsu/th constraints

set_input_delay -clock rx_clk 10.0 [get_ports rxd*]

# tco constraints

set_output_delay -clock tx_clk 10.0 [get_ports txd*]


# tpd constraints

