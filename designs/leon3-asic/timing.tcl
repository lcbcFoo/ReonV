#################################################################################
# Leon3-Asic Timing scripts
#
# This file generates constraints for:
#
# 1. Timing setup for spacewirerouter asic
#      Set default values to parameters
# 2. Define Skew, jitter, clock period etc
# 3. Define and set clocks in design
# 4. Set Max and Min delay between clock domains
# 5. Define false paths in design
# 6. Setup and apply load to timing critical interface
# 7. Constrain Input/output paths
# 8. General Timing Constraints
#      Sets the maximum transition time for the specified clocks, ports etc
#
#################################################################################

#################################################################################
# Timing setup for Leon3 ASIC Ref Design
#################################################################################

# Select to use scan mode
if { ![info exists use_scan_clk] } {
  echo "Info: Normal Functional mode clocks"
  set use_scan_clk 0
} else {
  echo "Info: Scan mode clocks"
}

# Select to propagate clocks or not in the system
if { ![info exists use_prop_clk] } {
  echo "Info: Using Ideal clocks"
  set use_prop_clk 0
}

# Select how to setup false paths for constant IOs
if { ![info exists use_virt_clock_for_false_io] } {
  echo "Info: Using Vitrual Clocks for static inputs and outputs"
  set use_virt_clock_for_false_io 0
}

# Only set max delay for CDC qualifier 
if { ![info exists use_cdc_qualifer_cdc_only] } {
  echo "Info: Only adding max delay for cdc qualifer"
  set use_cdc_qualifer_cdc_only 0
}

# Select to ignore io timing (only use for debug and area)
if { ![info exists ignore_io_timing] } {
  set ignore_io_timing 0
} else {
  if { $ignore_io_timing == 1 } {
    echo "Warning: No IO Constraints set for the design"
  }
}

#################################################################################
# Define Skew, jitter, clock period etc
#################################################################################

# These valuse should normally be set in the Tech Setup/Timing files

### Typically we add 10% to the max clock frequency during synthesis to allow for
### some margins during the layout phase.
if { ![info exists clock_margin] } {
  set clock_margin 0.1
}
echo "Info: Clock freq margin set to [ expr ${clock_margin} * 100] % of the max clock period"

### Define Clock uncertainty
# Clock uncertainty : this  consists of different parts
# - t1 : jitter of the PLL output when the clock is driven by a PLL
# - t2 : skew after clock tree synthesis.
# - t3 : extra margins for on chip variations..
# - t4 : extra jitter is to make it easier to close timing for setup/hold in layout
#
if { ![info exists clock_tree_jitter] } {
  set pll_output_jitter 0.100
  set clock_tree_jitter 0.300
  set ocv_jitter 0.100
  set extra_jitter 0.100
}
echo "Info: PLL output jitter ${pll_output_jitter} ns"
echo "Info: Clock tree jitter ${clock_tree_jitter} ns"
echo "Info: OCV jitter ${ocv_jitter} ns"
echo "Info: Extra setup/hold margin jitter ${extra_jitter} ns"

### Library setup Time
if { ![info exists tech_lib_setup] } {
  set tech_lib_setup 0.20
  set tech_lib_hold  0.20
}
echo "Info: Tech lib setup ${tech_lib_setup} ns"
echo "Info: Tech lib hold ${tech_lib_hold} ns"

### Clock periodsec
if { ![info exists sys_clk_freq] } {
  set sys_clk_freq 25.0
}
echo "Info: CLK freq is set to ${sys_clk_freq} MHz"

if { ![info exists spw_clk_freq] } {
  set spw_clk_freq 100.0
}
echo "Info: SPWCLK freq is set to ${spw_clk_freq} MHz"

if { ![info exists tck_clk_freq] } {
  set tck_clk_freq 10.0
}
echo "Info: JTAG TCK freq is set to ${tck_clk_freq} MHz"

set sys_in_peri [expr 1000.0 / $sys_clk_freq]
set spw_in_peri [expr 1000.0 / $spw_clk_freq]
set tck_in_peri [expr 1000.0 / $tck_clk_freq]

set sys_peri [expr $sys_in_peri - $sys_in_peri*$clock_margin]
set spw_peri [expr $spw_in_peri - $spw_in_peri*$clock_margin]
set tck_peri [expr $tck_in_peri - $tck_in_peri*$clock_margin]

if { ![info exists pllclocks] } {
 if { $fpga_techlib == 0} { 
   echo "ERROR: PLL Clocks are not defined in Tech Scripts"
   exit
 } else {
   echo "Warning: PLL Clocks are not assumed to propagate automatically for FPGA"
 }
} else {
 if { [info exists _pllclocks] } {unset _pllclocks}
 foreach {_Source _Name _start _freq _jitter _Factor _ApbClk} $pllclocks {
  echo "Info: Create generate PLL clock ${_Name} from source ${_Source} at ${_start} with ${_freq} MHz and Duty Cycle jitter ${_jitter} %"
  set _peri [expr [expr 1000.0 / $_freq] - [expr 1000.0 / $_freq]*$clock_margin]
  set _dutycycle [expr ${_peri} * ${_jitter}]
  lappend _pllclocks $_Source $_Name $_start $_freq $_jitter $_peri $_dutycycle $_Factor $_ApbClk
 }
}

#################################################################################
# Define and set clocks in design
#
# Add '-add' tp create_clock and set '' timing_enable_multiple_clocks_per_reg' to enable
# analysis of multiple clocks that reach a single register.
#################################################################################

# External clocks
create_clock -name "clk"    -period $sys_peri {"clk"}
if { $use_scan_clk == 0 } {
   create_clock -name "tck"    -period $tck_peri {"tck" }
   create_clock -name "spwclk" -period $spw_peri {"spw_clk"}
}

# Internal generated clocks
if { $use_scan_clk == 0 } {

   # Use multiple clock analysis
   set_app_var timing_enable_multiple_clocks_per_reg true

   # Define clocks
   foreach {_Source _Name _start _freq _jitter _peri _dutycycle _Factor _ApbClk} $_pllclocks {
     create_clock -add -name ${_Name} -period ${_peri} -waveform " 0 ${_dutycycle} " [get_pins ${_start}]
   }

   # False Path from lock signals (Generic paths for all GRLIB clkgen blocks)
   set_false_path -through [get_pins core0/clkgen0/cgo*]
}

# Don't modify clock trees unless we use propagated clocks
if {$use_prop_clk == 0} then {
   set_dont_touch_network [get_clocks *]
}

# Define all clocks as Ideal (Will also define all gated clocks as Ideal)
# TODO: Must fix ideal clocks from PLL
if {$use_prop_clk == 0} then {

   # Ideal network from all clock start
   set_ideal_network clk
   if { $use_scan_clk == 0} then {
     set_ideal_network tck
     set_ideal_network spw_clk
     foreach {_Source _Name _start _freq _jitter _peri _dutycycle _Factor _ApbClk} $_pllclocks {
       set_ideal_network [get_pins ${_start}]
     }

     # Ideal clock network from all clock gates
     proc get_icg_gate_out_pins { {cells ""} } {
         if { [sizeof_collection $cells] < 1 } { 
             set cells [get_cells * -hier]
         }
         
         set pins "" 
         foreach lib_name  [get_attribute [get_libs ] name] {
             # get the names of the ICG cells in library $lib_name
             set ICG_REFS  [get_lib_cells $lib_name/* -filter \
                                "defined(clock_gating_integrated_cell)"]
             foreach_in_collection lib_cell $ICG_REFS { 
                 lappend FULL_REF_NAME [get_object_name $lib_cell]
             }
         }
         # get the clock pin names of the ICGs & assemble collection
         foreach i $FULL_REF_NAME {
             set CLKPIN_NAME [get_attribute [get_lib_pins $i/* \
              -filter "defined(clock_gate_out_pin)"] name ]
             set REF_NAME [get_attribute $i name]
             set cell_insts [filter $cells "ref_name == $REF_NAME"]
             if { [sizeof_collection $cell_insts] > 0 } {
                 foreach i [get_object_name $cell_insts] {
                     set pins [add_to_coll $pins [get_pins -quiet $i/$CLKPIN_NAME]]
                 }
             }
         }
         return $pins
     }
     if { ![catch get_icg_gate_out_pins] } {
      set _collection [get_icg_gate_out_pins]
      foreach_in_collection _clockgate $_collection {
        set _output [get_object_name $_clockgate]
        #echo "$_output"
        set_ideal_network [get_pins $_output]
      }
     } else {
      echo "Info: No User inferred clock gates found in design"
     }
   }

   # Ideal clock network after all clock muxes in the system
   set_ideal_network [get_pins -filter "pin_direction==out" core0/core_clock_mux/*/*/*/*]

   # When using ideal clocks, set the clock transition time to 0 before analyzing the power of your design
   set_clock_transition 0.0 [all_clocks]
}

### Define Clock uncertainty
set_clock_uncertainty [expr $clock_tree_jitter + $ocv_jitter + $extra_jitter] [get_clocks clk]
if { $use_scan_clk == 1} then {
 foreach {_Source _Name _start _freq _jitter _peri _dutycycle _Factor _ApbClk} $_pllclocks {
   set_clock_uncertainty [expr $pll_output_jitter + $clock_tree_jitter + $ocv_jitter + $extra_jitter] [get_clocks ${_Name} ]
 }
 set_clock_uncertainty [expr $clock_tree_jitter + $ocv_jitter + $extra_jitter] [get_clocks spw_clk]
 set_clock_uncertainty [expr $clock_tree_jitter + $ocv_jitter + $extra_jitter] [get_clocks tck]
}

### No cross-talk between spacewire clocks since they do not co-exists
if { $use_scan_clk == 0 } {
 suppress_message TIM-196
 foreach {_Source _Name _start _freq _jitter _Factor _ApbClk} $pllclocks {
  # To Source
  set_clock_groups -logically_exclusive -group ${_Source} -group ${_Name}
  # To all Generated Clocks
  foreach {__Source __Name __Start __Freq __Jitter __Factor __ApbClk} $pllclocks {
   if { ![string compare ${_Name} ${__Name}] == 0 } { 
    if {${_ApbClk} == 0 && ${__ApbClk} == 0} {
     set_clock_groups -logically_exclusive -group ${_Name} -group ${__Name}
    }
    set_false_path -from [get_clocks ${_Name}] -through [get_ports *] -to [get_clocks ${__Name}]
   }
  }
 }
}

### Create false paths between clock domain groups
if { $use_scan_clk == 0 } {
 # E.g set_clock_groups -asynchronous -group {clk} -group {spwclk} -group {tck}
}

#################################################################################
# Set Max and Min delay between clock domains
#################################################################################

# TODO: Create a script for only setting max/min for CDC qualifier

if { $use_scan_clk == 0 } {
 if { $use_cdc_qualifer_cdc_only == 0 } {
  set_max_delay -from [get_clocks clk    ] -to [get_clocks tck    ] [expr $sys_peri]
  set_max_delay -from [get_clocks tck    ] -to [get_clocks clk    ] [expr $sys_peri]
  set_min_delay -from [get_clocks clk    ] -to [get_clocks tck    ] 0
  set_min_delay -from [get_clocks tck    ] -to [get_clocks clk    ] 0

  set_max_delay -from [get_clocks spwclk ] -to [get_clocks clk    ] [expr $spw_peri  ]
  set_max_delay -from [get_clocks clk    ] -to [get_clocks spwclk ] [expr $spw_peri  ]
  set_min_delay -from [get_clocks spwclk ] -to [get_clocks clk    ] 0
  set_min_delay -from [get_clocks clk    ] -to [get_clocks spwclk ] 0

  set_max_delay -from [get_clocks spwclk ] -to [get_clocks tck    ] [expr $spw_peri  ]
  set_max_delay -from [get_clocks tck    ] -to [get_clocks spwclk ] [expr $spw_peri  ]
  set_min_delay -from [get_clocks spwclk ] -to [get_clocks tck    ] 0
  set_min_delay -from [get_clocks tck    ] -to [get_clocks spwclk ] 0
  
  foreach {_Source _Name _start _freq _jitter _peri _dutycycle _Factor _ApbClk} $_pllclocks {
    set_max_delay -from [get_clocks ${_Name}  ] -to [get_clocks tck       ] ${_peri}
    set_max_delay -from [get_clocks tck       ] -to [get_clocks ${_Name}  ] ${_peri}
    set_min_delay -from [get_clocks ${_Name}  ] -to [get_clocks tck       ] 0
    set_min_delay -from [get_clocks tck       ] -to [get_clocks ${_Name}  ] 0

    set_max_delay -from [get_clocks ${_Name}  ] -to [get_clocks spwclk    ] $spw_peri
    set_max_delay -from [get_clocks spwclk    ] -to [get_clocks ${_Name}  ] $spw_peri
    set_min_delay -from [get_clocks ${_Name}  ] -to [get_clocks spwclk    ] 0
    set_min_delay -from [get_clocks spwclk    ] -to [get_clocks ${_Name}  ] 0

    set_max_delay -from [get_clocks ${_Name}  ] -to [get_clocks clk       ] ${_peri}
    set_max_delay -from [get_clocks clk       ] -to [get_clocks ${_Name}  ] ${_peri}
    set_min_delay -from [get_clocks ${_Name}  ] -to [get_clocks clk       ] 0
    set_min_delay -from [get_clocks clk       ] -to [get_clocks ${_Name}  ] 0
  }
 } else {
#  set all_reg [get_object_name [all_registers]]
#  #set all_reg [filter_collection [get_cells -hier *] is_a_generic_seq==true]
#  foreach _reg  $all_reg {
#   set _reg_data_pin [get_object_name [all_registers -data_pins [get_cells $_reg]]]
#   set _fanIn [all_fanin -only_cells -startpoints_only -flat -to $_reg_data_pin]
#   #echo "----> ${_reg_data_pin} ${_fanIn} [llength [get_object_name $_fanIn]]"
#   if { [llength [get_object_name $_fanIn]] != 1 } { continue }
#   set _clk1 [get_attribute [get_timing_path -to $_reg_data_pin] startpoint_clock]
#   set _clk2 [get_attribute [get_timing_path -to $_reg_data_pin] endpoint_clock]
#   if { [llength [get_object_name $_clk1]] == 0 } { continue  }
#   if { [llength [get_object_name $_clk2]] == 0 } { continue  }
#   
#   set maxdelay [get_attribute [get_clocks spwclk] PERIOD]
#   
#   echo "$_reg"
#   echo "$_reg_data_pin"
#   echo "[get_object_name $_fanIn]"
#   echo "[get_object_name $_clk1]"
#   echo "[get_object_name $_clk2]"
#   
#  }
#  
 }
}

#################################################################################
# Define false paths in design
#################################################################################

# Always ignore power supply pins
# N/A

# Create false paths from/to static or slow freq toggling signals
set tig_inputs [list \
   [get_ports resetn] \
   [get_ports testen] \
   [get_ports trst] \
   [get_ports clksel] \
   [get_ports spw_clksel] \
   [get_ports prom32]]

set tig_ouputs [list \
   [get_ports lock]]

if {$use_virt_clock_for_false_io  == 0} then {

  foreach _tig_inputs $tig_inputs {
    set_false_path -from $_tig_inputs
  }

  foreach _tig_ouputs $tig_ouputs {
    set_false_path -to $_tig_ouputs
  }

} else {

   echo "Info: Virtual clock for the I/O constraints of static signals are used"

   ## Virtual clock for the I/O constraints
   suppress_message UITE-121
   suppress_message UITE-316
   create_clock -period [expr $sys_peri * 100] -name VIR_CLOCK

   set_input_delay [expr $sys_peri * 100 / 2]   -max -clock VIR_CLOCK [get_ports $tig_inputs]
   set_input_delay [expr $sys_peri * 100 / 2]   -min -clock VIR_CLOCK [get_ports $tig_inputs]

   set_output_delay [expr $sys_peri * 100 / 2] -max -clock VIR_CLOCK [get_ports $tig_ouputs]
   set_output_delay [expr $sys_peri * 100 / 2] -min -clock VIR_CLOCK [get_ports $tig_ouputs]

   # False Paths for all clock paths
   set_false_path -from [get_clocks VIR_CLOCK] -to [get_clocks]
}

### Disable check for reset generated in system clock region in the SPW clock region

### Disable timing from SW reset register to SPW Clock domain

### SCAN False Paths
# Note: Section moved to dc.tcl scripts

### NAND Tree False Paths

### RingOsc False Paths

### BSCAN False Paths

##############################################################################
# Setup and apply load to timing critical interface
#################################################################################

### Define load for outputs
if { ![info exists default_load] } {
  set default_load 5
  echo "Warning: Default load is set to ${default_load} pf due to no driver is selected for Tech Lib"
} else {
  echo "Info: Default load is set to ${default_load} pf"
  set_load $default_load [all_outputs]
}

### Define Driving cells
if { ![info exists default_driver] } then {
  echo "Warning: No default driver is selected for tech library"
} else {
  echo "Info: Default Driver is set to ${default_driver}"
  set _default_inputs [remove_from_collection [all_inputs] {clk spw_clk tck}]
  set_driving_cell -no_design_rule -lib_cell ${default_driver} -pin ${default_driver_pin} -from_pin ${default_driver_from_pin} [get_ports $_default_inputs]
}
#################################################################################
# Constrain Input/output paths
#################################################################################
if { $ignore_io_timing == 0 } {
 ### Spacewrire
 set spw_tech_lib_setup $tech_lib_setup
 set spw_tech_lib_hold  $tech_lib_hold 
 
 if { $use_scan_clk == 0 } {
   set spw_rx_rise_max [expr $spw_peri / 4 - $spw_tech_lib_setup]
   set spw_rx_rise_min [expr                 $spw_tech_lib_hold ]
   set spw_rx_fall_max [expr $spw_peri / 4 - $spw_tech_lib_setup]
   set spw_rx_fall_min [expr                 $spw_tech_lib_hold ]
 } else {
   set spw_rx_rise_max [expr $sys_peri / 4 - $spw_tech_lib_setup]
   set spw_rx_rise_min [expr                 $spw_tech_lib_hold ]
   set spw_rx_fall_max [expr $sys_peri / 4 - $spw_tech_lib_setup]
   set spw_rx_fall_min [expr                 $spw_tech_lib_hold ]
 }
 
 set spw_tx_max [expr      $spw_tech_lib_setup]
 set spw_tx_min [expr -1 * $spw_tech_lib_hold ]
 
 
 # CMOS Outtputs will get a full clock cycle inside chip @ max spwclk period
 if { $use_scan_clk == 0 } {
   set_input_delay  -clock [get_clocks spwclk] -max  $spw_rx_rise_max [get_ports spw_rxd*]
   set_input_delay  -clock [get_clocks spwclk] -min  $spw_rx_rise_min [get_ports spw_rxd*] -add
   set_input_delay  -clock [get_clocks spwclk] -max  $spw_rx_fall_max [get_ports spw_rxd*] -add -clock_fall
   set_input_delay  -clock [get_clocks spwclk] -min  $spw_rx_fall_min [get_ports spw_rxd*] -add -clock_fall
   
   set_input_delay  -clock [get_clocks spwclk] -max $spw_rx_rise_max [get_ports spw_rxs*]
   set_input_delay  -clock [get_clocks spwclk] -min $spw_rx_rise_min [get_ports spw_rxs*] -add
   set_input_delay  -clock [get_clocks spwclk] -max $spw_rx_fall_max [get_ports spw_rxs*] -add -clock_fall
   set_input_delay  -clock [get_clocks spwclk] -min $spw_rx_fall_min [get_ports spw_rxs*] -add -clock_fall
   
   set_output_delay -clock [get_clocks spwclk] -max $spw_tx_max [get_ports spw_txd*]
   set_output_delay -clock [get_clocks spwclk] -min $spw_tx_min [get_ports spw_txd*] -add_delay
   
   set_output_delay -clock [get_clocks spwclk] -max $spw_tx_max [get_ports spw_txs*]
   set_output_delay -clock [get_clocks spwclk] -min $spw_tx_min [get_ports spw_txs*] -add_delay
 
   # Specify Skew for each ot the SPW Interfaces (+/-200ps)
   # TODO: Should be per SpW Port and NOT for all PORT
   # IN PINS
   #set pin_skew [all_registers -data_pins [filter [all_fanout -flat -only_cells -endpoints_only -from [get_ports spw_rx*]] "is_sequential == true"]] 
   set pin_skew [filter [all_fanout -flat -only_cells -endpoints_only -from [get_ports spw_rx*]] "is_sequential == true"]
   foreach_in_collection _pin_skew $pin_skew {
    foreach_in_collection __pin_skew $pin_skew {
       if {[string compare $_pin_skew $__pin_skew] == 0} {
         set_data_check -from $_pin_skew -to $__pin_skew -setup -0.2
         set_data_check -from $_pin_skew -to $__pin_skew -hold  -0.2
       }
    }
   }
 
   # OUT PINS
   #set pin_skew [all_registers -data_pins [filter [all_fanin -flat -only_cells -startpoints_only -to [get_ports spw_tx*]] "is_sequential == true"]]
   set pin_skew [filter [all_fanin -flat -only_cells -startpoints_only -to [get_ports spw_tx*]] "is_sequential == true"]
   foreach_in_collection _pin_skew $pin_skew {
    foreach_in_collection __pin_skew $pin_skew {
       if {[string compare $_pin_skew $__pin_skew] == 0} {
         set_data_check -from $_pin_skew -to $__pin_skew -setup -0.2
         set_data_check -from $_pin_skew -to $__pin_skew -hold  -0.2
       }
    }
   }
 
 } else {
   set_input_delay  -clock [get_clocks clk] -max  $spw_rx_rise_max [get_ports spw_rxd*]
   set_input_delay  -clock [get_clocks clk] -min  $spw_rx_rise_min [get_ports spw_rxd*] -add
   set_input_delay  -clock [get_clocks clk] -max  $spw_rx_fall_max [get_ports spw_rxd*] -add -clock_fall
   set_input_delay  -clock [get_clocks clk] -min  $spw_rx_fall_min [get_ports spw_rxd*] -add -clock_fall
   
   set_input_delay  -clock [get_clocks clk] -max $spw_rx_rise_max [get_ports spw_rxs*]
   set_input_delay  -clock [get_clocks clk] -min $spw_rx_rise_min [get_ports spw_rxs*] -add
   set_input_delay  -clock [get_clocks clk] -max $spw_rx_fall_max [get_ports spw_rxs*] -add -clock_fall
   set_input_delay  -clock [get_clocks clk] -min $spw_rx_fall_min [get_ports spw_rxs*] -add -clock_fall
   
   set_output_delay -clock [get_clocks clk] -max $spw_tx_max [get_ports spw_txd*]
   set_output_delay -clock [get_clocks clk] -min $spw_tx_min [get_ports spw_txd*] -add_delay
   
   set_output_delay -clock [get_clocks clk] -max $spw_tx_max [get_ports spw_txs*]
   set_output_delay -clock [get_clocks clk] -min $spw_tx_min [get_ports spw_txs*] -add_delay
 
 }
 
 ### Debug JTAG
 if { $use_scan_clk == 0 } {
   # TDI to TCK clock domain
   set_input_delay  -clock [get_clocks tck] -min [expr $tech_lib_hold]                [get_ports tdi] -add_delay
   set_input_delay  -clock [get_clocks tck] -max [expr $tck_peri/2 - $tech_lib_setup] [get_ports tdi] -add_delay
 
   set_input_delay  -clock [get_clocks tck] -min $tech_lib_hold                        [get_ports tms]
   set_input_delay  -clock [get_clocks tck] -max [expr $tck_peri/2 - $tech_lib_setup]  [get_ports tms] -add_delay
 
   set_output_delay -clock [get_clocks tck] -max [expr $tck_peri/4 + $tech_lib_setup]  [get_ports tdo] -fall
   set_output_delay -clock [get_clocks tck] -min [expr -1 * $tech_lib_hold]            [get_ports tdo] -add_delay
 
 } else {
   # TDI to scan clock domain
   set_input_delay  -clock [get_clocks clk] -min [expr $tech_lib_hold]                 [get_ports tdi] -add_delay
   set_input_delay  -clock [get_clocks clk] -max [expr $sys_peri/2 - $tech_lib_setup]  [get_ports tdi] -add_delay
 
   set_input_delay  -clock [get_clocks clk] -min $tech_lib_hold                        [get_ports tms]
   set_input_delay  -clock [get_clocks clk] -max [expr $sys_peri/2 - $tech_lib_setup]  [get_ports tms] -add_delay
 
   set_output_delay -clock [get_clocks clk] -max [expr $sys_peri/4 + $tech_lib_setup]  [get_ports tdo] -fall
   set_output_delay -clock [get_clocks clk] -min [expr -1 * $tech_lib_hold]            [get_ports tdo] -add_delay
 }
 
 ### UART
 set_input_delay  -clock [get_clocks clk] -min [expr $tech_lib_hold]                [get_ports {rxd1 rxd2}]
 set_input_delay  -clock [get_clocks clk] -max [expr $sys_peri/2 - $tech_lib_setup] [get_ports {rxd1 rxd2}] -add_delay
 set_output_delay -clock [get_clocks clk] -max [expr $sys_peri/2 + $tech_lib_setup] [get_ports {txd1 txd2}]
 set_output_delay -clock [get_clocks clk] -min [expr -1 * $tech_lib_hold]           [get_ports {txd1 txd2}] -add_delay
 
 ### I2C
 set_input_delay  -clock [get_clocks clk] -min [expr $tech_lib_hold]                [get_ports {i2c_scl i2c_sda}]
 set_input_delay  -clock [get_clocks clk] -max [expr $sys_peri/2 - $tech_lib_setup] [get_ports {i2c_scl i2c_sda}] -add_delay
 set_output_delay -clock [get_clocks clk] -max [expr $sys_peri/2 + $tech_lib_setup] [get_ports {i2c_scl i2c_sda}]
 set_output_delay -clock [get_clocks clk] -min [expr -1 * $tech_lib_hold]           [get_ports {i2c_scl i2c_sda}] -add_delay
 
 ### SPI
 set_input_delay  -clock [get_clocks clk] -min [expr $tech_lib_hold]                [get_ports spi_miso]
 set_input_delay  -clock [get_clocks clk] -max [expr $sys_peri/2 - $tech_lib_setup] [get_ports spi_miso] -add_delay
 set_output_delay -clock [get_clocks clk] -max [expr $sys_peri/2 + $tech_lib_setup] [get_ports {spi_mosi spi_sck spi_slvsel}]
 set_output_delay -clock [get_clocks clk] -min [expr -1 * $tech_lib_hold]           [get_ports {spi_mosi spi_sck spi_slvsel}] -add_delay
 
 ### GPIO
 set_input_delay  -clock [get_clocks clk] -min [expr $tech_lib_hold]                [get_ports gpio]
 set_input_delay  -clock [get_clocks clk] -max [expr $sys_peri/2 - $tech_lib_setup] [get_ports gpio] -add_delay
 set_output_delay -clock [get_clocks clk] -max [expr $sys_peri/2 + $tech_lib_setup] [get_ports gpio]
 set_output_delay -clock [get_clocks clk] -min [expr -1 * $tech_lib_hold]           [get_ports gpio] -add_delay
 
 ### DSU
 set_input_delay  -clock [get_clocks clk] -min [expr $tech_lib_hold      ]          [get_ports {dsurx dsuen dsubre}]
 set_input_delay  -clock [get_clocks clk] -max [expr $sys_peri/2 - $tech_lib_setup] [get_ports {dsurx dsuen dsubre}] -add_delay
 set_output_delay -clock [get_clocks clk] -max [expr $sys_peri/2 + $tech_lib_setup] [get_ports {dsutx dsuact}]
 set_output_delay -clock [get_clocks clk] -min [expr -1 * $tech_lib_hold]           [get_ports {dsutx dsuact}] -add_delay
 
 ### Constrain IOs for all possible clocks
 if { $use_scan_clk == 0 } {
  foreach {_Source _Name _start _freq _jitter _peri _dutycycle _Factor _ApbClk} $_pllclocks {
   if {$_ApbClk == 1} {
    ### UART
    set_input_delay  -clock [get_clocks $_Name] -min [expr $tech_lib_hold]             [get_ports {rxd1 rxd2}] -add_delay
    set_input_delay  -clock [get_clocks $_Name] -max [expr $_peri/2 - $tech_lib_setup] [get_ports {rxd1 rxd2}] -add_delay
    set_output_delay -clock [get_clocks $_Name] -max [expr $_peri/2 + $tech_lib_setup] [get_ports {txd1 txd2}] -add_delay
    set_output_delay -clock [get_clocks $_Name] -min [expr -1 * $tech_lib_hold]        [get_ports {txd1 txd2}] -add_delay
    
    ### I2C
    set_input_delay  -clock [get_clocks $_Name] -min [expr $tech_lib_hold]             [get_ports {i2c_scl i2c_sda}] -add_delay
    set_input_delay  -clock [get_clocks $_Name] -max [expr $_peri/2 - $tech_lib_setup] [get_ports {i2c_scl i2c_sda}] -add_delay
    set_output_delay -clock [get_clocks $_Name] -max [expr $_peri/2 + $tech_lib_setup] [get_ports {i2c_scl i2c_sda}] -add_delay
    set_output_delay -clock [get_clocks $_Name] -min [expr -1 * $tech_lib_hold]        [get_ports {i2c_scl i2c_sda}] -add_delay
    
    ### SPI
    set_input_delay  -clock [get_clocks $_Name] -min [expr $tech_lib_hold]             [get_ports spi_miso] -add_delay
    set_input_delay  -clock [get_clocks $_Name] -max [expr $_peri/2 - $tech_lib_setup] [get_ports spi_miso] -add_delay
    set_output_delay -clock [get_clocks $_Name] -max [expr $_peri/2 + $tech_lib_setup] [get_ports {spi_mosi spi_sck spi_slvsel}] -add_delay
    set_output_delay -clock [get_clocks $_Name] -min [expr -1 * $tech_lib_hold]        [get_ports {spi_mosi spi_sck spi_slvsel}] -add_delay
    
    ### GPIO
    set_input_delay  -clock [get_clocks $_Name] -min [expr $tech_lib_hold]             [get_ports gpio] -add_delay
    set_input_delay  -clock [get_clocks $_Name] -max [expr $_peri/2 - $tech_lib_setup] [get_ports gpio] -add_delay
    set_output_delay -clock [get_clocks $_Name] -max [expr $_peri/2 + $tech_lib_setup] [get_ports gpio] -add_delay
    set_output_delay -clock [get_clocks $_Name] -min [expr -1 * $tech_lib_hold]        [get_ports gpio] -add_delay
    
    ### DSU
    set_input_delay  -clock [get_clocks $_Name] -min [expr $tech_lib_hold      ]       [get_ports {dsurx dsuen dsubre}] -add_delay
    set_input_delay  -clock [get_clocks $_Name] -max [expr $_peri/2 - $tech_lib_setup] [get_ports {dsurx dsuen dsubre}] -add_delay
    set_output_delay -clock [get_clocks $_Name] -max [expr $_peri/2 + $tech_lib_setup] [get_ports {dsutx dsuact}] -add_delay
    set_output_delay -clock [get_clocks $_Name] -min [expr -1 * $tech_lib_hold]        [get_ports {dsutx dsuact}] -add_delay
   }
  }
 }
 
 ### PROM/SRAM/SDRAM Interface
 # Generate clock for Bypass clock
 create_generated_clock -name sdclk -source [get_ports clk] -master_clock [get_clocks clk] -multiply_by 1 -add [get_ports sdclk]
 lappend lsdclk sdclk clk
 if { $use_scan_clk == 0 } {
   # Create generated clocks for all PLL clocks
   foreach {_Source _Name _start _freq _jitter _peri _dutycycle _Factor _ApbClk} $_pllclocks {
     create_generated_clock -name sdclk_${_Name} -source [get_attribute [get_clocks ${_Name}] sources] -master_clock [get_clocks ${_Name}] -multiply_by 1 -add [get_ports sdclk]
     lappend lsdclk sdclk_${_Name} ${_Name}
   }
   # Ignore paths between generated clocks
   foreach {_Name _Master} $lsdclk {
     # To all Generated Clocks
     foreach {__Name __Master} $lsdclk {
       if { ![string compare ${_Name} ${__Name}] == 0 } { 
         set_clock_groups -logically_exclusive -group ${_Name} -group ${__Name}
         set_clock_groups -logically_exclusive -group ${_Name} -group ${__Master}
       }
     }
   }  
 }
 
 set_load [expr $default_load / 2] [get_ports sdclk]
 # Annotate proper rise/fall time for clock driver cell
 set in_pins [filter_collection [get_pins -of_object pads0/sdclk_pad/x0/op] "pin_direction == in"]
 set out_pins [filter_collection [get_pins -of_object pads0/sdclk_pad/x0/op] "pin_direction == out"]
 set inout_pins [filter_collection [get_pins -of_object pads0/sdclk_pad/x0/op] "pin_direction == inout"]
 
 if {[llength $in_pins] > 0 && [llength [concat $out_pins $inout_pins]] > 0} {
   set_annotated_delay -cell -from [get_pins $in_pins] -to [get_pins [concat $out_pins $inout_pins]] -rise 0.1
   set_annotated_delay -cell -from [get_pins $in_pins] -to [get_pins [concat $out_pins $inout_pins]] -fall 0.1
 } else {
   echo "Warning: Not able to annotate delay for SDCLK output"
 }
 
 set sdclk_peri [expr $sys_peri / 1.0]
 set_input_delay  -clock [get_clocks sdclk] -min [expr $tech_lib_hold]                  [get_ports {data cb}] -add_delay
 set_input_delay  -clock [get_clocks sdclk] -max [expr $sdclk_peri/2 - $tech_lib_setup] [get_ports {data cb}] -add_delay
 set_output_delay -clock [get_clocks sdclk] -max [expr $sdclk_peri/2 + $tech_lib_setup] [get_ports {data cb}] -add_delay
 set_output_delay -clock [get_clocks sdclk] -min [expr -1 * $tech_lib_hold]             [get_ports {data cb}] -add_delay
 
 set_output_delay -clock [get_clocks sdclk] -max [expr $sdclk_peri/2 + $tech_lib_setup] [get_ports {address sdcsn sdwen sdrasn sdcasn sddqm ramsn ramoen rwen oen writen read iosn romsn}] -add_delay
 set_output_delay -clock [get_clocks sdclk] -min [expr -1 * $tech_lib_hold]             [get_ports {address sdcsn sdwen sdrasn sdcasn sddqm ramsn ramoen rwen oen writen read iosn romsn}] -add_delay
 
 set_input_delay  -clock [get_clocks sdclk] -min [expr $tech_lib_hold      ]            [get_ports {brdyn bexcn}] -add_delay
 set_input_delay  -clock [get_clocks sdclk] -max [expr $sdclk_peri/2 - $tech_lib_setup] [get_ports {brdyn bexcn}] -add_delay
 
 # Todo: Check bus skew
 # set_data_check 
 
 if { $use_scan_clk == 0 } {
  foreach {_Source _Name _start _freq _jitter _peri _dutycycle _Factor _ApbClk} $_pllclocks {
    set sdclk_peri [expr $_peri / 1.0]
    set_input_delay  -clock [get_clocks sdclk_${_Name}] -min [expr $tech_lib_hold]                  [get_ports {data cb}] -add_delay
    set_input_delay  -clock [get_clocks sdclk_${_Name}] -max [expr $sdclk_peri/2 - $tech_lib_setup] [get_ports {data cb}] -add_delay
    set_output_delay -clock [get_clocks sdclk_${_Name}] -max [expr $sdclk_peri/2 + $tech_lib_setup] [get_ports {data cb}] -add_delay
    set_output_delay -clock [get_clocks sdclk_${_Name}] -min [expr -1 * $tech_lib_hold]             [get_ports {data cb}] -add_delay
    
    set_output_delay -clock [get_clocks sdclk_${_Name}] -max [expr $sdclk_peri/2 + $tech_lib_setup] [get_ports {address sdcsn sdwen sdrasn sdcasn sddqm ramsn ramoen rwen oen writen read iosn romsn}] -add_delay
    set_output_delay -clock [get_clocks sdclk_${_Name}] -min [expr -1 * $tech_lib_hold]             [get_ports {address sdcsn sdwen sdrasn sdcasn sddqm ramsn ramoen rwen oen writen read iosn romsn}] -add_delay
    
    set_input_delay  -clock [get_clocks sdclk_${_Name}] -min [expr $tech_lib_hold      ]            [get_ports {brdyn bexcn}] -add_delay
    set_input_delay  -clock [get_clocks sdclk_${_Name}] -max [expr $sdclk_peri/2 - $tech_lib_setup] [get_ports {brdyn bexcn}] -add_delay
 
    # Todo: Check bus skew
    # set_data_check 
 
  }
 }
 
 ### GRETH

 # Defs
 set gtx_clk_freq 125.0
 set gtx_in_peri  [expr 1000.0 / $gtx_clk_freq]
 set gtx_peri     [expr $gtx_clk_freq - $gtx_clk_freq*$clock_margin]

 # Clocks
 if { $use_scan_clk == 0 } {
    create_clock -name "gtx_clk" -period $gtx_peri {"gtx_clk"}
    create_clock -name "erx_clk" -period $gtx_peri {"erx_clk"}
    create_clock -name "etx_clk" -period $gtx_peri {"etx_clk"}

    set_input_delay  -clock [get_clocks erx_clk] -min [expr $tech_lib_hold      ]          [get_ports {erxd erx_dv erx_er erx_col erx_crs}] -add_delay
    set_input_delay  -clock [get_clocks erx_clk] -max [expr $gtx_peri/2 - $tech_lib_setup] [get_ports {erxd erx_dv erx_er erx_col erx_crs}] -add_delay

    set_output_delay -clock [get_clocks etx_clk] -max [expr $gtx_peri/2 + $tech_lib_setup] [get_ports {etxd etx_er etx_en}] -add_delay
    set_output_delay -clock [get_clocks etx_clk] -min [expr -1 * $tech_lib_hold]           [get_ports {etxd etx_er etx_en}] -add_delay
 }
  
 # MDIO

 # Generate clock for Bypass clock
 create_generated_clock -name emdc -source [get_ports clk] -master_clock [get_clocks clk] -divide_by 4 -add [get_ports emdc]
 lappend lemdc emdc clk
 if { $use_scan_clk == 0 } {
   # Create generated clocks for all PLL clocks
   foreach {_Source _Name _start _freq _jitter _peri _dutycycle _Factor _ApbClk} $_pllclocks {
     create_generated_clock -name emdc_${_Name} -source [get_attribute [get_clocks ${_Name}] sources] -master_clock [get_clocks ${_Name}] -divide_by 4 -add [get_ports emdc]
     lappend lemdc emdc_${_Name} ${_Name}
   }
   # Ignore paths between generated clocks
   foreach {_Name _Master} $lemdc {
     # To all Generated Clocks
     foreach {__Name __Master} $lemdc {
       if { ![string compare ${_Name} ${__Name}] == 0 } { 
         set_clock_groups -logically_exclusive -group ${_Name} -group ${__Name}
         set_clock_groups -logically_exclusive -group ${_Name} -group ${__Master}
       }
     }
   }  
 }

 set emdc_peri [expr $sys_peri / 4.0]
 set_input_delay  -clock [get_clocks emdc] -min [expr $tech_lib_hold]                 [get_ports emdio] -add_delay
 set_input_delay  -clock [get_clocks emdc] -max [expr $emdc_peri/2 - $tech_lib_setup] [get_ports emdio] -add_delay
 set_output_delay -clock [get_clocks emdc] -max [expr $emdc_peri/2 + $tech_lib_setup] [get_ports emdio] -add_delay
 set_output_delay -clock [get_clocks emdc] -min [expr -1 * $tech_lib_hold]            [get_ports emdio] -add_delay

 if { $use_scan_clk == 0 } {
  foreach {_Source _Name _start _freq _jitter _peri _dutycycle _Factor _ApbClk} $_pllclocks {
    set emdc_peri [expr $sys_peri / 4.0]
    set_input_delay  -clock [get_clocks emdc_${_Name}] -min [expr $tech_lib_hold]                 [get_ports emdio] -add_delay
    set_input_delay  -clock [get_clocks emdc_${_Name}] -max [expr $emdc_peri/2 - $tech_lib_setup] [get_ports emdio] -add_delay
    set_output_delay -clock [get_clocks emdc_${_Name}] -max [expr $emdc_peri/2 + $tech_lib_setup] [get_ports emdio] -add_delay
    set_output_delay -clock [get_clocks emdc_${_Name}] -min [expr -1 * $tech_lib_hold]            [get_ports emdio] -add_delay
  }
 }

 # Interrupt
 set_false_path -from [get_ports emdint]

 # Set load
 # Use default driver and load for GRETH 

}
#################################################################################
# General Timing Constraints
#################################################################################

### Max transition for library
if { ![info exists default_max_transition] } then {
  echo "Info: Max transition from Tech library are used"
} else {
  echo "Info: Max transition is set to ${default_max_transition} ns"
  set_max_transition $default_max_transition -data_path [get_clocks *]
}

### Max input transition for library
if { ![info exists default_max_input_transition] } then {
  echo "Info: Max input transition from Tech library are used"
} else {
  echo "Info: Max input transition is set to ${default_max_input_transition} ns"
  set my_inputs [all_inputs]  
  set all_clocks [get_clocks]
  foreach_in_collection temp_clock $all_clocks {
   set my_inputs [remove_from_collection $my_inputs [get_object_name [get_attribute [get_clocks $temp_clock] sources]]]
  }
  foreach_in_collection _my_inputs $my_inputs {
   set_input_transition $default_max_input_transition [get_ports $_my_inputs]
  }
}

### Max capacitance for library
if { ![info exists default_max_capacitance] } then {
  echo "Info: Max capacitance from Tech library are used"
} else {
  echo "Info: Max capacitance is set to ${default_max_capacitance} ns"
  set_max_capacitance $default_max_capacitance -data_path [get_clocks *]
}

### Derating for Library
if { ![info exists derate_design] } then {
  echo "Info: No derating used"
} else {
  echo "Info: Apply ${derate_design} % derating"
  set_timing_derate -early -clock -net_delay  [expr 1 - ${derate_design}]
  set_timing_derate -early -clock -cell_delay [expr 1 - ${derate_design}]
  set_timing_derate -late  -clock -net_delay  [expr 1 + ${derate_design}]
  set_timing_derate -late  -clock -cell_delay [expr 1 + ${derate_design}]
  set_timing_derate -early -data  -net_delay  1.0
  set_timing_derate -early -data  -cell_delay 1.0
}
