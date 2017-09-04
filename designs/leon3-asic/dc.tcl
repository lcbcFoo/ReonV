#################################################################################
# Aeroflex Gaisler Leon3-Asic Synthesis Script for Design Compiler
#################################################################################

### Check Tech Library to use
set argc [string length $argv]
if {$argc == 0} then {
  echo "ERROR: The synth.tcl script requires tech library to be inputed."
  exit
} else {
  echo "Tech Library ${argv} has been selected by GRLIB"
  set err_tech_setup [catch {exec test -f ./grtechscripts/setup_${argv}.tcl}]
  if {${err_tech_setup} == "1"} {
   set err_tech_setup [catch {exec test -f ./techscripts/setup_${argv}.tcl}]
   if {${err_tech_setup} == "1"} {
     echo "ERROR: No Tech Library Setup file for ${argv} has been found"
     exit
   } else {
    set gr_tech_lib techscripts
   }
  } else {
   set gr_tech_lib grtechscripts
  }
  set err_tech_timing [catch {exec test -f ./grtechscripts/timing_${argv}.tcl}]
  if {${err_tech_timing} == "1"} {
   set err_tech_timing [catch {exec test -f ./techscripts/timing_${argv}.tcl}]
   if {${err_tech_timing} == "1"} {
     echo "ERROR: No Tech Library Timing file for ${argv} has been found"
     exit
   }
  }
}

### Script development switches

# The following setting removes new variable info messages from the end of the log file
set_app_var sh_new_variable_message false

# Skip elaboration for debugging of scripts
set skip_elaboration 0

# Skip opt for debugging of scripts
set skip_opt 0

# Skip IO timing since
set ignore_io_timing 0

#################################################################################
# Script design database naming rules (Do NOT Edit!)
#################################################################################

### Design top module
set grdesigntop $top
echo "INFO: Design top is set to ${grdesigntop}"

### Select Tech lib
set grtechlib $argv
echo "INFO: Tech Lib is set to ${argv}"

### Prefix on all generated files
set report_run ${grdesigntop}_${grtechlib}

#################################################################################
# Design Options
#################################################################################

### Keep Scan nets for scan insertion
# SCAN input control signals is shared in LEON3-ASIC ref design
set scan_keep_nets    1
set scan_scan_port    dsubre 
set scan_testrst_port dsuen
set scan_testoen_port dsurx 
set scan_scan_net     core0/scanen
set scan_testrst_net  core0/testrst
set scan_testoen_net  core0/testoen

#################################################################################
# Optimization Options
#################################################################################

### Set priority for verification
# The set_verification_priority command sets the verification_priority attribute 
# on the specified objects. During compile_ultra, the optimizations of the design 
# with the attribute are adjusted depending on the verification priority level so 
# that the potential for hard verification is reduced
# For more information about facilitating formal verification in the flow, refer
# to the following SolvNet article:
# "Resolving Inconclusive and Hard Verifications in Design Compiler"
# https://solvnet.synopsys.com/retrieve/033140.html
set priority_verification_no_elab_opt 0
set priority_verification 0

### Do critical range optimization
set critical_range_opt 0

### Ungroup Design
set Ungroup_Design 0

### Ungroup Design Ware
set Ungroup_Design_Ware 0

#################################################################################
# Report Options
#################################################################################

### verbose reports i.e. print timing, area and power reports in dc log file
set report_verbose 0

#################################################################################
# Simulation Options
#################################################################################

# N/A

#################################################################################
# Enviroment setup and tech lib
#################################################################################

# Start recording setup information for Formality
set_svf synopsys/$report_run.svf

# Read Tech Lib Files
source ./${gr_tech_lib}/setup_${grtechlib}.tcl

# Create Tech work library (if needed)
catch {sh mkdir synopsys}
catch {sh mkdir synopsys/${grtechlib}}
catch {sh mkdir synopsys/work}

# Ensure that there are no feedthroughs, or that there are no two output ports
# connected to the same net at any level of hierarchy
set set_fix_multiple_port_nets "true"

#################################################################################
# Read Design Section
#################################################################################

### Remove generics from module name and ignore warnings for name change
#set template_parameter_style "%d"
#set template_naming_style   "%s"
#suppress_message LINK-17

### Don't remove any flops during optimization
### This is for debugging the formality flow since no warnings is printed
### for opt of unloaded flops. (DFF, DFFX0 and DFFX1)
if {$priority_verification_no_elab_opt == 1} then {
   ### Preserve Unloaded Sequential
   set hdlin_preserve_sequential true
   set compile_delete_unloaded_sequential_cells false

   ### Verification priority during VHDL read
   set hdlin_verification_priority true

   ### Disable const prop
   set case_analysis_with_logic_constants false
}

### Read Design
if {$skip_elaboration == 0} then {

   # Ignore Warnings Generated from GRLIB
   suppress_message OPT-1056
   suppress_message ELAB-802
   suppress_message ELAB-832
   suppress_message ELAB-833
   suppress_message ELAB-294

   # Read design
   source ${grdesigntop}_dc.tcl

   # searches for subfunctions that can be factored out
   set_structure true

   # The following section removes unused design from memory after ungrouping.
   # This is useful if you want to run in 32-bit mode but don't quite fit. It
   # is not applicable to XG mode.
   write -f ddc -hier -o tmp.ddc
   remove_design -designs
   read_ddc tmp.ddc
   sh rm tmp.ddc

   # Write elaborated design
   write -f ddc -hier ${grdesigntop} -output synopsys/elab_$report_run.ddc
} else {
   ### Read design
   read_ddc synopsys/elab_$report_run.ddc
}

# Force DC to keep internal scan enable to simplify test insertion
if {$scan_keep_nets == 1} then {
  suppress_message OPT-461
  set_dont_touch [get_nets ${scan_scan_net}   ]
  set_dont_touch [get_nets ${scan_testrst_net}]
  set_dont_touch [get_nets ${scan_testoen_net}]
  set_dont_touch [get_cells -of_objects [get_nets ${scan_scan_net}   ] -filter "is_hierarchical==false"]
  set_dont_touch [get_cells -of_objects [get_nets ${scan_testrst_net}] -filter "is_hierarchical==false"]
  set_dont_touch [get_cells -of_objects [get_nets ${scan_testoen_net}] -filter "is_hierarchical==false"]
  set_false_path -from [get_ports ${scan_scan_port}   ] -through [get_cells -of_objects [get_nets ${scan_scan_net}   ] -filter "is_hierarchical==false"]
  set_false_path -from [get_ports ${scan_testrst_port}] -through [get_cells -of_objects [get_nets ${scan_testrst_net}] -filter "is_hierarchical==false"]
  set_false_path -from [get_ports ${scan_testoen_port}] -through [get_cells -of_objects [get_nets ${scan_testoen_net}] -filter "is_hierarchical==false"]
}

# Ignore timing for SCAN during timing opt.
set_case_analysis 0 [get_ports testen]

#################################################################################
# Link Design
#################################################################################

link

#################################################################################
# Apply constraints
#################################################################################

if {$skip_opt == 0} then {

 ### Apply tech lib constraints
 source ./${gr_tech_lib}/timing_${grtechlib}.tcl

 ### Apply design timing constraints
 source ./timing.tcl

 ### Ungroup and Partition Selection
 if {$priority_verification == 1} then {
    ### Make it easier to run formal verification
    set_verification_priority -high -all

    ### suppress msg for module not ungrouped due to verification is set to high
    suppress_message OPT-774
    suppress_message OPT-1604

    # Don't delete unloaded sequential cells
    set compile_delete_unloaded_sequential_cells false

    ### Uniquify all common objects and suppress uniquify opt messages
    suppress_message OPT-1056
    suppress_message OPT-319
    uniquify -force
 } else {
    # Suppress msg for ungrouping leaf cell
    suppress_message UID-51
    # Uncomment to get improved QoR
    if {$Ungroup_Design_Ware == 1} then {
      ungroup -all -start_level 2
    } else {
     #dont_touch [get_cells -hier *rstphy*]
     #dont_touch [get_cells -hier *mrst*]
    }
    uniquify
 }

 ### Apply additonal optimization to design
 # For the best top-level WNS, set critical_range to 25 percent of the highest
 # frequency clock period for lower-level partitions. Also, if you care about
 # top-level TNS, set critical_range to 10 percent of the highest frequency clock
 # period for the top partition.  To do this, set the following critical ranges:
 if {$critical_range_opt == 1} then {
  set_critical_range [expr ${sys_peri} * 0.25] [get_designs * -hier]
  set_critical_range [expr ${sys_peri} * 0.10] [get_designs $grdesigntop]
 }

 ### Ungroup Design Ware
 # if you completely ungroup your compile partitions (recommended), it is easy to
 # ungroup nearly all your DesignWare components simply by repeating the ungroup
 # commands used before your initial compile. SolvNet article 901532,
 if {$Ungroup_Design_Ware == 1} then {
  # Design Compiler script to flatten DesignWare hierarchy throughout the design #
  set save_place [current_design]

  foreach_in_collection design_name [find design *] {
      current_design $design_name
      set dw_cell_list [filter [find cell *] {@is_synlib_operator==true || \
                         @is_dw_subblock==true || @is_synlib_module==true }]
      catch {sizeof_collection $dw_cell_list} result
      if {$result != 0} {
       echo [concat [format "%s%s" [format "%s%s" {Info: Found some DW \
           hierarchy in } [get_object_name $design_name]] {. Ungrouping...}]]
       ungroup -flatten $dw_cell_list -simple
      }
  }
  
  current_design $save_place
  unset save_place
  unset dw_cell_list
 }

 # Prevent assignment statements in the Verilog netlist.
 set_fix_multiple_port_nets -all -buffer_constants

 ### Set design
 current_design ${grdesigntop}

 #################################################################################
 # Run Optimization without clock gates and scan
 #################################################################################

 if {$priority_verification == 1} then {
    compile -area_effort none -map_effort high
 } else {

    # Suppress msg for ungrouping and renaming when using ultra mode
    suppress_message OPT-112
    suppress_message OPT-319
    suppress_message OPT-776
    suppress_message OPT-777
    suppress_message DDB-72

    # Turns off the identification and merging of registers that are equal or opposite
    set compile_enable_register_merging false

    # Turns off the identification and removal of constant sequential elements
    set compile_seqmap_propagate_constants false

    # Trun off seq inversion
    set compile_seqmap_enable_output_inversion false

    # Don't delete unloaded sequential cells
    set compile_delete_unloaded_sequential_cells false

    # Compile using ultra mode
    compile_ultra
 }

 # If you are using the internal pins flow, it is recommended to run the
 # change_names command before set_dft_signal to avoid problems after DFT insertion.
 # In this case, set_dft_signal pins should be based on pin names after change_names.
 change_names -rules verilog -hierarchy

 
 write -f ddc -hier ${grdesigntop} -output synopsys/$report_run.ddc
 write -f verilog -hier ${grdesigntop} -output synopsys/$report_run.v
 write_sdf -version 3.0 synopsys/$report_run.sdf

#################################################################################
# Create reports
#################################################################################

source ./report.tcl

}

#################################################################################
# End of run
#################################################################################

quit

