set compile_rc_contents ""
proc create_cdns_rc {} {
	upvar compile_rc_contents crc
	append crc "set_attribute input_pragma_keyword \"cadence synopsys get2chip g2c fast ambit pragma\""
	return
}

proc append_file_cdns_rc {f finfo} {
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
			global RTLCVHDL VHDLOPT 
			upvar compile_rc_contents crc
			append crc "\n$RTLCVHDL $VHDLOPT$bn $f"
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
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				global RTLCVHDL VHDLOPT XDCLIBSKIP XDCDIRSKIP DCSKIP
				upvar compile_rc_contents crc
				set l [dict get $finfo l]
				set q [dict get $finfo q]
				if {[lsearchmatch $XDCLIBSKIP $bn] < 0 && [lsearchmatch $XDCDIRSKIP $l] < 0 && [lsearchmatch $DCSKIP $q] < 0 } {
					append crc "\n$RTLCVHDL $VHDLOPT$bn $f"
				}
			}
			return
		}
		"vlogsyn" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				global RTLCVLOG
				upvar compile_rc_contents crc
				append crc "\n$RTLCVLOG $f"
			}
			return
		}
		"svlogsyn" {
			global RTLCVLOG
			upvar compile_rc_contents crc
			append crc "\n$RTLCVLOG $f"
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

proc eof_cdns_rc {} {
	upvar compile_rc_contents crc
	set rcfile [open "compile.rc" w]
	puts $rcfile $crc
	close $rcfile
}
