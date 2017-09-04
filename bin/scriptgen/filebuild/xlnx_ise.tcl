set TOP_ise_tcl_contents ""
set compile_xst_contents ""
proc create_xlnx_ise {} {
	global TOP PART SPEED PACKAGE ISETECH
	upvar TOP_ise_tcl_contents titc
	append titc "project new $TOP.ise\n"
	append titc "project set family \"$ISETECH\"\n"
	append titc "project set device $PART\n"
	append titc "project set speed $SPEED\n"
	append titc "project set package $PACKAGE\n"
	append titc "puts \"Adding files to project\"\n"
	return
}

proc append_lib_xlnx_ise {k kinfo} {
	global TOP XSTLIBSKIP
	upvar TOP_ise_tcl_contents titc
	set bn [dict get $kinfo bn]
	if {[lsearch $XSTLIBSKIP $bn] < 0 } {
		append titc "lib_vhdl new $bn\n"
	}
	return
}

proc append_file_xlnx_ise {f finfo} {
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
			upvar TOP_ise_tcl_contents titc
			upvar compile_xst_contents cxc
			global XSTVHDL VHDLOPT TOP
			append titc "xfile add \"$f\" -lib_vhdl $bn\n"
			append titc "puts \"$f\"\n"
			append cxc "$XSTVHDL $VHDLOPT$bn -ifn $f\n"
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
			global XSTLIBSKIP XSTDIRSKIP XSTSKIP
			set l [dict get $finfo l]
			set q [dict get $finfo q]
			if {[lsearchmatch $XSTLIBSKIP $bn] < 0 && [lsearchmatch $XSTDIRSKIP $l] < 0 && [lsearchmatch $XSTSKIP $q] < 0 } {
				global XSTVHDL VHDLOPT TOP
				upvar TOP_ise_tcl_contents titc
				upvar compile_xst_contents cxc
				append titc "xfile add \"$f\" -lib_vhdl $bn\n"
				append titc "puts \"$f\"\n"
				if {![string equal $l "local"] || ![string equal $bn "work"] } {
					append cxc "$XSTVHDL $VHDLOPT$bn -ifn $f\n"
				}
			}
			return
		}
		"vlogsyn" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				global XSTLIBSKIP XSTDIRSKIP XSTSKIP
				set l [dict get $finfo l]
				set q [dict get $finfo q]
				if {[lsearchmatch $XSTLIBSKIP $bn] < 0 && [lsearchmatch $XSTDIRSKIP $l] < 0 && [lsearchmatch $XSTSKIP $q] < 0 } {
					global XSTVLOG TOP
					upvar TOP_ise_tcl_contents titc
					upvar compile_xst_contents cxc
					append titc "xfile add \"$f\" $bn\n"
					append titc "puts \"$f\"\n"
					append cxc "$XSTVLOG $bn -ifn $f\n"
				}
			}
			return
		}
		"svlogsyn" {
			global XSTLIBSKIP XSTDIRSKIP XSTSKIP
			set l [dict get $finfo l]
			set q [dict get $finfo q]
			if {[lsearchmatch $XSTLIBSKIP $bn] < 0 && [lsearchmatch $XSTDIRSKIP $l] < 0 && [lsearchmatch $XSTSKIP $q] < 0 } {
				global XSTVHDL VHDLOPT XSTVLOG TOP
				upvar TOP_ise_tcl_contents titc
				upvar compile_xst_contents cxc
			    append titc "xfile add \"$f\" $bn\n"
				append titc "puts \"$f\"\n"
		        append cxc "$XSTVLOG $bn -ifn $f\n"
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

proc append_ucf_xlnx_ise {} {
	global TOP UCF 
	upvar TOP_ise_tcl_contents titc
	foreach f $UCF {
		append titc "xfile add \"$f\"\n"
	}
}

proc eof_xlnx_ise {} {
	global TOP SYNPVLOGDEFS XSTOPT NETLISTTECH GRLIB \
		GRLIB_XIL_PN_Pack_Reg_Latches_into_IOBs ISEMAPOPT
	upvar TOP_ise_tcl_contents titc
	upvar compile_xst_contents cxc
	append titc "project set top \"rtl\" \"$TOP\"\n"
	append titc "project set \"Bus Delimiter\" ()\n"
	append titc "project set \"FSM Encoding Algorithm\" None\n"
	append titc "project set \"Pack I/O Registers into IOBs\" yes\n"
	append titc "project set \"Verilog Macros\" \"$SYNPVLOGDEFS\"\n"
	append titc "project set \"Other XST Command Line Options\" \"$XSTOPT\" -process \"Synthesize - XST\"\n"
	append titc "project set \"Allow Unmatched LOC Constraints\" true -process \"Translate\"\n"
	append titc "project set \"Macro Search Path\" \"$GRLIB/netlists/xilinx/$NETLISTTECH\" -process \"Translate\"\n"
	append titc "project set \"Pack I/O Registers/Latches into IOBs\" \{$GRLIB_XIL_PN_Pack_Reg_Latches_into_IOBs\}\n"
	append titc "project set \"Other MAP Command Line Options\" \"$ISEMAPOPT\" -process Map\n"
	append titc "project set \"Drive Done Pin High\" true -process \"Generate Programming File\"\n"
	append titc "project set \"Create ReadBack Data Files\" true -process \"Generate Programming File\"\n"
	append titc "project set \"Create Mask File\" true -process \"Generate Programming File\"\n"
	append titc "project set \"Run Design Rules Checker (DRC)\" false -process \"Generate Programming File\"\n"
	append titc "project close\n"
	append titc "exit"
	set isetclfile [open "$TOP\_ise.tcl" w]
	puts $isetclfile $titc
	close $isetclfile
	set cxc [rmvlinebreak $cxc]
	set compfile [open "compile.xst" w]
	puts $compfile $cxc
	close $compfile
}
