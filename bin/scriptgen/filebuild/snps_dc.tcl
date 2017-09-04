set compile_dc_contents ""
proc create_snps_dc {} {
	upvar compile_dc_contents cdc
	append cdc "catch {sh mkdir synopsys}"
	return
}

proc append_lib_snps_dc {k kinfo} {
	global SNPS_HOME
	upvar compile_dc_contents cdc
	set bn [dict get $kinfo bn]
	if {[string equal $bn "dware"] } {
		append cdc "\n#define_design_lib $bn -path $SNPS_HOME/packages/dware/lib/DWARE "
	} else {
		append cdc "\ncatch \{sh mkdir synopsys/$bn\} "
		append cdc "\ndefine_design_lib $bn -path synopsys/$bn "
	}
	return
}

proc append_file_snps_dc {f finfo} {
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
			global DCVHDL VHDLOPT
			upvar compile_dc_contents cdc
			append cdc "\n$DCVHDL $bn $VHDLOPT$f"
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
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				global XDCLIBSKIP XDCDIRSKIP DCSKIP
				set l [dict get $finfo l]
				set q [dict get $finfo q]
				if {[lsearchmatch $XDCLIBSKIP $bn] < 0 && [lsearchmatch $XDCDIRSKIP $l] < 0 && [lsearchmatch $DCSKIP $q] < 0 } {
					global DCVHDL VHDLOPT
					upvar compile_dc_contents cdc
					append cdc "\n$DCVHDL $bn $VHDLOPT$f"
				}
			}
			return
		}
		"vlogsyn" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				global DCVLOG
				upvar compile_dc_contents cdc
				append cdc "\n$DCVLOG $bn $f"
			}
			return
		}
		"svlogsyn" {
			global DCVLOG
			upvar compile_dc_contents cdc
			append cdc "\n$DCVLOG $bn $f"
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

proc eof_snps_dc {} {
	upvar compile_dc_contents cdc
	set dcfile [open "compile.dc" w]
	puts $dcfile $cdc
	close $dcfile
}

