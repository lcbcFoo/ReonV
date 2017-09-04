set TOP_ldf_contents ""
proc create_lattice_top_ldf {} {
	global TOP PART SPEED PACKAGE
	upvar TOP_ldf_contents tlc
	append tlc "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
	append tlc "<BaliProject version=\"1.3\" title=\"$TOP\" device=\"$PART$SPEED$PACKAGE\" default_implementation=\"$TOP\">\n"
	append tlc "    <Options/>\n"
	append tlc "    <Implementation title=\"$TOP\" dir=\"lattice\" description=\"$TOP\" default_strategy=\"Timing\">\n"
	append tlc "        <Options/>\n"
	return
}

proc append_file_lattice_top_ldf {f finfo} {
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
			set q [dict get $finfo q]
			set l [dict get $finfo l]
			global XSYNPLIBSKIP XSYNPDIRSKIP SYNPSKIP TOP
			if {[lsearchmatch $XSYNPLIBSKIP $bn] < 0 && [lsearchmatch $XSYNPDIRSKIP $l] < 0 && [lsearchmatch $SYNPSKIP $q] < 0 } {
				upvar TOP_ldf_contents tlc
				 append tlc "        <Source name=\"$f\" type=\"VHDL\" type_short=\"VHDL\">\n"
				if {[string equal $bn "work"] && [string equal $l "local" ] } {
					append tlc "            <Options/>\n"
				} else {
					append tlc "            <Options lib=\"$bn\"/>\n"
				}
				append tlc "        </Source>\n"
			}
			return
		}
		"vlogsyn" {
			return
		}
		"svlogsyn" {
			return
		}
		"vhdlsim" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				global TOP
				upvar TOP_ldf_contents tlc
				append tlc "        <Source name=\"$f\" type=\"VHDL\" type_short=\"VHDL\" syn_sim=\"SimOnly\" excluded=\"TRUE\" >\n"
				append tlc "            <Options lib=\"$bn\"/>\n"
				append tlc "        </Source>\n"
			}
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

proc eof_lattice_top_ldf {} {
	global UCF SDCFILE TOP
	upvar TOP_ldf_contents tlc
	append tlc "        <Source name=\"$UCF\" type=\"Logic Preference\" type_short=\"LPF\">\n"
	append tlc "            <Options/>\n"
	append tlc "        </Source>\n"
	append tlc "        <Source name=\"$SDCFILE\" type=\"Synplify Design Constraints File\" type_short=\"SDC\">\n"
	append tlc "            <Options/>\n"
	append tlc "        </Source>\n"
	append tlc "    </Implementation>\n"
	append tlc "</BaliProject>"
	set ldffile [open "$TOP.ldf" a]
	puts $ldffile $tlc
	close $ldffile
}
