#************************************************************
# THIS IS A WIZARD-GENERATED FILE.                           
#
# Version 10.0 Build 262 08/18/2010 Service Pack 1 SJ Full Version
#
#************************************************************

# Copyright (C) 1991-2010 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.



# Clock constraints

create_clock -name "CLOCK_50" -period 20ns [get_ports {CLOCK_50}] -waveform {0.000ns 10.000ns}
create_clock -name "ENET0_RX_CLK" -period 40ns [get_ports {ENET0_RX_CLK}] -waveform {0.000ns 20.000ns}
create_clock -name "ENET0_TX_CLK" -period 40ns [get_ports {ENET0_TX_CLK}] -waveform {0.000ns 25.000ns}
create_clock -name "ENET0_GTX_CLK" -period 8ns [get_ports {ENET0_GTX_CLK}] -waveform {0.000ns 4.000ns}



# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

#create_generated_clock -name ahbclk -source [get_pins {clkgen0|\cyc3:v|sdclk_pll|\sden:altpll0|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 13 -divide_by 10 -master_clock {CLOCK_50} [get_pins {clkgen0|\cyc3:v|sdclk_pll|\sden:altpll0|auto_generated|pll1|clk[0]}] 
#create_generated_clock -name sdclk -source [get_pins {clkgen0|\cyc3:v|sdclk_pll|\sden:altpll0|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 13 -divide_by 10 -master_clock {CLOCK_50} [get_pins {clkgen0|\cyc3:v|sdclk_pll|\sden:altpll0|auto_generated|pll1|clk[1]}] 

set_false_path -from [get_clocks CLOCK_50] -to [get_clocks ENET0_RX_CLK]
set_false_path -from [get_clocks ENET0_RX_CLK] -to [get_clocks CLOCK_50]
set_false_path -from [get_clocks CLOCK_50] -to [get_clocks ENET0_TX_CLK]
set_false_path -from [get_clocks ENET0_TX_CLK] -to [get_clocks CLOCK_50]
set_false_path -from [get_clocks {clkgen0|\cyc3:v|sdclk_pll|\sden:altpll0|auto_generated|pll1|clk[0]}] -to [get_clocks {ENET0_TX_CLK ENET0_RX_CLK}]
set_false_path -from [get_clocks {ENET0_TX_CLK}] -to  [get_clocks {clkgen0|\cyc3:v|sdclk_pll|\sden:altpll0|auto_generated|pll1|clk[0]}]
set_false_path -from [get_clocks {ENET0_RX_CLK}] -to  [get_clocks {clkgen0|\cyc3:v|sdclk_pll|\sden:altpll0|auto_generated|pll1|clk[0]}]

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

# tsu/th constraints

set_input_delay -clock CLOCK_50 2.0 [get_ports dram_dq*]
set_input_delay -clock ENET0_RX_CLK 10.0 [get_ports enet0_rx_*]

# tco constraints

set_output_delay -clock CLOCK_50 6.0 [get_ports dram_*]
set_output_delay -clock ENET0_TX_CLK 10.0 [get_ports enet0_tx_*]


# tpd constraints

