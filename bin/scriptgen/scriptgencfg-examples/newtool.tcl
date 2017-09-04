proc newtool_create_tool {filetree fileinfo} {
	global GRLIB
	source "scriptgenwork/filebuild/newtool_example_file.tcl"
	create_newtool_example_file
	foreach k [dict keys $filetree] {
		set ktree [dict get $filetree $k]
		set kinfo [dict get $fileinfo $k]
		append_lib_newtool_example_file $k $kinfo 
		foreach l [dict keys $ktree] {
			set filelist [dict get $ktree $l]
			foreach f $filelist {
				set finfo [dict get $fileinfo $f]
				append_file_newtool_example_file $f $finfo 
			}
		}
	}
	eof_newtool_example_file 
}

newtool_create_tool $filetree $fileinfo
return
