proc actel_create_tool { } {
	global DESIGNER_LAYOUT_OPT DESIGNER_PACKAGE DESIGNER_PART DESIGNER_PINS DESIGNER_RADEXP DESIGNER_TECHNOLOGY DESIGNER_TEMPR DESIGNER_VOLTAGE DESIGNER_VOLTRANGE GRLIB PDC PDC_EXTRA SDC SDC_EXTRA SPEED TECHNOLOGY TOP 

	set configinfo "new_design -name \"$TOP\" -family \"$DESIGNER_TECHNOLOGY\"\n"
	if {[string equal $DESIGNER_RADEXP "" ] } {
		append configinfo "set_device -die \"$DESIGNER_PART\" -package \"$DESIGNER_PINS $DESIGNER_PACKAGE\" -speed \"$SPEED\" -voltage \"$DESIGNER_VOLTAGE\" -iostd \"LVTTL\" -jtag \"yes\" -probe \"yes\" -trst \"yes\" -temprange \"$DESIGNER_TEMPR\" -voltrange \"$DESIGNER_VOLTRANGE\"\n"
	} else {
		append configinfo "set_device -die \"$DESIGNER_PART\" -package \"$DESIGNER_PINS $DESIGNER_PACKAGE\" -speed \"$SPEED\" -voltage \"$DESIGNER_VOLTAGE\" -iostd \"LVTTL\" -jtag \"yes\" -probe \"yes\" -trst \"yes\" -temprange \"$DESIGNER_TEMPR\" -voltrange \"$DESIGNER_VOLTRANGE\" -radexp \"$DESIGNER_RADEXP\"\n"
	}
	append configinfo "if {\[file exist $TOP.pdc\]} {\n"
	append configinfo "import_source -format \"edif\" -edif_flavor \"GENERIC\" -merge_physical \"no\" -merge_timing \"no\" {synplify/$TOP.edf} -format \"pdc\" -abort_on_error \"no\" {$TOP.pdc}\n"
	append configinfo "} else {\n"
	append configinfo  "import_source -format \"edif\" -edif_flavor \"GENERIC\" -merge_physical \"no\" -merge_timing \"no\" {synplify/$TOP.edf}\n"
	append configinfo "}\n"
	set designer_act_file [open "$TOP\_designer_act.tcl" w]

	puts $designer_act_file $configinfo
	puts $designer_act_file "save_design  {$TOP.adb}\n"
	close $designer_act_file

	append configinfo "compile -combine_register 1\n"
        if {![string equal $PDC ""] } {
		append configinfo "if {\[file exists $PDC\]} {\n"
		append configinfo "   import_aux -format \"pdc\" -abort_on_error \"no\" {$PDC}\n"
		append configinfo "   pin_commit\n"
		append configinfo "} else {\n"
		append configinfo "   puts \"WARNING: No PDC file imported.\"\n"
		append configinfo "}\n"
	} else {
		append configinfo "puts \"WARNING: No PDC file imported.\"\n"
	}
	if {![string equal $PDC_EXTRA ""] } {
		append configinfo "if {\[file exists $PDC_EXTRA\]} {\n"
		append configinfo "   import_aux -format \"pdc\" -abort_on_error \"no\" {$PDC_EXTRA}\n"
		append configinfo "   pin_commit\n"
		append configinfo "} else {\n"
		append configinfo "   puts \"WARNING: No PDC_EXTRA file imported.\"\n"
		append configinfo "}\n"
	}
        if {![string equal $SDC ""] } {
		append configinfo "if {\[file exists $SDC\]} {\n"
		append configinfo "   import_aux -format \"sdc\" -merge_timing \"no\" {$SDC}\n"
		append configinfo "} else {\n"
		append configinfo "   puts \"WARNING: No SDC file imported.\"\n"
		append configinfo "}\n"
	} else {
		append configinfo "puts \"WARNING: No SDC file imported.\"\n"
	}
	if {![string equal $SDC_EXTRA ""] } {
		append configinfo "if {\[file exists $SDC_EXTRA\]} {\n"
		append configinfo "   import_aux -format \"sdc\" -merge_timing \"yes\" {$SDC_EXTRA}\n"
		append configinfo "} else {\n"
		append configinfo "   puts \"WARNING: No SDC_EXTRA file imported.\"\n"
		append configinfo "}\n"
	}
	append configinfo "save_design {$TOP.adb}\n"
	append configinfo "report -type status {./actel/report_status_pre.log}\n"
	append configinfo "layout $DESIGNER_LAYOUT_OPT\n"
	append configinfo "save_design {$TOP.adb}\n"
	append configinfo "backannotate -dir {./actel} -name \"$TOP\" -format \"SDF\" -language \"VHDL93\" -netlist\n"
	append configinfo "report -type \"timer\" -analysis \"max\" -print_summary \"yes\" -use_slack_threshold \"no\" -print_paths \"yes\" -max_paths 100 -max_expanded_paths 5 -include_user_sets \"yes\" -include_pin_to_pin \"yes\" -select_clock_domains \"no\"  {./actel/report_timer_max.txt}\n"
	append configinfo "report -type \"timer\" -analysis \"min\" -print_summary \"yes\" -use_slack_threshold \"no\" -print_paths \"yes\" -max_paths 100 -max_expanded_paths 5 -include_user_sets \"yes\" -include_pin_to_pin \"yes\" -select_clock_domains \"no\"  {./actel/report_timer_min.txt}\n"
	append configinfo "report -type \"pin\" -listby \"name\" {./actel/report_pin_name.log}\n"
	append configinfo "report -type \"pin\" -listby \"number\" {./actel/report_pin_number.log}\n"
	append configinfo "report -type \"datasheet\" {./actel/report_datasheet.txt}\n"
	if {[string equal $TECHNOLOGY "Axcelerator" ] } {
		append configinfo "export -format \"AFM-APS2\" -trstb_pullup \"yes\" -global_set_fuse \"reset\" -axprg_set_algo \"UMA\" {./actel/$TOP.afm}\n"
		append configinfo "export -format \"prb\" {./actel/$TOP.prb}\n"
	} else {
		append configinfo "export -format \"pdb\" -feature \"prog_fpga\" -io_state \"Tri-State\" {./actel/$TOP.pdb}\n"
	}
	append configinfo "export -format log -diagnostic {./actel/report_log.log}\n"
	append configinfo "report -type status {./actel/report_status_post.log}\n"
	append configinfo "save_design {$TOP.adb}\n"

	set libfile [open "$TOP\_designer.tcl" w]
	puts $libfile $configinfo
	close $libfile
}


actel_create_tool
return
