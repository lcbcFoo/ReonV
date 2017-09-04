set TOP_precision_tcl_contents ""
proc create_mentor_precision {} {
	global TOP PART MANUFACTURER MGCTECHNOLOGY MGCPART MGCPACKAGE SPEED
	upvar TOP_precision_tcl_contents tptc
	set configinfo "open_project ./$TOP.psp\n"
	append configinfo "compile\n"
	append configinfo "synthesize\n"
	append configinfo "save_impl"
	set precrunfile [open "$TOP\_precrun.tcl" w]
	puts $precrunfile $configinfo
	close $precrunfile
	append tptc "new_project -name $TOP -folder . -createimpl_name precision\n"
	append tptc "setup_design -manufacturer $MANUFACTURER -family\
	$MGCTECHNOLOGY -part $MGCPART -package $MGCPACKAGE -speed $SPEED\n"
	append tptc "set_input_dir .\n"
	return
}

proc append_file_mentor_precision {f finfo} {
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
			return
		}
		"vhdlfpro" {
			return
		}
		"vhdlprec" {
			upvar TOP_precision_tcl_contents tptc
			global TOP
			append tptc "add_input_file -format VHDL -work $bn -enc $f\n"
			return
		}
		"vhdlsyn" {
			global PRECLIBSKIP PRECDIRSKIP PRECSKIP TOP
			set l [dict get $finfo l]
			set q [dict get $finfo q]
			if {[lsearchmatch $PRECLIBSKIP $bn] < 0 && [lsearchmatch $PRECDIRSKIP $l] < 0 && [lsearchmatch $PRECSKIP $q] < 0 } {
				upvar TOP_precision_tcl_contents tptc
				append tptc "add_input_file -format VHDL -work $bn $f\n"
			}
			return
		}
		"vlogsyn" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				global TOP
				upvar TOP_precision_tcl_contents tptc
				append tptc "add_input_file -format VERILOG -work $bn $f\n"
			}
			return
		}
		"svlogsyn" {
			global TOP
			upvar TOP_precision_tcl_contents tptc
		    append tptc "add_input_file -format VERILOG -work $bn $f\n"
			return
		}
		"vhdlsim" {
			return
		}
		"vlogsim" {
			return
		}
		"svlogsim" {
			return
		}
	}
	return
}

proc eof_mentor_precision {} {
	global TOP SYNFREQ PRECOPT
	upvar TOP_precision_tcl_contents tptc
	append tptc "setup_design -design $TOP\n"
	append tptc "setup_design -retiming\n"
	append tptc "setup_design -vhdl\n"
	append tptc "setup_design -transformations=false\n"
	append tptc "setup_design -frequency=\"$SYNFREQ\"\n"
	append tptc "$PRECOPT\n"
	append tptc "save_impl"
	set precifile [open "$TOP\_precision.tcl" w]
	puts $precifile $tptc
	close $precifile
	return
}
