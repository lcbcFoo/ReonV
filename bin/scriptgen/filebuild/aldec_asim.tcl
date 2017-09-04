set make_asim_addfile_contents ""
set make_asim_contents ""
set compile_asim_contents ""
proc append_file_aldec_asim {f finfo} {
	set i [dict get $finfo i]
	set bn [dict get $finfo bn]
	switch $i {
		"vhdlp1735" {
			global ACOM VHDLOPT
			upvar compile_asim_contents cac
			append cac "\t$ACOM $VHDLOPT $bn $f\n"
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
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				upvar make_asim_contents mac 
				global ACOM VHDLOPT
				append mac "\n\t$ACOM $VHDLOPT $bn $f"
				upvar make_asim_addfile_contents maac
				append maac "\naddfile -vhdl $f"
			} else {
				global ACOM VHDLOPT
				upvar compile_asim_contents cac
				append cac "\t$ACOM $VHDLOPT $bn $f\n"
			}
			return
		}
		"vlogsyn" {
			global ALOG
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				upvar make_asim_contents mac 
				append mac "\n\t$ALOG $bn $f"
		
			} else {
				upvar compile_asim_contents cac
				append cac "\t$ALOG $bn $f\n"
			}
			return
		}
		"svlogsyn" {
			global ALOG
			upvar compile_asim_contents cac
			append cac "\t$ALOG $bn $f\n"
			return
		}
		"vhdlsim" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				global ACOM VHDLOPT
				upvar make_asim_contents mac 
				append mac "\n\t$ACOM $VHDLOPT $bn $f"
				upvar make_asim_addfile_contents maac
				append maac "\naddfile -vhdl $f"	
			} else {
				upvar compile_asim_contents cac
				global ACOM VHDLOPT
				append cac "\t$ACOM $VHDLOPT $bn $f\n"
			}
			return
		}
		"vlogsim" {
			global ALOG
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				upvar make_asim_contents mac 
				append mac "\n\t$ALOG $bn $f"
			} else {
				upvar compile_asim_contents cac
				append cac "\t$ALOG $bn $f\n"
			}
			return
		}
		"svlogsim" {
			global ALOG
			upvar compile_asim_contents cac
			append cac "\t$ALOG $bn $f\n"
			return
		}
	}
	return
}

proc eof_aldec_asim {} {
	upvar make_asim_contents mac 
	upvar compile_asim_contents cac
	upvar make_asim_addfile_contents maac
	set compfile [open "compile.asim" w]
	if {[string length $cac] > 0 } {
		set cac [string range $cac 0 end-1]
	}
	puts $compfile $cac
	close $compfile
	set temp $cac
	append temp $mac
	set mac $temp
	set makefile [open "make.asim" w]
	puts $makefile $temp
	close $makefile
	set addfile [open "make.asim-addfile" w]
	puts $addfile $maac
	close $addfile
	return
}
