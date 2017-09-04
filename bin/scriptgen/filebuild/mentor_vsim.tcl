set compile_vsim_contents ""
set make_vsim_contents ""
proc append_file_mentor_vsim {f finfo} {
	set i [dict get $finfo i]
	set bn [dict get $finfo bn]
	switch $i {
		"vhdlp1735" {
			global VCOM VHDLOPT
			upvar compile_vsim_contents cvc
			append cvc "\t$VCOM $VHDLOPT -work $bn $f\n"
			return
		}		
		"vhdlmtie" {
			global VCOM VHDLOPT
			upvar compile_vsim_contents cvc
			append cvc "\t$VCOM $VHDLOPT -work $bn $f\n"
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
			global VCOM VHDLOPT
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				upvar make_vsim_contents mvc
				append mvc "\t$VCOM $VHDLOPT -work $bn $f\n"
			} else {
				upvar compile_vsim_contents cvc
				append cvc "\t$VCOM $VHDLOPT -work $bn $f\n"
			}
			return
		}
		"vlogsyn" {
			global VLOG
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				upvar make_vsim_contents mvc 
				append mvc "\t$VLOG -work $bn $f\n"
			} else {
				upvar compile_vsim_contents cvc
				set k [dict get $finfo k]
				set l [dict get $finfo l]
				append cvc "\t$VLOG -work $bn +incdir+$k/$l $f\n"
			}
			return
		}
		"svlogsyn" {
			global SVLOG
			upvar compile_vsim_contents cvc
			set k [dict get $finfo k]
			set l [dict get $finfo l]
			append cvc "\t$SVLOG -sv -work $bn +incdir+$k/$l $f\n"
			return
		}
		"vhdlsim" {
			global VCOM VHDLOPT
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				upvar make_vsim_contents mvc 
				append mvc "\t$VCOM $VHDLOPT -work $bn $f\n"
			} else {
				upvar compile_vsim_contents cvc
				append cvc "\t$VCOM $VHDLOPT -work $bn $f\n"
			}
			return
		}
		"vlogsim" {
			global VLOG
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				upvar make_vsim_contents mvc 
				append mvc "\t$VLOG -work $bn $f\n"
			} else {
				upvar compile_vsim_contents cvc
				append cvc "\t$VLOG -work $bn $f\n"
			}
			return
		}
		"svlogsim" {
			global VLOG
			upvar compile_vsim_contents cvc
			append cvc "\t$VLOG -sv -work $bn $f\n"
			return
		}
	}
	return
}

proc eof_mentor_vsim {} {
	global GRLIB
	upvar compile_vsim_contents cvc
	upvar make_vsim_contents mvc 

	set cvc [rmvlinebreak $cvc]
	set compfile [open "compile.vsim" w]
	puts $compfile $cvc
	close $compfile

	set temp "vsim:\n"
	append temp $cvc
	append temp "\n# Work-around for stupid secureip bug ...\n"
	append temp "\t@if test -r $GRLIB/lib/tech/secureip/ise/mcb_001.vp && test -r modelsim/secureip; then vlog -quiet -novopt -work secureip $GRLIB/lib/tech/secureip/ise/mcb_*.vp; fi\n"
	append temp $mvc
	set mvc $temp
	set mvc [rmvlinebreak $mvc]
	set makefile [open "make.vsim" w]
	puts $makefile $mvc
	close $makefile
	return
}
