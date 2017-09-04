set fmref_tcl_contents ""
proc create_snps_fmref {} {
	upvar fmref_tcl_contents ftc
	append ftc "# Formality script to read reference design"
	return
}

proc append_file_snps_fmref {f finfo} {
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
			global FMVHDL FMVHDLOPT
			upvar fmref_tcl_contents ftc
			append ftc "\n$FMVHDL $bn $FMVHDLOPT$f"
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
			global XDCLIBSKIP XDCDIRSKIP DCSKIP
			upvar fmref_tcl_contents ftc
			set l [dict get $finfo l]
			set q [dict get $finfo q]
			if {[lsearchmatch $XDCLIBSKIP $bn] < 0 && [lsearchmatch $XDCDIRSKIP $l] < 0 && [lsearchmatch $DCSKIP $q] < 0 } {
				global FMVHDL FMVHDLOPT
				append ftc "\n$FMVHDL $bn $FMVHDLOPT$f"
			}
			return
		}
		"vlogsyn" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				global FMVLOG
				upvar fmref_tcl_contents ftc
				append ftc "\n$FMVLOG $bn $f"
			}
			return
		}
		"svlogsyn" {
			global FMVLOG
			upvar fmref_tcl_contents ftc
			append ftc "\n$FMVLOG $bn $f"
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

proc eof_snps_fmref {} {
	upvar fmref_tcl_contents ftc
	set fmfile [open "fmref.tcl" w]
	puts $fmfile $ftc
	close $fmfile
	return
}

