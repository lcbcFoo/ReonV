proc ghdl_create_tool {filetree fileinfo} {
	global GRLIB
	source "$GRLIB/bin/scriptgen/filebuild/ghdl_make.tcl"
	create_ghdl_make 
	set qpath "-Pgnu"
	foreach k [dict keys $filetree] {
		set ktree [dict get $filetree $k]
		set kinfo [dict get $fileinfo $k]
		set bn [dict get $kinfo bn]
		set qpath "$qpath -Pgnu/$bn"
		append_lib_ghdl_make $k $kinfo 
		foreach l [dict keys $ktree] {
			set filelist [dict get $ktree $l]
			foreach f $filelist {
				set finfo [dict get $fileinfo $f]
				append_file_ghdl_make $f $finfo $qpath 
			}
		}
	}
	eof_ghdl_make $qpath 
}

ghdl_create_tool $filetree $fileinfo
return
