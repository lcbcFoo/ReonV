## Generated SDC file "s5_golden_top.out.sdc"

## Copyright (C) 1991-2011 Altera Corporation
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
## VERSION "Version 11.1 Internal Build 141d 09/06/2011 SJ Full Version"

## DATE    "Mon Sep 26 13:37:35 2011"

##
## DEVICE  "5SGXEA7K2F40C2ES"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -period "40.000 ns" -name {altera_reserved_tck} {altera_reserved_tck}

#JTAG Signal Constraints
#constrain the TDI TMS and TDO ports  -- (modified from timequest SDC cookbook)
set_input_delay  -clock altera_reserved_tck 5 [get_ports altera_reserved_tdi]
set_input_delay  -clock altera_reserved_tck 5 [get_ports altera_reserved_tms]
set_output_delay -clock altera_reserved_tck -clock_fall -fall -max 5 [get_ports altera_reserved_tdo]

create_clock -name {clkin_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports { clkin_50 }]
create_clock -name {clk_125_p} -period 8.000 -waveform { 0.000 4.000 } [get_ports { clk_125_p }]
create_clock -name {clkintop_p[0]} -period 10.000 -waveform { 0.000 5.000 } [get_ports { clkintop_p[0] }]
create_clock -name {clkintop_p[1]} -period 8.000 -waveform { 0.000 4.000 } [get_ports { clkintop_p[1] }]
create_clock -name {clkinbot_p[1]} -period 8.000 -waveform { 0.000 4.000 } [get_ports { clkinbot_p[1] }]

#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



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

