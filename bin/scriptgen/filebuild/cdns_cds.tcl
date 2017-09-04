set cds_lib_contents ""
proc create_cdns_cds {} {
	upvar cds_lib_contents clc
	global GRLIB
	set readfile [open "$GRLIB/bin/cds.lib" r]
	append clc [read $readfile]
	close $readfile
	return
}

proc append_lib_cdns_cds {k kinfo} {
	upvar cds_lib_contents clc
	set bn [dict get $kinfo bn]
	append clc "DEFINE $bn xncsim/$bn \n"
	return
}

proc eof_cdns_cds {} {
	upvar cds_lib_contents clc
	if {[string length $clc] > 0 } {
		set clc [string range $clc 0 end-1]
	}
	set cdfile [open "cds.lib" a]
	puts $cdfile $clc
	close $cdfile
	return
}

