set make_ghdl_contents ""
proc create_ghdl_make {} { 
	upvar make_ghdl_contents mgc
	append mgc "# Import files in libraries\n"
	append mgc ".PHONY: ghdl-import\n"
	append mgc "ghdl-import:\n"
	append mgc "\tmkdir -p gnu"
	return
}

proc append_lib_ghdl_make {k kinfo} {
	upvar make_ghdl_contents mgc
	set bn [dict get $kinfo bn]
	append mgc "\n\tmkdir -p gnu/$bn"
	return
}

proc append_file_ghdl_make {f finfo qpath} {
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
			global GHDLI GHDLIOPT
			upvar make_ghdl_contents mgc
			append mgc "\n\t$GHDLI $GHDLIOPT --workdir=gnu/$bn --work=$bn $qpath $f"
			return
		}
		"vlogsyn" {
			return
		}
		"svlogsyn" {
			return
		}
		"vhdlsim" {
			global GHDLI GHDLIOPT
			upvar make_ghdl_contents mgc
			append mgc "\n\t$GHDLI $GHDLIOPT --workdir=gnu/$bn --work=$bn $qpath $f"
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

proc eof_ghdl_make {qpath} {
	upvar make_ghdl_contents mgc
	set pathfile [open "ghdl.path" w]
	puts $pathfile $qpath
	close $pathfile
	set ghdlfile [open "make.ghdl" w]
	puts $ghdlfile $mgc
	close $ghdlfile
	return
}
