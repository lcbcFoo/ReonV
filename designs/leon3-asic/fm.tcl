########################################################################
# Formality Verification Script for LEON3 ASIC Ref Design
########################################################################

# Use setup scripts for formality
set use_fm_mode 1

# The following setting removes new variable info messages from the end of the log file
set_app_var sh_new_variable_message false

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

### Design top module
set grdesigntop $top
echo "INFO: Design top is set to ${grdesigntop}"

### Select Tech lib
set grtechlib $argv
echo "INFO: Tech Lib is set to ${argv}"

### Prefix on all generated files
set report_run ${grdesigntop}_${grtechlib}

### Check for guide files and netlist
set err_svf [catch {exec test -f ./synopsys/${grdesigntop}_${argv}.svf}]
if {${err_tech_setup} == "1"} {
 echo "ERROR: No Guide file for design was found"
 exit
}
set err_netlist [catch {exec test -f ./synopsys/${grdesigntop}_${argv}.ddc}]
if {${err_tech_setup} == "1"} {
 echo "ERROR: No Netlist for design was found"
 exit
}

### Prefix on all generated files
set report_run ${grdesigntop}_${grtechlib}

### create dir
sh mkdir -p synopsys/$report_run
set report_dir synopsys/$report_run

########################################################################
# Synopsys Auto Setup Mode
########################################################################

set synopsys_auto_setup true

# Note: The Synopsys Auto Setup mode is less conservative than the
# Formality default mode, and is more likely to result in a successful
# verification out-of-the-box.
#
# Setting synopsys_auto_setup will change the values of the variables
# listed here below.  You may change any of these variables back to
# their default settings to be more conservative.  Uncomment the
# appropriate lines below to revert back to their default settings:

      # set hdlin_ignore_parallel_case true
      # set hdlin_ignore_full_case true
      # set verification_verify_directly_undriven_output true
      # set hdlin_ignore_embedded_configuration false
      # set svf_ignore_unqualified_fsm_information true

########################################################################
# Setup for unresolved modules in design
########################################################################

set hdlin_unresolved_modules black_box

########################################################################
# Search path
#

# Read Tech Lib Files
source ./${gr_tech_lib}/setup_${grtechlib}.tcl

########################################################################
########################################################################
# Read in the SVF file(s)
########################################################################

set_svf synopsys/${grdesigntop}_${argv}.svf

########################################################################
# Read in the libraries
########################################################################

foreach tech_lib "${link_library}" {
  read_db -technology_library $tech_lib
}

########################################################################
# Read in the Reference Design as verilog/vhdl source code
########################################################################

source fmref.tcl
set_top ${grdesigntop}
set_reference r:/WORK/${grdesigntop} 

########################################################################
# Read in the Implementation Design created from DC
#
# Choose the file that you wish to verify
########################################################################

read_ddc -i synopsys/${grdesigntop}_${argv}.ddc
set_top leon3mp
set_implementation i:/WORK/${grdesigntop}

#################################################################################
# Report design statistics, design read warning messages, and user specified setup
#################################################################################

# report_setup_status will create a report showing all design statistics,
# design read warning messages, and all user specified setup.  This will allow
# the user to check all setup before proceeding to run the more time consuming
# commands "match" and "verify".

report_setup_status

########################################################################
# Verify and Report
#
# If the verification is not successful, the session will be saved and reports
# will be generated to help debug the failed or inconclusive verification.
########################################################################

match

report_unmatched_points > $report_dir/fm_report_unmatched_points_$report_run.log

if { ![verify] }  {  
  save_session -replace synopsys/fm_falling_state_$report_run
  report_failing_points > $report_dir/fm_failing_points_$report_run.log
  report_aborted_points > $report_dir/fm_aborted_points_$report_run.log
  report_unverified_points > $report_dir/fm_unverified_points_$report_run.log
  # Use analyze_points to help determine the next step in resolving verification
  # issues. It runs heuristic analysis to determine if there are potential causes
  # other than logical differences for failing or hard verification points. 
  analyze_points -all > $report_dir/fm_analyze_points_points_$report_run.log
}

#start_gui

exit

