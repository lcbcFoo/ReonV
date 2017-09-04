set TOP_files_prj_contents ""
proc append_file_top_files {f finfo} {
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
			global TOP
			upvar TOP_files_prj_contents tfpc
			append tfpc "\nvhdl $bn $f"
			return
		}
		"vhdlfpro" {
			return
		}
		"vhdlprec" {
			return
		}
		"vhdlsyn" {
				global XSTLIBSKIP XSTDIRSKIP XSTSKIP TOP
				set l [dict get $finfo l]
				set q [dict get $finfo q]
				if {[lsearchmatch $XSTLIBSKIP $bn] < 0 && [lsearchmatch $XSTDIRSKIP $l] < 0 && [lsearchmatch $XSTSKIP $q] < 0 } {
					upvar TOP_files_prj_contents tfpc
					append tfpc "\nvhdl $bn $f"
				}
			return
		}
		"vlogsyn" {
				global XSTLIBSKIP XSTDIRSKIP XSTSKIP TOP
				set l [dict get $finfo l]
				set q [dict get $finfo q]
				if {[lsearchmatch $XSTLIBSKIP $bn] < 0 && [lsearchmatch $XSTDIRSKIP $l] < 0 && [lsearchmatch $XSTSKIP $q] < 0 } {
					upvar TOP_files_prj_contents tfpc
					append tfpc "\nverilog $bn $f"
				}
			return
		}
		"svlogsyn" {
			global XSTLIBSKIP XSTDIRSKIP XSTSKIP TOP
			set l [dict get $finfo l]
			set q [dict get $finfo q]
			if {[lsearchmatch $XSTLIBSKIP $bn] < 0 && [lsearchmatch $XSTDIRSKIP $l] < 0 && [lsearchmatch $XSTSKIP $q] < 0 } {
				upvar TOP_files_prj_contents tfpc
				append tfpc "\nverilog $bn $f"
			}
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

proc eof_xlnx_top_files {} {
	global TOP
	upvar TOP_files_prj_contents tfpc
	set prjfile [open "$TOP\_files.prj" w]	
	puts $prjfile $tfpc
	close $prjfile
	return
}
