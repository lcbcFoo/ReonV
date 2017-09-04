set SIMTOP_mpf_contents ""

proc append_file_mentor_simtop_mpf {f finfo nfiles} {
	set i [dict get $finfo i]
	set bn [dict get $finfo bn]
	switch $i {
		"vhdlp1735" {
			global SIMTOP
			upvar SIMTOP_mpf_contents smc
			upvar $nfiles nf
			append smc "Project_File_$nf = $f\n"
			append smc "Project_File_P_$nf = vhdl_novitalcheck 0\
			file_type VHDL group_id 0 vhdl_nodebug 0 vhdl_1164 1 vhdl_noload 0\
			vhdl_synth 0 folder {Top Level} last_compile 0 vhdl_disableopt 0 vhdl_vital 0\
			vhdl_warn1 0 vhdl_warn2 1 vhdl_explicit 0 vhdl_showsource 1 vhdl_warn3 1\
			vhdl_options {} vhdl_warn4 1 ood 0 vhdl_warn5 0 compile_to $bn compile_order\
			$nf dont_compile 0 cover_stmt 1 vhdl_use93 93\n"
			incr nf
			return
		}		
		"vhdlmtie" {
			global SIMTOP
			upvar SIMTOP_mpf_contents smc
			upvar $nfiles nf
			append smc "Project_File_$nf = $f\n"
			append smc "Project_File_P_$nf = vhdl_novitalcheck 0\
			file_type VHDL group_id 0 vhdl_nodebug 0 vhdl_1164 1 vhdl_noload 0\
			vhdl_synth 0 folder {Top Level} last_compile 0 vhdl_disableopt 0 vhdl_vital 0\
			vhdl_warn1 0 vhdl_warn2 1 vhdl_explicit 0 vhdl_showsource 1 vhdl_warn3 1\
			vhdl_options {} vhdl_warn4 1 ood 0 vhdl_warn5 0 compile_to $bn compile_order\
			$nf dont_compile 0 cover_stmt 1 vhdl_use93 93\n"
			incr nf
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
			return
		}
		"vhdlfpro" {
			return
		}
		"vhdlprec" {
			return
		}
		"vhdlsyn" {
			global SIMTOP
			upvar SIMTOP_mpf_contents smc
			upvar $nfiles nf
			append smc "Project_File_$nf = $f\n"
			append smc "Project_File_P_$nf = vhdl_novitalcheck 0\
			file_type VHDL group_id 0 vhdl_nodebug 0 vhdl_1164 1 vhdl_noload 0\
			vhdl_synth 0 folder {Top Level} last_compile 0 vhdl_disableopt 0 vhdl_vital 0\
			vhdl_warn1 0 vhdl_warn2 1 vhdl_explicit 0 vhdl_showsource 1 vhdl_warn3 1\
			vhdl_options {} vhdl_warn4 1 ood 0 vhdl_warn5 0 compile_to $bn compile_order\
			$nf dont_compile 0 cover_stmt 1 vhdl_use93 93\n"
			incr nf
			return
		}
		"vlogsyn" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				global SIMTOP
				upvar SIMTOP_mpf_contents smc
				upvar $nfiles nf
				append smc "Project_File_$nf = $f\n"
				append smc "Project_File_P_$nf = vlog_protect 0 file_type Verilog\
				group_id 0 vlog_1995compat 0 vlog_nodebug 0 folder {Top Level} vlog_noload 0\
				last_compile 0 vlog_disableopt 0 vlog_hazard 0 vlog_showsource 0 ood 1\
				compile_to $bn vlog_upper 0 vlog_options {} compile_order $nf dont_compile 0\n"
				incr nf
			}
			return
		}
		"svlogsyn" {
			global SIMTOP
			upvar SIMTOP_mpf_contents smc
			upvar $nfiles nf
			append smc "Project_File_$nf = $f\n"
		    append smc "Project_File_P_$nf = vlog_protect 0 file_type Verilog\
			group_id 0 vlog_1995compat 0 vlog_nodebug 0 folder {Top Level} vlog_noload 0\
			last_compile 0 vlog_disableopt 0 vlog_hazard 0 vlog_showsource 0 ood 1\
			compile_to $bn vlog_upper 0 vlog_options {} compile_order $nf dont_compile 0\n"
			incr nf
			return
		}
		"vhdlsim" {
			global SIMTOP
			upvar SIMTOP_mpf_contents smc
			upvar $nfiles nf
			append smc "Project_File_$nf = $f\n"
			append smc "Project_File_P_$nf = vhdl_novitalcheck 0 file_type VHDL\
			group_id 0 vhdl_nodebug 0 vhdl_1164 1 vhdl_noload 0 vhdl_synth 0 folder {Top Level}\
			last_compile 0 vhdl_disableopt 0 vhdl_vital 0 vhdl_warn1 0 vhdl_warn2 1 vhdl_explicit 0\
			vhdl_showsource 1 vhdl_warn3 1 vhdl_options {} vhdl_warn4 1 ood 0 vhdl_warn5 0\
			compile_to $bn compile_order $nf dont_compile 0 cover_stmt 1 vhdl_use93 93\n"
			incr nf
			return
		}
		"vlogsim" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				global SIMTOP
				upvar SIMTOP_mpf_contents smc
				upvar $nfiles nf
				append smc "Project_File_$nf = $f\n"
				append smc "Project_File_P_$nf = vlog_protect 0 file_type Verilog\
				group_id 0 vlog_1995compat 0 vlog_nodebug 0 folder {Top Level} vlog_noload 0\
				last_compile 0 vlog_disableopt 0 vlog_hazard 0 vlog_showsource 0 ood 1\
				compile_to $bn vlog_upper 0 vlog_options {} compile_order $nf dont_compile 0\n"
				incr nf
			}
			return
		}
		"svlogsim" {
			global SIMTOP
			upvar SIMTOP_mpf_contents smc
			upvar $nfiles nf
			append smc "Project_File_$nf = $f\n"
			append smc "Project_File_P_$nf = vlog_protect 0 file_type Verilog\
			group_id 0 vlog_1995compat 0 vlog_nodebug 0 folder {Top Level} vlog_noload 0\
			last_compile 0 vlog_disableopt 0 vlog_hazard 0 vlog_showsource 0 ood 1\
			compile_to $bn vlog_upper 0 vlog_options {} compile_order $nf dont_compile 0\n"
			incr nf
			return
		}
	}
	return
}

proc eof_mentor_simtop_mpf {nfiles} {
	global SIMTOP GRLIB
	upvar SIMTOP_mpf_contents smc

	set readfile [open "modelsim.ini" r]
	set temp [read $readfile]
	close $readfile

	append temp  "\[Project\]\n"
	append temp "Project_Version = 5\n"
	append temp "Project_DefaultLib = work\n"
	append temp "Project_SortMethod = unused\n" 
    append temp "Project_Files_Count = $nfiles\n\n"

	append temp $smc
	set smc $temp

    append smc "Project_Sim_Count = 1\n"
	append smc "Project_Sim_0 = Simulation 1\n"
	append smc "Project_Sim_P_0 = Generics \{\} timing default -std_output \{\} +notimingchecks 0 -L \{\} selected_du \{\} -hazards 0 -sdf \{\} +acc \{\} ok 1 folder \{Top Level\} -absentisempty 0 +pulse_r \{\} OtherArgs \{\} -multisource_delay \{\} +pulse_e \{\} -coverage 0 -sdfnoerror 0 +plusarg \{\} -vital2.2b 0 -t ps additional_dus work.$SIMTOP -nofileshare 0 -noglitch 0 -wlf \{\} +no_pulse_msg 0 -assertfile \{\} -sdfnowarn 0 -Lf \{\} -std_input \{\}\n"

	set readfile [open $GRLIB/bin/mt1.mpf r]
	append smc [read $readfile]
	close $readfile

	if {[string length $smc] > 0 } {
		set smc [string range $smc 0 end-1]
	}

	set mpffile [open "$SIMTOP.mpf" w]
	puts $mpffile $smc
	close $mpffile

	return
}
