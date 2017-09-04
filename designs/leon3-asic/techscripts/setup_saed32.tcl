#################################################################################
# Enviroment setup
#################################################################################

# Select to use formality mode
if { ![info exists use_fm_mode] } {
  echo "Info: Setup Tech Lib for Normal Functional mode clocks"
  set use_fm_mode 0
} else {
  if { $use_fm_mode == 0 } {
     echo "Info: Setup Tech Lib for Normal Functional mode clocks"
  } else { 
     echo "Info: Scan mode clocks"
  }
}

#################################
# Library setup
#################################

# e.g. SAED32_HOME=~/lib_install/SAED32_EDK/
if {[catch {getenv "SAED32_HOME"} msg]} {
 echo "ERROR: Enviroment variable SAED32_HOME should point at a saed32 lib installation "
 exit
}

set grtechlibdir [getenv {SAED32_HOME}]
set grtechlibpath ". ${grtechlibdir}/SAED32_EDK/lib/stdcell_lvt/db_ccs/ ${grtechlibdir}/SAED32_EDK/lib/pll/db_ccs/ ${grtechlibdir}/SAED32_EDK/lib/io_std/db_ccs/ ${grtechlibdir}/SAED32_EDK/lib/sram/db_ccs"
set grtechtargetlib "saed32lvt_ff1p16v125c.db"
set grtechlinklib "saed32lvt_ff1p16v125c.db saed32pll_ff1p16v125c_2p75v.db saed32io_fc_ff1p16v125c_2p75v.db saed32sram_ff1p16v125c.db"

set search_path    $grtechlibpath
set target_library $grtechtargetlib
set link_library   $grtechlinklib


### Library rules...

# Library attributes
# e.g. set hdlin_latch_synch_set_reset "false" 

# Don't use list
# e.g set_dont_use lib/TIEH 
#     set_dont_uselib/TIEL
