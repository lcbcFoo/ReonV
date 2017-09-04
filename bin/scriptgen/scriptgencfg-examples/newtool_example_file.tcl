set newtool_example_contents ""
proc create_newtool_example_file {} {
	upvar newtool_example_contents nec
	append nec ""
	return
}
proc append_lib_newtool_example_file {k kinfo} {
	upvar newtool_example_contents nec
	append nec ""
	return
}
proc append_file_newtool_example_file {f finfo} {
	set i [dict get $finfo i]
	set bn [dict get $finfo bn]
	switch $i {
		"vhdlp1735" {
			return
		}		
		"vhdlmtie" {
			return
		}
		"vhdlsynpe" {
			return
		}
		"vhdldce" {
			return
		}
		"vhdlcdse" {
			return
		}
		"vhdlxile" {
			return
		}
		"vhdlfpro" {
			return
		}
		"vhdlprec" {
			return
		}
		"vhdlsyn" {
			upvar newtool_example_contents nec
			append nec ""
			return
		}
		"vlogsyn" {
			return
		}
		"svlogsyn" {
			return
		}
		"vhdlsim" {
			upvar newtool_example_contents nec
			append nec ""
			return
		}
		"vlogsim" {
			return
		}
		"svlogsim" {
			return
		}
	}
	return
}
proc eof_newtool_example_file {} {
	upvar newtool_example_contents nec
	set examplefile [open "newtool.example" w]
	puts $examplefile $nec
	close $examplefile
	return
}
