set planAhead_contents ""
proc create_xlnx_planAhead {} {
	global TOP DESIGN DEVICE PLANAHEAD_SIMSET GRLIB_XIL_PlanAhead_Simulator SIMTOP PROTOBOARD
	upvar planAhead_contents pc

	file mkdir "planahead"

	append pc "# Xilinx planAhead script for LEON/GRLIB"
	append pc "\n# Create a new project"
	append pc "\ncreate_project $DESIGN ./planahead/$DESIGN -part $DEVICE -force"
	if {![string equal $PLANAHEAD_SIMSET "sim_1"]} {
		append pc "\ncreate_fileset -simset $PLANAHEAD_SIMSET"
	}
	append pc "\n# Board, part and design properties"
	append pc "\nset_property target_simulator $GRLIB_XIL_PlanAhead_Simulator \[current_project\]"
	append pc "\nset_property top_lib work \[current_fileset\]"
	append pc "\nset_property top_arch rtl \[current_fileset\]"
	append pc "\nset_property top $TOP \[current_fileset\]"
	append pc "\nset_property target_language VHDL \[current_project\]"
	if {![string equal $PROTOBOARD ""]} {
		append pc "\nset_property board $PROTOBOARD \[current_project\]"
	}
	append pc "\n# Use manual compile order"
	append pc "\n#set_property source_mgmt_mode DisplayOnly \[current_project\]"
	append pc "\n# Disable option: Include all design sources for simulation"
	append pc "\n#set_property SOURCE_SET \{\} \[get_filesets $PLANAHEAD_SIMSET\]"
	append pc "\n# Add files for simulation and synthesis"
	append pc "\nset_property top $SIMTOP \[get_filesets $PLANAHEAD_SIMSET\]"

	return
}

proc append_file_xlnx_planAhead {f finfo} {
	set i [dict get $finfo i]
	set bn [dict get $finfo bn]
	switch $i {
		"vhdlp1735" {
			return
		}		
		"vhdlmtie" {
			return
		}
		"vhdlsynpe" {
			return
		}
		"vhdldce" {
			return
		}
		"vhdlcdse" {
			return
		}
		"vhdlxile" {
			global VIVADOVHDL
			upvar planAhead_contents pc
			append pc "\n$VIVADOVHDL $bn $f"
			append pc "\nset_property file_type VHDL \[get_files $f\]"
			return
		}
		"vhdlfpro" {
			return
		}
		"vhdlprec" {
			return
		}
		"vhdlsyn" {
			set l [dict get $finfo l]
			global VIVADOVHDL
			upvar planAhead_contents pc
			append pc "\n$VIVADOVHDL $bn $f"

			return
		}
		"vlogsyn" {
			set l [dict get $finfo l]
			global VIVADOVLOG
			upvar planAhead_contents pc
			append pc "\n$VIVADOVLOG $bn $f"
			append pc "\nset_property file_type Verilog \[get_files $f\]"
			return
		}
		"svlogsyn" {
			global VIVADOVLOG
			upvar planAhead_contents pc
			append pc "\n$VIVADOVLOG $bn -sv $f"
			return
		}
		"vhdlsim" {
			set l [dict get $finfo l]
			global VIVADOLIBSKIP VIVADODIRSKIP VIVADOSKIP PLANAHEAD_SIMSET
			upvar planAhead_contents pc
			set l [dict get $finfo l]
			set q [dict get $finfo q]
			if {[lsearchmatch $VIVADOLIBSKIP $bn] < 0 && [lsearchmatch $VIVADODIRSKIP $l] < 0 && [lsearchmatch $VIVADOSKIP $q] < 0 } {
				append pc "\nadd_files -fileset $PLANAHEAD_SIMSET -norecurse $f"
				append pc "\nset_property library $bn \[get_files $f\]"
				append pc "\nset_property file_type VHDL \[get_files $f\]"
			}
			return
		}
		"vlogsim" {
			set l [dict get $finfo l]
			global PLANAHEAD_SIMSET
			upvar planAhead_contents pc
			append pc "\nadd_files -fileset $PLANAHEAD_SIMSET -norecurse $f"
			append pc "\nset_property library $bn \[get_files $f\]"
			append pc "\nset_property file_type Verilog \[get_files $f\]"
			return
		}
		"svlogsim" {
			global PLANAHEAD_SIMSET
			upvar planAhead_contents pc
			append pc "\nadd_files -fileset $PLANAHEAD_SIMSET -norecurse $f"
			append pc "\nset_property library $bn \[get_files $f\]"
			return
		}
	}
	return
}

proc eof_xlnx_planAhead {} {
	global GRLIB NETLISTTECH PLANAHEAD_SIMSET GRLIB_XIL_PlanAhead_sim_verilog_define \
	UCF_PLANAHEAD PLANAHEAD_SYNTH_STRATEGY PLANAHEAD_IMPL_STRATEGY PLANAHEAD_BITGEN PROTOBOARD \
	CONFIG_MIG_DDR2 TOP
	upvar planAhead_contents pc

	append pc "\nadd_files -fileset $PLANAHEAD_SIMSET prom.srec ram.srec"
	if {![string equal $GRLIB_XIL_PlanAhead_sim_verilog_define ""]} {
	append pc "\nset_property verilog_define \{$GRLIB_XIL_PlanAhead_sim_verilog_define\} \[get_filesets $PLANAHEAD_SIMSET\]"
	}
	if {[file isdirectory $GRLIB/netlists/xilinx/$NETLISTTECH ]} {
		append pc "\nimport_files $GRLIB/netlists/xilinx/$NETLISTTECH"
	}
	if {[string equal $PROTOBOARD "zedBoard"]} {
		file mkdir "planahead/xps_files"
		file copy "./edk_files/leon3_zedboard" "planAhead/xps_files/"
		append pc "\n# Add Leon3 PS Zedboard Design"
		append pc "\nadd_files ./planahead/xps_files/leon3_zedboard/leon3_zedboard.xmp"
		append pc "\nmake_wrapper -files \[get_files ./planahead/xps_files/leon3_zedboard/leon3_zedboard.xmp\] -top -fileset \[get_filesets sources_1\] -import"
		append pc "\nupdate_compile_order -fileset sources_1"
	}
	append pc "\n# Read board specific constraints"
	foreach i $UCF_PLANAHEAD {
		if {[file exists $i]} {
			append pc "\nread_ucf $i"
		}
	}
	if {[string equal $CONFIG_MIG_DDR2 "y"]} {
		if {[file exists "mig/user_design/par/mig.ucf"]} {
			append pc "\nread_ucf mig/user_design/par/mig.ucf"
		}

	}
#	append pc "create_run synth_$(DESIGN) -flow {$(PLANAHEAD_SYNTH_FLOW)} -strategy {$(PLANAHEAD_SYNTH_STRATEGY)}"
	append pc "\nset_property steps.xst.args.netlist_hierarchy as_optimized \[get_runs synth_1\]"
	append pc "\nset_property strategy $PLANAHEAD_SYNTH_STRATEGY \[get_runs synth_1\]"
	set phfile [open "planahead/$TOP\_planAhead.tcl" w]
	puts $phfile $pc
	close $phfile

	set pc "# Elaborate design to be able to apply SDC to top level"
	append pc "\nlaunch_runs -jobs 1 synth_1"
	append pc "\nwait_on_run -timeout 120 synth_1"
	append pc "\n# Launch place and route"
	append pc "\nset_property strategy $PLANAHEAD_IMPL_STRATEGY \[get_runs impl_1\]"
	append pc "\n#set_property steps.map.args.mt on \[get_runs impl_1\]"
	append pc "\n#set_property steps.par.args.mt 4 \[get_runs impl_1\]"
	append pc "\nset_property steps.bitgen.args.m true \[get_runs impl_1\]"
	if {![string equal $PLANAHEAD_BITGEN ""]} {
			append pc "\nset_property {steps.bitgen.args.More Options} \{ $PLANAHEAD_BITGEN \} \[get_runs impl_1\]"
	}
	append pc "\nlaunch_runs -jobs 1 impl_1 -to_step Bitgen"
	append pc "\nwait_on_run -timeout 120 impl_1"
	if {[string equal $PROTOBOARD "zedBoard"]} {
		append pc "\nexport_hardware \[get_files ./planahead/xps_files/leon3_zedboard/leon3_zedboard.xmp\] \[get_runs impl_1\] -bitstream"
	}
	set phfile [open "planahead/$TOP\_planAhead_run.tcl" w]
	puts $phfile $pc
	close $phfile

	set phfile [open "planahead/$TOP\_planAhead_end.tcl" w]
	puts $phfile "exit\n"
	close $phfile

	return
}

