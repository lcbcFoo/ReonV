proc create_lattice_top_syn {} {
	global PART SPEED PACKAGE TOP
	set tsc ""
	append tsc "JDF B\n"
	append tsc "PROJECT $TOP\n"
	append tsc "DESIGN $TOP Normal\n"
	append tsc "DEVKIT $PART$SPEED$PACKAGE\n"
	append tsc "ENTRY EDIF\n"
	append tsc "MODULE ./synplify/$TOP.edf\n"
	append tsc "MODSTYLE $TOP Normal"
	set lctfile [open "$TOP.syn" w]
	puts $lctfile $tsc
	close $lctfile
	return
}

