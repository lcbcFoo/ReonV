set vivado_contents ""
proc create_xlnx_vivado {} {
	global DESIGN DEVICE VIVADO_SIMSET SIMTOP GRLIB_VIVADO_SOURCE_MGMT_MODE
	upvar vivado_contents vc

	file mkdir "vivado"

	append vc "# Xilinx Vivado script for LEON/GRLIB"
	append vc "\n# Create a new project"
	append vc "\ncreate_project $DESIGN ./vivado/$DESIGN -part $DEVICE -force"
	if {![string equal $VIVADO_SIMSET "sim_1"]} {
		append vc "\ncreate_fileset -simset $VIVADO_SIMSET"
	}
        if {![string equal $GRLIB_VIVADO_SOURCE_MGMT_MODE ""]} {
	        append vc "\nset_property source_mgmt_mode $GRLIB_VIVADO_SOURCE_MGMT_MODE \[current_project\]"
	}
	append vc "\nset_property top $SIMTOP \[get_filesets $VIVADO_SIMSET\]"
	append vc "\nset_property target_language verilog \[current_project\]"
	append vc "\n# Add files for simulation and synthesis"

	return
}

proc append_file_xlnx_vivado {f finfo} {
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
			upvar vivado_contents vc
			append vc "\n$VIVADOVHDL $bn $f"
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
			global VIVADOVHDL VIVADOLIBSKIP VIVADODIRSKIP VIVADOSKIP
			set l [dict get $finfo l]
			set q [dict get $finfo q]
			if {[lsearchmatch $VIVADOLIBSKIP $bn] < 0 && [lsearchmatch $VIVADODIRSKIP $l] < 0 && [lsearchmatch $VIVADOSKIP $q] < 0 } {
				upvar vivado_contents vc
				append vc "\n$VIVADOVHDL $bn $f"
			}
			return
		}
		"vlogsyn" {
			set l [dict get $finfo l]
			global VIVADOVLOG
			upvar vivado_contents vc
			append vc "\n$VIVADOVLOG $bn $f"
			return
		}
		"svlogsyn" {
			global VIVADOVLOG
			upvar vivado_contents vc
			append vc "\n$VIVADOVLOG $bn -sv $f"
			return
		}
		"vhdlsim" {
			set l [dict get $finfo l]
			global VIVADOLIBSKIP VIVADODIRSKIP VIVADOSKIP
			upvar vivado_contents vc
			set l [dict get $finfo l]
			set q [dict get $finfo q]
			if {[lsearchmatch $VIVADOLIBSKIP $bn] < 0 && [lsearchmatch $VIVADODIRSKIP $l] < 0 && [lsearchmatch $VIVADOSKIP $q] < 0 } {
				append vc "\nread_vhdl -library $bn $f"
				append vc "\nset_property used_in_synthesis false \[get_files $f\]"
			}
			return
		}
		"vlogsim" {
			set l [dict get $finfo l]
			upvar vivado_contents vc
			append vc "\nread_verilog -library $bn $f"
			append vc "\nset_property used_in_synthesis false \[get_files $f\]"
			return
		}
		"svlogsim" {
			return
		}
	}
	return
}

proc eof_xlnx_vivado {} {
	global VIVADO_SIMSET GRLIB_XIL_Vivado_sim_verilog_define XDC TCL VIVADO_UCF \
	GRLIB_XIL_Vivado_Simulator TOP PROTOBOARD CONFIG_MIG_7SERIES BOARD VIVADO_MIG_AXI \
	AXI_64 AXI_128 DESIGN CONFIG_GRETH_ENABLE NETLISTTECH GRLIB \
	VIVADO_SYNTH_FLOW VIVADO_SYNTH_STRATEGY VIVADO_IMPL_STRATEGY
	upvar vivado_contents vc

	append vc "\nadd_files -fileset $VIVADO_SIMSET prom.srec ram.srec"
	if {![string equal $GRLIB_XIL_Vivado_sim_verilog_define ""]} {
		append vc "\nset_property verilog_define {$GRLIB_XIL_Vivado_sim_verilog_define} \[get_filesets $VIVADO_SIMSET\]"
	}
	append vc "\n# Read board specific constraints"
	foreach i $XDC {
	  append vc "\nread_xdc $i"
	  append vc "\nset_property used_in_synthesis true \[get_files $i\]"
	  append vc "\nset_property used_in_implementation true \[get_files $i\]"
	}
	foreach i $TCL {
		append vc "\nsource $i"
	}
	foreach i $VIVADO_UCF {
		append vc "\nimport_files $i"
		append vc "\nset_property used_in_synthesis true \[get_files $i\]"
		append vc "\nset_property used_in_implementation true \[get_files $i\]"
	}
	append vc "\n# Board, part and design properties"
	append vc "\nset_property target_simulator $GRLIB_XIL_Vivado_Simulator \[current_project\]"
	append vc "\nset_property top_lib work \[current_fileset\]"
	append vc "\nset_property top_arch rtl \[current_fileset\]"
	append vc "\nset_property top $TOP \[current_fileset\]"
	if {![string equal $PROTOBOARD ""]} {
		append vc "\nset_property board_part $PROTOBOARD \[current_project\]"
	}
	if {[string equal $CONFIG_MIG_7SERIES "y"]} {
		if {[string equal $BOARD "digilent-nexys4ddr-xc7a100t"]} {
			append vc "\nset_property STEPS.WRITE_BITSTREAM.TCL.PRE ../../../../bitstream.tcl \[get_runs impl_1\]"
		}
		if {[file exists "$GRLIB/boards/$BOARD/mig.xci"]} {
			if {![string equal $VIVADO_MIG_AXI ""]} {
				if {![string equal $AXI_64 ""]} {
					set files [glob -nocomplain -type f "$GRLIB/boards/$BOARD/axi_64/mig*"]
				} else {
					if {![string equal $AXI_128 ""]} {
						set files [glob -nocomplain -type f "$GRLIB/boards/$BOARD/axi_128/mig*"]
					} else {
						set files [glob -nocomplain -type f "$GRLIB/boards/$BOARD/axi/mig*"]
					}
				}
			} else {
				set files [glob -nocomplain -type f "$GRLIB/boards/$BOARD/mig.*"]
			}
			foreach f $files {
				file copy $f "vivado/"
			}
			append vc "\nset_property target_language verilog \[current_project\]"
			append vc "\nimport_ip -files vivado/mig.xci -name mig"
			append vc "\n#upgrade_ip \[get_ips mig\]"
			append vc "\ngenerate_target  all \[get_files ./vivado/$DESIGN/$DESIGN.srcs/sources_1/ip/mig/mig.xci\] -force "
		} else {
			puts "\n\nWARNING: No MIG 7series IP was found\n\n"
		}
	}
	if {[string equal $CONFIG_GRETH_ENABLE "y"]} {
		if {[file exists "$GRLIB/boards/$BOARD/sgmii.xci"]} {
			set files [glob -nocomplain -type f "$GRLIB/boards/$BOARD/sgmii.*"]
			foreach f $files {
				file copy $f "vivado/"
			}
			append vc "\nset_property target_language verilog \[current_project\]"
			append vc "\nimport_ip -files vivado/sgmii.xci -name sgmii"
			append vc "\ngenerate_target  all \[get_files ./vivado/$DESIGN/$DESIGN.srcs/sources_1/ip/sgmii/sgmii.xci\] -force "
		}
	}
	if {[file isdirectory "$GRLIB/netlists/xilinx/$NETLISTTECH" ]} {
		append vc "\nimport_files $GRLIB/netlists/xilinx/$NETLISTTECH"
	}
	set vivfile [open "vivado/$TOP\_vivado.tcl" w]
	puts $vivfile $vc
	close $vivfile

	set vc "synth_design -directive runtimeoptimized -resource_sharing off -keep_equivalent_registers -no_lc -rtl -name rtl_1"
	append vc "\nset_property flow {$VIVADO_SYNTH_FLOW} \[get_runs synth_1\]"
	append vc "\nset_property strategy {$VIVADO_SYNTH_STRATEGY} \[get_runs synth_1\]"
	append vc "\nlaunch_runs synth_1"
	append vc "\nwait_on_run -timeout 360 synth_1"
	append vc "\nget_ips"
	append vc "\n# Launch place and route"
	append vc "\nset_property strategy {$VIVADO_IMPL_STRATEGY} \[get_runs impl_1\]"
	append vc "\nset_property steps.write_bitstream.args.mask_file true \[get_runs impl_1\]"
	append vc "\nset_msg_config -suppress -id {Drc 23-20}"
	append vc "\nlaunch_runs impl_1 -to_step write_bitstream"
	append vc "\nwait_on_run -timeout 360 impl_1"
	append vc "\n#report_timing_summary -delay_type min_max -path_type full_clock_expanded -report_unconstrained -check_timing_verbose -max_paths 10 -nworst 1 -significant_digits 3 -input_pins -name timing_1 -file ./vivado/$TOP\_post_timing.rpt"
	append vc "\n#report_drc -file $TOP\_drc_route.rpt"

	set vivfile [open "vivado/$TOP\_vivado_run.tcl" w]
	puts $vivfile $vc
	close $vivfile

	return
}

