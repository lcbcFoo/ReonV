set compile_simv_contents ""
set make_simv_contents ""
proc append_file_snps_simv {f finfo} {
	set i [dict get $finfo i]
	set bn [dict get $finfo bn]
	switch $i {
		"vhdlp1735" {
			global VHDLAN VHDLANOPT
			upvar compile_simv_contents cvc
			append cvc "\tvhdlan -nc $VHDLANOPT -work $bn $f\n"
			return
		}		
		"vhdlmtie" {
			global VHDLAN VHDLANOPT
			upvar compile_simv_contents cvc
			append cvc "\tvhdlan -nc $VHDLANOPT -work $bn $f\n"
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
			global VHDLAN VHDLANOPT
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				upvar make_simv_contents mvc
				append mvc "\tvhdlan -nc $VHDLANOPT -work $bn $f\n"
			} else {
				upvar compile_simv_contents cvc
				append cvc "\tvhdlan -nc $VHDLANOPT -work $bn $f\n"
			}
			return
		}
		"vlogsyn" {
			global VLOGAN
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				upvar make_simv_contents mvc 
				append mvc "\tvlogan -nc -work $bn $f\n"
			} else {
				upvar compile_simv_contents cvc
				set k [dict get $finfo k]
				set l [dict get $finfo l]
				append cvc "\tvlogan -nc -work $bn +incdir+$k/$l $f\n"
			}
			return
		}
		"svlogsyn" {
			global VLOGAN
			upvar compile_simv_contents cvc
			set k [dict get $finfo k]
			set l [dict get $finfo l]
			append cvc "\tvlogan -nc -sverilog -work $bn +incdir+$k/$l $f\n"
			return
		}
		"vhdlsim" {
			global VHDLAN VHDLANOPT
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				upvar make_simv_contents mvc 
				append mvc "\tvhdlan -nc $VHDLANOPT -work $bn $f\n"
			} else {
				upvar compile_simv_contents cvc
				append cvc "\tvhdlan -nc $VHDLANOPT -work $bn $f\n"
			}
			return
		}
		"vlogsim" {
			global VLOGAN
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				upvar make_simv_contents mvc 
				append mvc "\tvlogan -nc -work $bn $f\n"
			} else {
				upvar compile_simv_contents cvc
				append cvc "\tvlogan -nc -work $bn $f\n"
			}
			return
		}
		"svlogsim" {
			global VLOGAN
			upvar compile_simv_contents cvc
			append cvc "\tvlogan -nc -sverilog -work $bn $f\n"
			return
		}
	}
	return
}

proc eof_snps_simv {} {
	global GRLIB
	upvar compile_simv_contents cvc
	upvar make_simv_contents mvc 

	set cvc [rmvlinebreak $cvc]
	set compfile [open "compile.simv" w]
	puts $compfile $cvc
	close $compfile

	set temp "simv:\n"
	append temp $cvc
	append temp "\n"
	append temp $mvc
	set mvc $temp
	set mvc [rmvlinebreak $mvc]
	set makefile [open "make.simv" w]
	puts $makefile $mvc
	close $makefile
	return
}
