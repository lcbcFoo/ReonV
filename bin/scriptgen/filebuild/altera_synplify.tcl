set TOP_synplify_qsf_contents ""
set TOP_synplify_qpf_contents ""

proc create_altera_synplify {} {
	global GRLIB TOP QSF
	upvar TOP_synplify_qsf_contents tssc
	upvar TOP_synplify_qpf_contents tspc
	set readfile [open "$GRLIB/bin/quartus.qsf_head" r]
	append tssc [read $readfile]
	close $readfile
	append tssc "set_global_assignment -name VQM_FILE synplify/$TOP.edf" 
	if {[file exists $QSF] } {
		append tssc "\n"
		set readfile [open "$QSF" r]
		append tssc [read $readfile]
		close $readfile
	}
	set readfile [open "$GRLIB/bin/quartus.qpf" r]
	append tspc [read $readfile]
	close $readfile
	append tspc "PROJECT_REVISION = $TOP\_synplify"
	return
}

proc eof_altera_synplify {} {
	global TOP
	upvar TOP_synplify_qsf_contents tssc
	upvar TOP_synplify_qpf_contents tspc
	set qsffile [open "$TOP\_synplify.qsf" w]
	append tssc "\n\nset_global_assignment -name TOP_LEVEL_ENTITY \"$TOP\""
	puts $qsffile $tssc
	close $qsffile
	set qpffile [open "$TOP\_synplify.qpf" w]
	puts $qpffile $tspc
	close $qpffile
	return
}
