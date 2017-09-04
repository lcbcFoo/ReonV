set libs_do_contents ""
set vcs_ini_contents ""
proc create_snps_vcs {} {
	upvar libs_do_contents ldc
	upvar vcs_ini_contents mic
	append ldc "mkdir -p vcs"
	return
}

proc append_lib_snps_vcs {k kinfo} {
	upvar libs_do_contents ldc
	upvar vcs_ini_contents mic
	set bn [dict get $kinfo bn]
	append ldc "\nmkdir -p vcs/$bn "
	append mic "\n$bn : vcs/$bn"
	return
}

proc eof_snps_vcs {} {
	upvar libs_do_contents ldc
	upvar vcs_ini_contents mic
	global GRLIB
	set libsfile [open "vcs_libs" w]
	puts $libsfile $ldc
	close $libsfile
	set readfile [open "$GRLIB/bin/synopsys_sim.setup" r]
	set simfile [open "synopsys_sim.setup" w]
	append mic "\n[read $readfile]"
	set mic [rmvlinebreak $mic]	
	puts $simfile $mic
	close $readfile
	close $simfile
	return
}
