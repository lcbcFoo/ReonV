proc mentor_create_tool {filetree fileinfo} {
	global GRLIB
	source "$GRLIB/bin/scriptgen/filebuild/mentor_modelsim.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/mentor_precision.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/mentor_top_fpro.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/mentor_vsim.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/mentor_simtop_mpf.tcl"

	create_mentor_modelsim
	create_mentor_precision
	create_mentor_top_fpro

	set nfiles 0
	set fpro_fs ""
	set previ ""

	foreach k [dict keys $filetree] {
		set ktree [dict get $filetree $k]
		set kinfo [dict get $fileinfo $k]
		append_lib_mentor_modelsim $k $kinfo
		foreach l [dict keys $ktree] {
			set filelist [dict get $ktree $l]
			foreach f $filelist {
				set finfo [dict get $fileinfo $f]
				set i [dict get $finfo i]
				if {![string equal $i $previ] && ![string equal "" $previ]} {
					if {[string length $fpro_fs] > 0 } {
						append_type_mentor_top_fpro $k $kinfo $previ $fpro_fs
					}
					set fpro_fs ""
				}
				append_file_mentor_vsim $f $finfo 
				append_file_mentor_simtop_mpf $f $finfo nfiles
				append_file_mentor_precision $f $finfo
				append_file_mentor_top_fpro $f $finfo fpro_fs
				set previ $i
			}
			if {[string length $fpro_fs] > 0 } {
				append_type_mentor_top_fpro $k $kinfo $previ $fpro_fs
			}
			set fpro_fs ""
			set previ ""
		}
	}
	eof_mentor_modelsim
	eof_mentor_simtop_mpf $nfiles
	eof_mentor_precision
	eof_mentor_top_fpro
	eof_mentor_vsim 
}

mentor_create_tool $filetree $fileinfo
return
