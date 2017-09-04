## Generated SDC file "leon3mp.out.sdc"

## Copyright (C) 1991-2007 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 7.2 Build 207 03/18/2008 Service Pack 3 SJ Full Version"

## DATE    "Mon Jun  9 19:07:46 2008"

##
## DEVICE  "EP3SL150F1152C2"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk}] -add
create_clock -name {clk125} -period 8.000 -waveform { 0.000 4.000 } [get_ports {clk125}] -add
create_clock -name {phy_rx_clk} -period 40.000 -waveform { 0.000 20.000 } [get_ports {phy_rx_clk}] -add
create_clock -name {phy_tx_clk} -period 40.000 -waveform { 0.000 20.000 } [get_ports {phy_tx_clk}] -add


#**************************************************************
# Create Generated Clock
#**************************************************************
#create_generated_clock -name {ddr_clk0} -source [get_nets {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|\ddrclocks:0:ddrclk_pad|clk_reg}] -master_clock {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]} -invert [get_ports {ddr_clk[0]}] -add
create_generated_clock -name {ddr_clk0} -source [get_nets {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|\ddrclocks:0:ddrclk_pad|clk_reg}] -master_clock {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]} [get_ports {ddr_clk[0]}] -add
#create_generated_clock -name {ddr_clk1} -source [get_nets {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|\ddrclocks:0:ddrclk_pad|clk_reg}] -master_clock {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]} [get_ports {ddr_clk[1]}] -add
#create_generated_clock -name {ddr_clk2} -source [get_nets {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|\ddrclocks:0:ddrclk_pad|clk_reg}] -master_clock {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]} [get_ports {ddr_clk[2]}] -add


#create_generated_clock -name {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 6 -divide_by 5 -master_clock {clk125} [get_pins {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}] -add
#create_generated_clock -name {clk0} -source [get_nets {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|wire_pll1_clk[0]}] -master_clock {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]} -add
derive_pll_clocks


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************
set_input_delay -add_delay  -clock [get_clocks {phy_rx_clk}] 10.000 [get_ports {*}]
set_input_delay -add_delay  -clock [get_clocks {phy_tx_clk}] 10.000 [get_ports {*}]



#**************************************************************
# Set Output Delay
#**************************************************************
set_output_delay -add_delay  -clock [get_clocks {phy_tx_clk}] 20.000 [get_ports {*}]

set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_casb}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_casb}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_rasb}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_rasb}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_web}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_web}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_odt[0]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_odt[0]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_odt[1]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_odt[1]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_cke[0]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_cke[0]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_cke[1]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_cke[1]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_csb[0]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_csb[0]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_csb[1]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_csb[1]}]

set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ba[0]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ba[0]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ba[1]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ba[1]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ba[2]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ba[2]}]

set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[0]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[0]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[1]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[1]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[2]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[2]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[3]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[3]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[4]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[4]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[5]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[5]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[6]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[6]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[7]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[7]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[8]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[8]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[9]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[9]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[10]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[10]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[11]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[11]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[12]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[12]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[13]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[13]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[14]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[14]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -max 0.620 [get_ports {ddr_ad[15]}]
set_output_delay -add_delay  -clock [get_clocks {ddr_clk0}] -min -0.620 [get_ports {ddr_ad[15]}]

set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[0]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[1]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[2]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[3]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[4]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[5]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[6]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[7]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[8]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[9]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[10]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[11]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[12]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[13]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[14]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[15]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[16]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[17]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[18]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[19]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[20]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[21]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[22]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[23]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[24]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[25]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[26]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[27]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[28]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[29]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[30]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[31]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[32]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[33]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[34]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[35]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[36]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[37]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[38]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[39]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[40]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[41]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[42]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[43]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[44]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[45]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[46]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[47]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[48]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[49]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[50]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[51]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[52]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[53]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[54]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[55]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[56]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[57]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[58]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[59]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[60]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[61]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[62]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dq[63]}]

set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dm[0]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dm[1]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dm[2]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dm[3]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dm[4]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dm[5]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dm[6]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_dm[7]}]

set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsp[0]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsp[1]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsp[2]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsp[3]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsp[4]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsp[5]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsp[6]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsp[7]}]

set_output_delay -add_delay  -clock_fall -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsn[0]}]
set_output_delay -add_delay  -clock_fall -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsn[1]}]
set_output_delay -add_delay  -clock_fall -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsn[2]}]
set_output_delay -add_delay  -clock_fall -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsn[3]}]
set_output_delay -add_delay  -clock_fall -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsn[4]}]
set_output_delay -add_delay  -clock_fall -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsn[5]}]
set_output_delay -add_delay  -clock_fall -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsn[6]}]
set_output_delay -add_delay  -clock_fall -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[1]}]  0.600 [get_ports {ddr_dqsn[7]}]

set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_clk[0]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_clk[1]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_clk[2]}]

set_output_delay -add_delay  -clock_fall -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_clk[0]}]
set_output_delay -add_delay  -clock_fall -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_clk[1]}]
set_output_delay -add_delay  -clock_fall -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_clk[2]}]

set_output_delay -add_delay  -clock_fall -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_clkb[0]}]
set_output_delay -add_delay  -clock_fall -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_clkb[1]}]
set_output_delay -add_delay  -clock_fall -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.600 [get_ports {ddr_clkb[2]}]

set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_cke[0]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_cke[1]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_csb[0]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_csb[1]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_odt[0]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_odt[1]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_web}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_rasb}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_casb}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[0]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[1]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[2]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[3]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[4]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[5]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[6]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[7]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[8]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[9]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[10]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[11]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[12]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[13]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[14]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ad[15]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ba[0]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ba[1]}]
set_output_delay -add_delay  -clock [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]  0.620 [get_ports {ddr_ba[2]}]


#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -exclusive -group [get_clocks {clk}] 
set_clock_groups -exclusive -group [get_clocks {clk125}] 
set_clock_groups -exclusive -group [get_clocks {phy_rx_clk}] 
set_clock_groups -exclusive -group [get_clocks {phy_tx_clk}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path  -from  [get_clocks {clk125}]  -to  [get_clocks {\ddrsp0:ddrc0|ddr_phy0|ddr_phy0|\stra3:ddr_phy0|pll0|altpll_component|auto_generated|pll1|clk[0]}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************

