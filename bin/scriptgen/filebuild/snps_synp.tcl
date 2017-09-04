set compile_synp_contents ""
proc append_file_snps_synp {f finfo} {
	set i [dict get $finfo i]
	set bn [dict get $finfo bn]
	switch $i {
		"vhdlp1735" {
			global SYNPVHDL VHDLOPT
			upvar compile_synp_contents csc
			append csc "$SYNPVHDL $VHDLOPT$bn $f\n"
		}		
		"vhdlmtie" {
		}
		"vhdlsynpe" {
			global SYNPVHDL VHDLOPT
			upvar compile_synp_contents csc
			append csc "$SYNPVHDL $VHDLOPT$bn $f\n"
		}
		"vhdldce" {
		}
		"vhdlcdse" {
		}
		"vhdlxile" {
		}
		"vhdlfpro" {
		}
		"vhdlprec" {
		}
		"vhdlsyn" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				global SYNPVHDL VHDLOPT
				upvar compile_synp_contents csc
				append csc "$SYNPVHDL $VHDLOPT$bn $f\n"
			}
		}
		"vlogsyn" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				global SYNPVLOG
				upvar compile_synp_contents csc
				append csc "$SYNPVLOG $f\n"
			}
		}
		"svlogsyn" {
			global SYNPVLOG
			upvar compile_synp_contents csc
			append csc "$SYNPVLOG -vlog_std sysv $f\n"
		}
		"vhdlsim" {
		}
		"vlogsim" {
		}
		"svlogsim" {
		}
	}
	return
}

proc eof_snps_synp {} {
	upvar compile_synp_contents csc
	set csc [rmvlinebreak $csc]
	set compfile [open "compile.synp" w]
	puts $compfile $csc
	close $compfile
}
