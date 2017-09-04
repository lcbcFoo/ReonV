set make_riviera_contents ""
proc create_aldec_make_riv {} {
	upvar make_riviera_contents mrc
	append mrc "all: \n"
	return
}

proc append_file_aldec_make_riv {f finfo} {
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
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				global TOP VCOM VHDLOPT
				upvar make_riviera_contents mrc
				append mrc "\n\t$VCOM $VHDLOPT -work $bn $f"
			} 
			return
		}
		"vlogsyn" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				global TOP VLOG
				upvar make_riviera_contents mrc
				append mrc "\n\t$VLOG -work $bn $f"
			} 
			return
		}
		"svlogsyn" {
			return
		}
		"vhdlsim" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				global TOP VCOM VHDLOPT
				upvar make_riviera_contents mrc
				append mrc "\n\t$VCOM $VHDLOPT -work $bn $f"
			} 
			return
		}
		"vlogsim" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				global TOP VLOG
				upvar make_riviera_contents mrc
				append mrc "\n\t$VLOG -work $bn $f"
			} 
			return
		}
		"svlogsim" {
			return
		}
	}
	return
}

proc append_special_aldec_make_riv {} {
	global GRLIB
	upvar make_riviera_contents mrc
	append mrc "\t@if test -r $GRLIB/lib/tech/secureip/ise/mcb_001.vp && test\
	-r modelsim/secureip; then vlog -quiet -novopt -work secureip\
	$GRLIB/lib/tech/secureip/ise/mcb_*.vp; fi"
}

proc append_type_aldec_make_riv {k kinfo i riv_fs} {
	if {[string equal $i "vhdlsim"] || [string equal $i "vhdlsyn"] || [string equal $i "vhdlmtie"] || [string equal $i "vhdlp1735"] } {
		global VCOM
		upvar make_riviera_contents mrc
		set bn [dict get $kinfo bn]
		append mrc "\t$VCOM -work $bn $riv_fs\n"
	} elseif {[string equal $i "vlogsim"] || [string equal $i "vlogsyn"] } {
		global VLOG
		upvar make_riviera_contents mrc
		set bn [dict get $kinfo bn]
		append mrc "\t$VLOG -work $bn $riv_fs\n"
	} elseif {[string equal $i "svlogsim"] || [string equal $i "svlogsyn"] } {
		global SVLOG
		upvar make_riviera_contents mrc
		set bn [dict get $kinfo bn]
		append mrc "\t$SVLOG -work $bn $riv_fs\n"
	}
	return
}

proc eof_aldec_make_riv {} {
	upvar make_riviera_contents mrc
	global GRLIB
	set makefile [open "make.riviera" w]
	puts $makefile $mrc
	close $makefile
}
