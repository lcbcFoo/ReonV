set riviera_ws_create_do_contents ""
proc create_aldec_riv_create {} {
	upvar riviera_ws_create_do_contents rwcdc
	append rwcdc "workspace.create riviera_ws ."
	return
}

proc append_lib_aldec_riv_create {k kdict riv_bn} {
	upvar $riv_bn rivbn
	upvar riviera_ws_create_do_contents rwcdc
	set bn [dict get $kdict bn]
	append rwcdc "\nworkspace.design.create $bn . "
	append rwcdc "\nworkspace.design.setactive $bn "
	foreach riv_bn_map $rivbn {
		append rwcdc "\nworkspace.dependencies.add $bn $riv_bn_map "
	}
	lappend rivbn $bn
	foreach riv_bn_map $rivbn {
		append rwcdc "\namap $riv_bn_map $riv_bn_map/$riv_bn_map/$riv_bn_map.lib "
	}
	return
}

proc append_file_aldec_riv_create {f finfo riv_fs riv_path} {
	set i [dict get $finfo i]
	set bn [dict get $finfo bn]
	switch $i {
		"vhdlp1735" {
			upvar $riv_fs rivfs
			upvar riviera_ws_create_do_contents rwcdc
			set rivfs "$rivfs $f"
			set f_real [dict get $finfo f_real]
			append rwcdc "\ndesign.file.add $riv_path$f_real"
			return
		}		
		"vhdlmtie" {
			upvar $riv_fs rivfs
			upvar riviera_ws_create_do_contents rwcdc
			set rivfs "$rivfs $f"
			set f_real [dict get $finfo f_real]
			append rwcdc "\ndesign.file.add $riv_path$f_real"
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
			upvar riviera_ws_create_do_contents rwcdc
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				if {[string equal [glob -nocomplain "/$f"] "/$f" ] } {
					append rwcdc "\ndesign.file.add $f"
				} else {
					append rwcdc "\ndesign.file.add ../$f"
				}
			} else {
				upvar $riv_fs rivfs
				set rivfs "$rivfs $f"
				set f_real [dict get $finfo f_real]
				append rwcdc "\ndesign.file.add $riv_path$f_real"
			}
			return
		}
		"vlogsyn" {
			upvar riviera_ws_create_do_contents rwcdc
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				if {[string equal [glob -nocomplain "/$f"] "/$f" ] } {
					append rwcdc "\ndesign.file.add $f"
				} else {
					append rwcdc "\ndesign.file.add ../$f"
				}
			} else {
				upvar $riv_fs rivfs
				set rivfs "$rivfs $f"
				set f_real [dict get $finfo f_real]
				append rwcdc "\ndesign.file.add $riv_path$f_real"
			}
			return
		}
		"svlogsyn" {
			upvar riviera_ws_create_do_contents rwcdc
			upvar $riv_fs rivfs
			set rivfs "$rivfs $f"
			set f_real [dict get $finfo f_real]
			append rwcdc "\ndesign.file.add $riv_path$f_real"
			return
		}
		"vhdlsim" {
			upvar riviera_ws_create_do_contents rwcdc
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				if {[string equal [glob -nocomplain "/$f"] "/$f" ] } {
					append rwcdc "\ndesign.file.add $f"
				} else {
					append rwcdc "\ndesign.file.add ../$f"
				}
			} else {
				upvar $riv_fs rivfs
				set rivfs "$rivfs $f"
				set f_real [dict get $finfo f_real]
				append rwcdc "\ndesign.file.add $riv_path$f_real"
			}
			return
		}
		"vlogsim" {
			upvar riviera_ws_create_do_contents rwcdc
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				if {[string equal [glob -nocomplain "/$f"] "/$f" ] } {
					append rwcdc "\ndesign.file.add $f"
				} else {
					append rwcdc "\ndesign.file.add ../$f"
				}
			} else {
				upvar $riv_fs rivfs
				set rivfs "$rivfs $f"
				set f_real [dict get $finfo f_real]
				append rwcdc "\ndesign.file.add $riv_path$f_real"
			}
			return
		}
		"svlogsim" {
			upvar riviera_ws_create_do_contents rwcdc
			upvar $riv_fs rivfs
			set rivfs "$rivfs $f"
			set f_real [dict get $finfo f_real]
			append rwcdc "\ndesign.file.add $riv_path$f_real"
			return
		}
	}
	return
}

proc eof_aldec_riv_create {} {
	upvar riviera_ws_create_do_contents rwcdc
	set rivierafile [open "riviera_ws_create.do" w]
	puts $rivierafile $rwcdc
	close $rivierafile
	return
}
