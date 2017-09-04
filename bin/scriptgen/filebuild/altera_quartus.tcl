set TOP_quartus_qsf_contents ""
set TOP_quartus_qpf_contents ""

proc create_altera_quartus {} {
	global GRLIB TOP
	upvar TOP_quartus_qsf_contents tqsc
	upvar TOP_quartus_qpf_contents tqpc
	set readfile [open "$GRLIB/bin/quartus.qsf_head" r]
	append tqsc [read $readfile]
	close $readfile
	set readfile [open "$GRLIB/bin/quartus.qpf" r]
	append tqpc [read $readfile]
	close $readfile
	append tqpc "PROJECT_REVISION = $TOP"
	return
}

proc append_file_altera_quartus {f finfo } {
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
			return
		}
		"vhdlsyn" {
			global TOP
			upvar TOP_quartus_qsf_contents tqsc
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
					append tqsc "set_global_assignment -name VHDL_FILE $f\n"
			} else {
				global QUARTUSLIBSKIP QDIRSKIP QUARTUSSKIP
				set q [dict get $finfo q]
				if {[lsearchmatch $QUARTUSLIBSKIP $bn] < 0 && [lsearchmatch $QDIRSKIP $l] < 0 && [lsearchmatch $QUARTUSSKIP $q] < 0 } {
					append tqsc "set_global_assignment -name VHDL_FILE $f -library $bn\n"
				}
			}
			return
		}
		"vlogsyn" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				global TOP
				upvar TOP_quartus_qsf_contents tqsc
				append tqsc "set_global_assignment -name VERILOG_FILE $f -library $bn\n"
			}
			return
		}
		"svlogsyn" {
			global TOP
			upvar TOP_quartus_qsf_contents tqsc
		    append tqsc "set_global_assignment -name VERILOG_FILE $f -library $bn\n"
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

proc eof_altera_quartus {} {
	global TOP QSF QSF_APPEND
	upvar TOP_quartus_qsf_contents tqsc
	upvar TOP_quartus_qpf_contents tqpc
	append tqsc "\nset_global_assignment -name TOP_LEVEL_ENTITY \"$TOP\""
	if {[string equal [glob -nocomplain "$QSF"] $QSF ] } {
		set readfile [open "$QSF" r]
		append tqsc "\n[read $readfile]"
		close $readfile
	}
	if {[string equal [glob -nocomplain "$QSF_APPEND"] $QSF_APPEND ] } {
		set readfile [open "$QSF_APPEND" r]
		append tqsc "\n[read $readfile]"
		close $readfile
	}
	set qsffile [open "$TOP\_quartus.qsf" w]
	puts $qsffile $tqsc
	close $qsffile
	set qpffile [open "$TOP\_quartus.qpf" w]
	puts $qpffile $tqpc
	close $qpffile
	return
}
