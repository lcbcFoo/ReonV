proc cdns_create_tool {filetree fileinfo} {
	global GRLIB
	source "$GRLIB/bin/scriptgen/filebuild/cdns_cds.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/cdns_hdl.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/cdns_ncsim.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/cdns_rc.tcl"

	create_cdns_cds 
	create_cdns_hdl
	create_cdns_ncsim 
	create_cdns_rc 

	foreach k [dict keys $filetree] {
		set ktree [dict get $filetree $k]
		set kinfo [dict get $fileinfo $k]
		append_lib_cdns_cds $k $kinfo 
		append_lib_cdns_ncsim $k $kinfo 
		foreach l [dict keys $ktree] {
			set filelist [dict get $ktree $l]
			foreach f $filelist {
				set finfo [dict get $fileinfo $f]
				append_file_cdns_ncsim $f $finfo 
				append_file_cdns_rc $f $finfo 
			}
		}
	}
	eof_cdns_cds 
	eof_cdns_ncsim 
	eof_cdns_rc 
}

cdns_create_tool $filetree $fileinfo
return
