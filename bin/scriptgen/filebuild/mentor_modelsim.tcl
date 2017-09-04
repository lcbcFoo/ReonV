set libs_do_contents ""
set modelsim_ini_contents ""
proc create_mentor_modelsim {} {
	upvar libs_do_contents ldc
	upvar modelsim_ini_contents mic
	append ldc "vlib modelsim"
	append mic {[Library]}
	return
}

proc append_lib_mentor_modelsim {k kinfo} {
	upvar libs_do_contents ldc
	upvar modelsim_ini_contents mic
	set bn [dict get $kinfo bn]
	append ldc "\nvlib modelsim/$bn "
	append mic "\n$bn = modelsim/$bn"
	return
}

proc eof_mentor_modelsim {} {
	upvar libs_do_contents ldc
	upvar modelsim_ini_contents mic
	global GRLIB
	set libsfile [open "libs.do" w]
	puts $libsfile $ldc
	close $libsfile
	set readfile [open "$GRLIB/bin/modelsim.ini" r]
	set simfile [open "modelsim.ini" w]
	append mic "\n[read $readfile]"
	set mic [rmvlinebreak $mic]	
	puts $simfile $mic
	close $readfile
	close $simfile
	return
}
