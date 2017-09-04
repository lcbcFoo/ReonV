#Note: Special fixes are present to maintain a sequential make.riviera
proc aldec_create_tool {filetree fileinfo} {
	global GRLIB

	source "$GRLIB/bin/scriptgen/filebuild/aldec_alibs.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/aldec_asim.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/aldec_make_riv.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/aldec_riv_create.tcl"

	create_aldec_make_riv 
	create_aldec_riv_create 

	set riv_path ""
	set riv_bn {}
	set riv_fs ""
	set previ ""
	set reachedoptfiles 0
	foreach k [dict keys $filetree] {
		set ktree [dict get $filetree $k]
		set kinfo [dict get $fileinfo $k]
		append_lib_aldec_alibs $k $kinfo 
		append_lib_aldec_riv_create $k $kinfo riv_bn 
		foreach l [dict keys $ktree] {
			set filelist [dict get $ktree $l]
			foreach f $filelist {
				set finfo [dict get $fileinfo $f]
				set i [dict get $finfo i]
				set bn [dict get $finfo bn]
				if {!$reachedoptfiles && [string equal $bn "work"] && [string equal $l "local"] } {
					append_special_aldec_make_riv 
					set reachedoptfiles 1
				} 
				if {![string equal $i $previ] && ![string equal "" $previ] } {
					if {[string length $riv_fs] > 0 } {
						append_type_aldec_make_riv $k $kinfo $previ $riv_fs 
					}
					set riv_fs ""
				}
				append_file_aldec_riv_create $f $finfo riv_fs $riv_path 
				append_file_aldec_asim $f $finfo 
				append_file_aldec_make_riv $f $finfo 
				set previ $i
			}
			if {[string length $riv_fs] > 0 } {
				append_type_aldec_make_riv $k $kinfo $previ $riv_fs 
			}
			set riv_fs ""
			set previ ""
		}
	}
	eof_aldec_alibs 
	eof_aldec_asim 
	eof_aldec_make_riv 
	eof_aldec_riv_create 
}

aldec_create_tool $filetree $fileinfo
return
