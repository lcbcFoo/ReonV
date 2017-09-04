set TOP_npl_contents ""
set TOP_synplify_npl_contents ""
set tmp_npl_contents ""
proc create_xlnx_top {} {
	global TOP TECHNOLOGY PART SPEED PACKAGE GRLIB
	upvar TOP_npl_contents tnc
	upvar TOP_synplify_npl_contents tsnc
	set temp "JDF G\n"
	append temp "PROJECT $TOP\n"
	append temp "DESIGN $TOP\n"
	append temp "DEVFAM $TECHNOLOGY\n"
	append temp "DEVICE $PART\n"
	append temp "DEVSPEED $SPEED\n"
	append temp "DEVPKG $PACKAGE\n"
	append tnc $temp
	append tsnc $temp
	append tnc "DEVTOPLEVELMODULETYPE HDL\n"
	append tsnc "DEVTOPLEVELMODULETYPE EDIF\n"
	set readfile [open "$GRLIB/bin/def.npl" r]
	set readinfo [read $readfile]
	append tsnc $readinfo
	set readinfo [rmvlinebreak $readinfo]
	append tnc $readinfo
	return
}

proc append_lib_xlnx_top {k kinfo} {
	upvar tmp_npl_contents mnc
	global XSTLIBSKIP
	set bn [dict get $kinfo bn]
	if {[lsearch $XSTLIBSKIP $bn] < 0 } {
		append mnc "SUBLIB $bn VhdlLibrary vhdl\n"
	}
	return
}

proc append_file_xlnx_top {f finfo} {
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
			upvar tmp_npl_contents mnc
			append mnc "LIBFILE $f $bn vhdl\n"
			return
		}
		"vhdlfpro" {
			return
		}
		"vhdlprec" {
			return 
		}
		"vhdlsyn" {
			upvar tmp_npl_contents mnc
			set l [dict get $finfo l]
				set q [dict get $finfo q]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
				global XSTLIBSKIP XSTDIRSKIP XSTSKIP
				if {[lsearchmatch $XSTLIBSKIP $bn] < 0 && [lsearchmatch $XSTDIRSKIP $l] < 0 && [lsearchmatch $XSTSKIP $q] < 0 } {
					set temp "SOURCE $f\n"
					append temp $mnc
					set mnc $temp
				}
			} else {
				global XSTLIBSKIP XSTDIRSKIP XSTSKIP
				set l [dict get $finfo l]
				set q [dict get $finfo q]
				if {[lsearchmatch $XSTLIBSKIP $bn] < 0 && [lsearchmatch $XSTDIRSKIP $l] < 0 && [lsearchmatch $XSTSKIP $q] < 0 } {
					append mnc "LIBFILE $f $bn vhdl\n"
				}
			}
			return
		}
		"vlogsyn" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				upvar tmp_npl_contents mnc
				global XSTLIBSKIP XSTDIRSKIP XSTSKIP
				set l [dict get $finfo l]
				set q [dict get $finfo q]
				if {[lsearchmatch $XSTLIBSKIP $bn] < 0 && [lsearchmatch $XSTDIRSKIP $l] < 0 && [lsearchmatch $XSTSKIP $q] < 0 } {
					append mnc "LIBFILE $f $bn verilog\n"
				}
			}
			return
		}
		"svlogsyn" {
			upvar tmp_npl_contents mnc
			global XSTLIBSKIP XSTDIRSKIP XSTSKIP
			set l [dict get $finfo l]
			set q [dict get $finfo q]
			if {[lsearchmatch $XSTLIBSKIP $bn] < 0 && [lsearchmatch $XSTDIRSKIP $l] < 0 && [lsearchmatch $XSTSKIP $q] < 0 } {
		        append mnc "LIBFILE $f $bn verilog\n"
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

proc eof_xlnx_top {} {
	global TOP UCF TECHNOLOGY GRLIB NETLISTTECH OS
	upvar TOP_npl_contents tnc
	upvar TOP_synplify_npl_contents tsnc
	upvar tmp_npl_contents mnc
	append tnc "\n"
	append tnc $mnc
	append tnc "DEPASSOC $TOP $UCF\n"
	append tnc "\[Normal\]\n" 
	append tnc "_SynthFsmEncode=xstvhd,  $TECHNOLOGY, VHDL.t_synthesize, 1102507235, None\n"
	append tnc "p_xstBusDelimiter=xstvhd,  $TECHNOLOGY, VHDL.t_synthesize, 1102507235, ()\n"
	append tnc "xilxMapAllowLogicOpt=xstvhd,  $TECHNOLOGY, VHDL.t_placeAndRouteDes, 1102861051, True\n"
	append tnc "xilxMapCoverMode=xstvhd,  $TECHNOLOGY, VHDL.t_placeAndRouteDes, 1102861051, Speed\n"
	append tnc "xilxMapTimingDrivenPacking=xstvhd,  $TECHNOLOGY, VHDL.t_placeAndRouteDes, 1102861051, True\n"
	append tnc "xilxNgdbld_AUL=xstvhd,  $TECHNOLOGY, VHDL.t_placeAndRouteDes, 1102861051, True\n"
	append tnc "xilxNgdbldMacro=xstvhd,  $TECHNOLOGY, VHDL.t_ngdbuild, 1105377047, $GRLIB/netlists/xilinx/$NETLISTTECH\n" 
	append tnc "xilxPAReffortLevel=xstvhd,  $TECHNOLOGY, VHDL.t_placeAndRouteDes, 1102861051, Medium\n" 

	set wininfo [rmvlinebreak [string map {/ \\} $tnc] ]
	set winfile [open "$TOP\_win32.npl" w]
	puts $winfile $wininfo
	close $winfile
        if {![string equal -nocase [exec uname] "Linux"] && ![string equal -nocase [exec uname] "SunOs"]} {
		set tnc $wininfo
	}
	append tnc "\[STRATEGY-LIST\]\n"
	append tnc "Normal=True\n"
	append tnc "DEVSYNTHESISTOOL XST (VHDL/Verilog)"
	set nplfile [open "$TOP.npl" w]
	puts $nplfile $tnc
	close $nplfile

	append tsnc "SOURCE synplify/$TOP.edf\n"
	append tsnc "DEPASSOC $TOP $UCF\n"
	append tsnc "\[Normal\]\n"
	append tsnc "xilxMapAllowLogicOpt=edif,  $TECHNOLOGY, EDIF.t_placeAndRouteDes, 1102861051, True\n"
	append tsnc "xilxMapCoverMode=edif,  $TECHNOLOGY, EDIF.t_placeAndRouteDes, 1102861051, Speed\n"
	append tsnc "xilxNgdbld_AUL=edif,  $TECHNOLOGY, EDIF.t_placeAndRouteDes, 1102861051, True\n"
	append tsnc "xilxPAReffortLevel=edif,  $TECHNOLOGY, EDIF.t_placeAndRouteDes, 1102861051, Medium\n"
	append tsnc "xilxNgdbldMacro=edif,  $TECHNOLOGY, EDIF.t_placeAndRouteDes, 1105378344, $GRLIB/netlists/xilinx/$NETLISTTECH\n"

	set wininfo [rmvlinebreak [string map {/ \\} $tsnc] ]
	set winfile [open "$TOP\_synplify_win32.npl" w]
	puts $winfile $wininfo
	close $winfile

        if {![string equal -nocase [exec uname] "Linux"] && ![string equal -nocase [exec uname] "SunOs"]} {
		set tsnc $wininfo
	}

	append tsnc "\[STRATEGY-LIST\]\n"
	append tsnc "Normal=True"
	set synpfile [open "$TOP\_synplify.npl" w]
	puts $synpfile $tsnc
	close $synpfile
	return
}
