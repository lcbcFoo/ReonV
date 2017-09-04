set compile_ncsim_contents ""
set make_ncsim_contents ""

proc create_cdns_ncsim {} {
	upvar compile_ncsim_contents cnc
	append cnc "\tmkdir xncsim"
	return
}

proc append_lib_cdns_ncsim {k kinfo} {
	upvar compile_ncsim_contents cnc
	set bn [dict get $kinfo bn]
	append cnc "\n\tmkdir xncsim/$bn"
	return
}

proc append_file_cdns_ncsim {f finfo} {
	global VHDLOPT NCVHDL NCVLOG 
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
			upvar compile_ncsim_contents cnc
			append cnc "\n\t$NCVHDL $VHDLOPT $bn $f"
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
				global NCVHDL VHDLOPT
				upvar make_ncsim_contents mnc
				append mnc "\n\t$NCVHDL $VHDLOPT $bn $f"
			} else {
				upvar compile_ncsim_contents cnc
				append cnc "\n\t$NCVHDL $VHDLOPT $bn $f"
			}
			return
		}
		"vlogsyn" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				global NCVLOG
				upvar make_ncsim_contents mnc
				append mnc "\n\t$NCVLOG $bn $f"
			} else {
				upvar compile_ncsim_contents cnc
				set k [dict get $finfo k]
				append cnc "\n\t$NCVLOG $bn -INCDIR $k/$l $f"
			}
			return
		}
		"svlogsyn" {
			global NCVLOG
			upvar compile_ncsim_contents cnc
			set l [dict get $finfo l]
			set k [dict get $finfo k]
		    append cnc "\n\t$NCVLOG $bn -INCDIR $k/$l $f"
			return
		}
		"vhdlsim" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				global NCVHDL VHDLOPT
				upvar make_ncsim_contents mnc
				append mnc "\n\t$NCVHDL $VHDLOPT $bn $f"
			} else {
				upvar compile_ncsim_contents cnc
				append cnc "\n\t$NCVHDL $VHDLOPT $bn $f"
			}
			return
		}
		"vlogsim" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				global NCVLOG
				upvar make_ncsim_contents mnc
				append mnc "\n\t$NCVLOG $bn $f"
			} else {
				upvar compile_ncsim_contents cnc
				append cnc "\n\t$NCVLOG $bn $f"
			}
			return
		}
		"svlogsim" {
			global NCVLOG
			upvar compile_ncsim_contents cnc
			append cnc "\n\t$NCVLOG $bn $f"
			return
		}
	}
	return
}

proc eof_cdns_ncsim {} {
	upvar compile_ncsim_contents cnc
	upvar make_ncsim_contents mnc
	global SIMTOP errorInfo
	set temp "ncsim:\n"
	append temp $cnc
	append temp $mnc
	set mnc $temp
	if {[string equal [glob -nocomplain "$SIMTOP.vhd"] "$SIMTOP.vhd" ] } {
		set goterr [catch {
			set arch [lindex [split [exec grep -i architecture $SIMTOP.vhd | grep -i $SIMTOP] ] 1]
		}]
		if { $goterr } {
			set arch "sim"
			puts stderr "cdns_ncsim: Failed to get test bench architecture, defaulting to $arch"
			puts stderr "cdns_ncsim: error_info: $errorInfo"
		}
		append mnc "\n\tncelab -timescale 10ps/10ps $SIMTOP:$arch"
	} else {
		if {[string equal [glob -nocomplain "$SIMTOP.v"] "$SIMTOP.v" ] } {
			append mnc "\n\tncelab -timescale 10ps/10ps $SIMTOP"
		}
	}
	set makefile [open "make.ncsim" w]
	puts $makefile $mnc
	close $makefile
	set compfile [open "compile.ncsim" w]
	puts $compfile $cnc
	close $compfile
	return
}
