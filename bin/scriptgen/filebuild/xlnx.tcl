proc xlnx_create_tool {filetree fileinfo} {
	global GRLIB
	source "$GRLIB/bin/scriptgen/filebuild/xlnx_ise.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/xlnx_planAhead.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/xlnx_top.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/xlnx_top_files.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/xlnx_top_xise.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/xlnx_vivado.tcl"
	global VHDLSYNFILES VHDLOPTSYNFILES
	set tmpnplinfo ""
	foreach synfile [concat $VHDLOPTSYNFILES $VHDLSYNFILES] {
		if {[string equal [glob -nocomplain $synfile] $synfile ] } {
			append tmpnplinfo "SOURCE $synfile\n"
		}
	}

	create_xlnx_vivado
	create_xlnx_planAhead
	create_xlnx_top
	create_xlnx_ise
	create_xlnx_top_xise

	set fend 0

	foreach k [dict keys $filetree] {
		set ktree [dict get $filetree $k]
		set kinfo [dict get $fileinfo $k]
		append_lib_xlnx_top $k $kinfo 
		append_lib_xlnx_ise $k $kinfo
		foreach l [dict keys $ktree] {
			set filelist [dict get $ktree $l]
			foreach f $filelist {
				set finfo [dict get $fileinfo $f]
				set bn [dict get $finfo bn]
				if {[string equal $l "local"] && [string equal $bn "work"] && !$fend } {
					append_ucf_xlnx_ise
					set fend 1
				}
				append_file_xlnx_ise $f $finfo
				append_file_xlnx_top $f $finfo 
				append_file_top_xise $f $finfo
				append_file_top_files $f $finfo
				append_file_xlnx_vivado $f $finfo
				append_file_xlnx_planAhead $f $finfo
			}
		}
	}
	eof_xlnx_ise
	eof_xlnx_planAhead
	eof_xlnx_xise 
	eof_xlnx_top 
	eof_xlnx_top_files
	eof_xlnx_vivado
}

xlnx_create_tool $filetree $fileinfo
return
