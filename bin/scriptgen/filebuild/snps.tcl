proc snps_create_tool {filetree fileinfo} {
	global GRLIB
	source "$GRLIB/bin/scriptgen/filebuild/snps_vcs.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/snps_dc.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/snps_fmref.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/snps_synp.tcl"
	source "$GRLIB/bin/scriptgen/filebuild/snps_simv.tcl"

	create_snps_vcs
	create_snps_dc
	create_snps_fmref

	foreach k [dict keys $filetree] {
		set ktree [dict get $filetree $k]
		set kinfo [dict get $fileinfo $k]
		append_lib_snps_dc $k $kinfo
		append_lib_snps_vcs $k $kinfo
		foreach l [dict keys $ktree] {
			set filelist [dict get $ktree $l]
			foreach f $filelist {
				set finfo [dict get $fileinfo $f]
				append_file_snps_simv $f $finfo
				append_file_snps_dc $f $finfo
				append_file_snps_synp $f $finfo
				append_file_snps_fmref $f $finfo
			}
		}
	}
	eof_snps_dc
	eof_snps_fmref
	eof_snps_synp
	eof_snps_vcs
	eof_snps_simv
}

snps_create_tool $filetree $fileinfo
return
