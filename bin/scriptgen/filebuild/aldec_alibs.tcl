set alibs_do_contents ""
proc append_lib_aldec_alibs {k kinfo } {
	upvar alibs_do_contents adc
	set bn [dict get $kinfo bn]
	append adc "\nalib $bn $bn.lib "
	return
}

proc eof_aldec_alibs {} {
	upvar alibs_do_contents adc
	set alibfile [open "alibs.do" w]
	puts $alibfile $adc
	puts $alibfile "\ncd ../../"
	close $alibfile
	return
}
