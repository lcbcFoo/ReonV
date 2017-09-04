set TOP_rtl_fpro_fl_contents ""
proc create_mentor_top_fpro {} {
	global TOP
	upvar TOP_rtl_fpro_fl_contents trffc
	append trffc "# FormalPro file list for $TOP design"
	return
}

proc append_file_mentor_top_fpro {f finfo fpro_fs} {
	set i [dict get $finfo i]
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
			upvar $fpro_fs fprofs
			set fprofs "$fprofs $f"
			return
		}
		"vhdlprec" {
			return
		}
		"vhdlsyn" {
			set bn [dict get $finfo bn]
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				global TOP
				upvar TOP_rtl_fpro_fl_contents trffc
				append trffc "\n\t-work $bn $f"
			} else {
				upvar $fpro_fs fprofs
				set fprofs "$fprofs $f"
			}
			return
		}
		"vlogsyn" {
			set bn [dict get $finfo bn]
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				global TOP
				upvar TOP_rtl_fpro_fl_contents trffc
				append trffc "\n\t-work $bn $f"
				append trffc "\n\t-work $bn $f"
			} else {
				upvar $fpro_fs fprofs
				set fprofs "$fprofs $f"
			}
			return
		}
		"svlogsyn" {
			upvar $fpro_fs fprofs
			set fprofs "$fprofs $f"
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

proc append_type_mentor_top_fpro {k kinfo i fpro_fs} {
	global TOP
	upvar TOP_rtl_fpro_fl_contents trffc
	set bn [dict get $kinfo bn]
	append trffc "\n\t-work $bn $fpro_fs"
}

proc eof_mentor_top_fpro {} {
	global TOP
	upvar TOP_rtl_fpro_fl_contents trffc
	set fprofile [open "$TOP\_rtl_fpro.fl" a]
	puts $fprofile $trffc
	close $fprofile
}

