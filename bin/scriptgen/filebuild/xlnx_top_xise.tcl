set TOP_xise_contents ""
proc create_xlnx_top_xise {} {
	upvar TOP_xise_contents txc
	global GRLIB TOP UCF
	set readfile [open "$GRLIB/bin/head.xise" r]
	append txc [read $readfile]
	append txc "  \<files\>\n"
	foreach u $UCF {
		append txc "    \<file xil_pn:name=\"$u\" xil_pn:type=\"FILE_UCF\"\>\n" 
		append txc "      \<association xil_pn:name=\"Implementation\"/\>\n"
		append txc "    \</file\>\n"
	}
	return
}

proc append_file_top_xise {f finfo} {
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
			upvar TOP_xise_contents txc
			append txc "    <file xil_pn:name=\"$f\" xil_pn:type=\"FILE_VHDL\">\n"
			append txc "      <association xil_pn:name=\"BehavioralSimulation\"/>\n"
			append txc "      <association xil_pn:name=\"Implementation\"/>\n"
			append txc "      <library xil_pn:name=\"$bn\"/>\n"
			append txc "    </file>\n"
			return
		}
		"vhdlfpro" {
			return
		}
		"vhdlprec" {
			return
		}
		"vhdlsyn" {
			global TOP XSTLIBSKIP XSTDIRSKIP XSTSKIP
			set l [dict get $finfo l]
			set q [dict get $finfo q]
			if {[lsearchmatch $XSTLIBSKIP $bn] < 0 && [lsearchmatch $XSTDIRSKIP $l] < 0 && [lsearchmatch $XSTSKIP $q] < 0 } {
				upvar TOP_xise_contents txc
				append txc "    <file xil_pn:name=\"$f\" xil_pn:type=\"FILE_VHDL\">\n"
				append txc "      <association xil_pn:name=\"BehavioralSimulation\"/>\n"
				append txc "      <association xil_pn:name=\"Implementation\"/>\n"
				if {![string equal $l "local"] || ![string equal $bn "work"] } {
					append txc "      <library xil_pn:name=\"$bn\"/>\n"
				}
				append txc "    </file>\n"
			}
			return
		}
		"vlogsyn" {
			set l [dict get $finfo l]
			if {[string equal $l "local"] && [string equal $bn "work"] } {
			} else {
				global TOP XSTLIBSKIP XSTDIRSKIP XSTSKIP
				set l [dict get $finfo l]
				set q [dict get $finfo q]
				if {[lsearchmatch $XSTLIBSKIP $bn] < 0 && [lsearchmatch $XSTDIRSKIP $l] < 0 && [lsearchmatch $XSTSKIP $q] < 0 } {
					upvar TOP_xise_contents txc
					append txc "    <file xil_pn:name=\"$f\" xil_pn:type=\"FILE_VERILOG\">\n"
					append txc "      <association xil_pn:name=\"BehavioralSimulation\"/>\n"
					append txc "      <association xil_pn:name=\"Implementation\"/>\n"
					append txc "      <library xil_pn:name=\"$bn\"/>\n"
					append txc "    </file>\n"
				}
			}
			return
		}
		"svlogsyn" {
			global TOP XSTLIBSKIP XSTDIRSKIP XSTSKIP
			set l [dict get $finfo l]
			set q [dict get $finfo q]
			if {[lsearchmatch $XSTLIBSKIP $bn] < 0 && [lsearchmatch $XSTDIRSKIP $l] < 0 && [lsearchmatch $XSTSKIP $q] < 0 } {
				upvar TOP_xise_contents txc
				append txc "    <file xil_pn:name=\"$f\" xil_pn:type=\"FILE_VERILOG\">\n"
				append txc "      <association xil_pn:name=\"BehavioralSimulation\"/>\n"
				append txc "      <association xil_pn:name=\"Implementation\"/>\n"
				append txc "      <library xil_pn:name=\"$bn\"/>\n"
				append txc "    </file>\n"
			}
			return
		}
		"vhdlsim" {
			global TOP
			upvar TOP_xise_contents txc
			set l [dict get $finfo l]
			append txc "    <file xil_pn:name=\"$f\" xil_pn:type=\"FILE_VHDL\">\n"
			append txc "      <association xil_pn:name=\"BehavioralSimulation\"/>\n"
			if {![string equal $l "local"] || ![string equal $bn "work"] } {
				append txc "      <library xil_pn:name=\"$bn\"/>\n"
			}
			append txc "    </file>\n"
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

proc eof_xlnx_xise {} {
	global TOP PART ISE11TECH NETLISTTECH ISEMAPOPT XSTOPT EFFORT \
		GRLIB_XIL_PN_Pack_Reg_Latches_into_IOBs PACKAGE GRLIB_XIL_PN_Simulator \
		SPEED SIMTOP GRLIB basenames
	upvar TOP_xise_contents txc
	append txc "  </files>\n"
	append txc "  <properties>\n"
	append txc "    <property xil_pn:name=\"Allow Unmatched LOC Constraints\" xil_pn:value=\"true\"/>\n"
	append txc "    <property xil_pn:name=\"Auto Implementation Top\" xil_pn:value=\"false\"/>\n"
	append txc "    <property xil_pn:name=\"Bus Delimiter\" xil_pn:value=\"()\"/>\n"
	append txc "    <property xil_pn:name=\"Constraints Entry\" xil_pn:value=\"Constraints Editor\"/>\n"
	append txc "    <property xil_pn:name=\"Create Mask File\" xil_pn:value=\"true\"/>\n"
	append txc "    <property xil_pn:name=\"Create ReadBack Data Files\" xil_pn:value=\"true\"/>\n"
	append txc "    <property xil_pn:name=\"Device\" xil_pn:value=\"$PART\"/>\n"
	append txc "    <property xil_pn:name=\"Device Family\" xil_pn:value=\"$ISE11TECH\"/>\n"
	append txc "    <property xil_pn:name=\"Drive Done Pin High\" xil_pn:value=\"true\"/>\n"
	append txc "    <property xil_pn:name=\"FSM Encoding Algorithm\" xil_pn:value=\"None\"/>\n"
	append txc "    <property xil_pn:name=\"Implementation Top\" xil_pn:value=\"Architecture|$TOP|rtl\"/>\n"
	append txc "    <property xil_pn:name=\"Implementation Top Instance Path\" xil_pn:value=\"/$TOP\"/>\n"
	append txc "    <property xil_pn:name=\"Macro Search Path\" xil_pn:value=\"$GRLIB/netlists/xilinx/$NETLISTTECH\"/>\n"
	append txc "    <property xil_pn:name=\"Other Map Command Line Options\" xil_pn:value=\"$ISEMAPOPT\"/>\n"
	append txc "    <property xil_pn:name=\"Other XST Command Line Options\" xil_pn:value=\"$XSTOPT\"/>\n"
	append txc "    <property xil_pn:name=\"Place &amp; Route Effort Level (Overall)\" xil_pn:value=\"$EFFORT\"/>\n"
	append txc "    <property xil_pn:name=\"PROP_DesignName\" xil_pn:value=\"$TOP\"/>\n"
	append txc "    <property xil_pn:name=\"PROP_xilxBitgCfg_GenOpt_MaskFile_virtex2\" xil_pn:value=\"true\"/>\n"
	append txc "    <property xil_pn:name=\"PROP_xilxBitgCfg_GenOpt_ReadBack_virtex2\" xil_pn:value=\"true\"/>\n"
	append txc "    <property xil_pn:name=\"Pack I/O Registers into IOBs\" xil_pn:value=\"Yes\"/>\n"
	append txc "    <property xil_pn:name=\"Pack I/O Registers/Latches into IOBs\" xil_pn:value=\"$GRLIB_XIL_PN_Pack_Reg_Latches_into_IOBs\"/>\n"
	append txc "    <property xil_pn:name=\"Package\" xil_pn:value=\"$PACKAGE\"/>\n"
	append txc "    <property xil_pn:name=\"Preferred Language\" xil_pn:value=\"VHDL\"/>\n"
	append txc "    <property xil_pn:name=\"Run Design Rules Checker (DRC)\" xil_pn:value=\"false\"/>\n"
	append txc "    <property xil_pn:name=\"Simulator\" xil_pn:value=\"$GRLIB_XIL_PN_Simulator\"/>\n"
	append txc "    <property xil_pn:name=\"Speed Grade\" xil_pn:value=\"$SPEED\"/>\n"
	append txc "    <property xil_pn:name=\"Synthesis Tool\" xil_pn:value=\"XST (VHDL/Verilog)\"/>\n"
	append txc "    <property xil_pn:name=\"Top-Level Source Type\" xil_pn:value=\"HDL\"/>\n"
	append txc "    <property xil_pn:name=\"Verbose Property Persistence\" xil_pn:value=\"false\"/>\n"
	append txc "    <property xil_pn:name=\"Manual Implementation Compile Order\" xil_pn:value=\"true\"/>\n"
	append txc "    <property xil_pn:name=\"PROP_BehavioralSimTop\" xil_pn:value=\"$SIMTOP\"/>\n"
	append txc "  </properties>\n"
	append txc "  <bindings/>\n"
	append txc "  <libraries>\n"
	foreach bn $basenames {
		append txc "    <library xil_pn:name=\"$bn\"/>\n"
	}
	append txc "  </libraries>\n"
	append txc "  <partitions>\n"
	append txc "    <partition xil_pn:name=\"/$TOP\"/>\n"
	append txc "  </partitions>\n"
	append txc "</project>" 
	set xisefile [open "$TOP.xise" w]
	puts $xisefile $txc
	close $xisefile
	return
}
