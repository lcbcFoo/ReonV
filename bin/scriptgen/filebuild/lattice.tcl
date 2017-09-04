proc lattice_create_tool {filetree fileinfo} {
	global GRLIB
	source "$GRLIB/bin/scriptgen/filebuild/lattice_top_lct.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/lattice_top_ldf.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/lattice_top_syn.tcl"

	if {[expr ![string equal [glob -nocomplain -type d lattice] lattice ] ] } {
		file mkdir lattice
	}

	create_lattice_top_ldf 
	create_lattice_top_lct 
	create_lattice_top_syn 
	foreach k [dict keys $filetree] {
		set ktree [dict get $filetree $k]
		set kinfo [dict get $fileinfo $k]
		foreach l [dict keys $ktree] {
			set filelist [dict get $ktree $l]
			foreach f $filelist {
				set finfo [dict get $fileinfo $f]
				append_file_lattice_top_ldf $f $finfo 
			}
		}
	}
	eof_lattice_top_ldf 
}

lattice_create_tool $filetree $fileinfo
return
