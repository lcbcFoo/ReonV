#################################################################################
### Setup Operating Conditions
#################################################################################

set_operating_conditions ff1p16v125c           -library saed32lvt_ff1p16v125c         -analysis_type on_chip_variation
set_operating_conditions ccs_ff1p16v125c_2p75v -library saed32pll_ff1p16v125c_2p75v   -analysis_type on_chip_variation -object_list [get_cells core0/clkgen0/v/pll0]
set_operating_conditions ff1p16v125c_2p75v     -library saed32io_fc_ff1p16v125c_2p75v -analysis_type on_chip_variation -object_list [get_cells pads0/*/x0/*p]
set_operating_conditions ff1p16v125c_2p75v     -library saed32io_fc_ff1p16v125c_2p75v -analysis_type on_chip_variation -object_list [get_cells pads0/*_pad/*/*p]
set_operating_conditions ff1p16v125c_2p75v     -library saed32io_fc_ff1p16v125c_2p75v -analysis_type on_chip_variation -object_list [get_cells pads0/*/*/x0/*p]

#################################################################################
### Set Wireload model for library 
#################################################################################

suppress_message OPT-170
set_wire_load_mode enclosed
set_wire_load_model -name ForQA

#################################################################################
# Define Skew, jitter, clock period etc
#################################################################################

### Typically we add 10% to the max clock frequency during synthesis to allow for
### some margins during the layout phase.
set clock_margin 0.1

### Define Clock uncertainty
# Clock uncertainty : this  consists of different parts
# - t1 : jitter of the PLL output when the clock is driven by a PLL
# - t2 : skew after clock tree synthesis.
# - t3 : extra margins for on chip variations..
# - t4 : extra jitter is to make it easier to close timing for setup/hold in layout
#
set pll_output_jitter 0.100
set clock_tree_jitter 0.300
set ocv_jitter 0.100
set extra_jitter 0.100

### Library setup Time
set tech_lib_setup 0.20
set tech_lib_hold  0.20

### Clock periodsec
set sys_clk_freq   10.0
set spw_clk_freq   40.0
set tck_clk_freq   10.0

### Define PLL Clocks [Source Name Start Freq Jitter Factor ApbClk]
set pllclocks [list \
clk clk1x core0/clkgen0/v/pll0/PLL0/CLK_1X [expr $sys_clk_freq * 1.0] 0.55 1.0 1 \
clk clk2x core0/clkgen0/v/pll0/PLL0/CLK_2X [expr $sys_clk_freq * 2.0] 0.55 2.0 0 \
clk clk4x core0/clkgen0/v/pll0/PLL0/CLK_4X [expr $sys_clk_freq * 4.0] 0.55 4.0 0 \
]

#################################################################################
# General Timing Constraints
#################################################################################

### Default load 
set default_load 5

### Default Driver
set default_driver D4I1025_NS
set default_driver_pin PADIO
set default_driver_from_pin DIN

### Max transition / Capacitance for library
#set default_max_transition   2.0
#set default_max_capacitance  2.0
