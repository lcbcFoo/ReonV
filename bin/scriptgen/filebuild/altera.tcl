proc altera_create_tool {filetree fileinfo} {
	global GRLIB
	source "$GRLIB/bin/scriptgen/filebuild/altera_quartus.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/altera_synplify.tcl"

	create_altera_quartus 
	create_altera_synplify 

	foreach k [dict keys $filetree] {
		set ktree [dict get $filetree $k]
		set kinfo [dict get $fileinfo $k]
		foreach l [dict keys $ktree] {
			set filelist [dict get $ktree $l]
			foreach f $filelist {
				set finfo [dict get $fileinfo $f]
				append_file_altera_quartus $f $finfo 

			}
		}
	}
	eof_altera_quartus 
	eof_altera_synplify 
}

altera_create_tool $filetree $fileinfo
return
