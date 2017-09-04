## Generated SDC file "leon3mp_quartus.sdc"

## Copyright (C) 1991-2013 Altera Corporation
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
## VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Full Version"

## DATE    "Tue Jan 27 14:29:03 2015"

##
## DEVICE  "5CSXFC6D6F31C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3


#**************************************************************
# Create Clock
#**************************************************************

create_clock -period 20 [get_ports OSC_50_B3B]
create_clock -period 20 [get_ports OSC_50_B4A]
create_clock -period 20 [get_ports OSC_50_B5B]
create_clock -period 20 [get_ports OSC_50_B8A]


#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks


#**************************************************************
# Set Clock Latency
#**************************************************************


#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

#set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.100  
#set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -hold 0.060  
#set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.100  
#set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -hold 0.060  
#set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.100  
#set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -hold 0.060  
#set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.100  
#set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -hold 0.060  
#set_clock_uncertainty -rise_from [get_clocks {main_clk}] -rise_to [get_clocks {main_clk}] -setup 0.070  
#set_clock_uncertainty -rise_from [get_clocks {main_clk}] -rise_to [get_clocks {main_clk}] -hold 0.060  
#set_clock_uncertainty -rise_from [get_clocks {main_clk}] -fall_to [get_clocks {main_clk}] -setup 0.070  
#set_clock_uncertainty -rise_from [get_clocks {main_clk}] -fall_to [get_clocks {main_clk}] -hold 0.060  
#set_clock_uncertainty -fall_from [get_clocks {main_clk}] -rise_to [get_clocks {main_clk}] -setup 0.070  
#set_clock_uncertainty -fall_from [get_clocks {main_clk}] -rise_to [get_clocks {main_clk}] -hold 0.060  
#set_clock_uncertainty -fall_from [get_clocks {main_clk}] -fall_to [get_clocks {main_clk}] -setup 0.070  
#set_clock_uncertainty -fall_from [get_clocks {main_clk}] -fall_to [get_clocks {main_clk}] -hold 0.060  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

#set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
#set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


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

