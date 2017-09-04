if { [catch {source scriptgen_variable_values.tcl}] } {
    puts stderr "File scriptgen_variable_values.tcl hasn't been generated"
    puts stderr "\n"
}

#Enables wildcards in lsearch
proc lsearchmatch {list pattern} {
	set i 0
	foreach a $list {
		if {[string match $a $pattern]} {
			return $i
		}
		incr i
	}
	return -1
}


#Trims entries in a list
proc listtrim {inputlist} {
	set newlist [list]
	foreach listentry $inputlist {
		set newentry [string trim $listentry]
		if {[expr ![expr [string equal $newentry ""] || [string equal [string index $newentry 0] "#" ] ] ] } {
			lappend newlist $newentry
		}
	}
	return $newlist
}

#Extracts a list from a file for genereatefilelists
proc listinfile {filename} {
	set infofile [open $filename r]
	set info [split [read $infofile] "\n" ]
	set newinfo {}
	foreach i $info {
		if { [string first " " $i] > -1 } {
			set newinfo [concat $newinfo [split $i " "] ]
		} else {
			lappend newinfo $i
		}
	}
	set info $newinfo
	set info [listtrim $info]
	close $infofile
	return $info
}

proc rmvlinebreak {information} {
	if {[string length $information] > 0} {
		set information [string range $information 0 end-1]
	}
	return $information
}

#Generates the top level of the filesystem in which generetefilelists scans
proc librarieslist {} {
	global XTECHLIBS GRLIB LIBADD EXTRALIBS LIBADD
	set liblist {grlib}
	set liblist [concat $liblist $XTECHLIBS]
	set arrayfile [open "$GRLIB/lib/libs.txt" r]
	set liblist [concat $liblist [split [read $arrayfile] "\n"] ]
	close $arrayfile
	foreach lib [glob -nocomplain -type f $GRLIB/lib/*/libs.txt] {
		set arrayfile [open $lib r]
		set liblist [concat $liblist [split [read $arrayfile] "\n" ] ]
		close $arrayfile
	}
	set extralib [expr {[string equal [glob -nocomplain "$EXTRALIBS/libs.txt"]\
		"$EXTRALIBS/libs.txt" ] ? "$EXTRALIBS/libs.txt" : "$GRLIB/bin/libs.txt" }]
	set arrayfile [open $extralib r]
	set liblist [concat $liblist [split [read $arrayfile] "\n"] ]
	close $arrayfile
	set liblist [concat $liblist $LIBADD]
	lappend liblist work
	set liblist [listtrim $liblist]
	return $liblist
}

#Scans filesystem for available libs dirs and files, then creates a dict for
#the filetree and fileinfo, a dict that stores information about each library/file.
#Files optionally added by the user, e.g. "VHDLOPTSYNFILES" are added in the
#back of the filetree/fileinfo dicts
#Also echoes to the user the settings and each library/directory scanned.
proc generatefilelists {filetree fileinfo} {
	global GRLIB EXTRALIBS DIRADD TECHLIBS XLIBSKIP GRLIB_LEON3_VERSION XDIRSKIP\
	FILEADD XFILESKIP GRLIB_CONFIG VHDLSYNFILES VHDLOPTSYNFILES VHDLSIMFILES\
	VERILOGSYNFILES VERILOGOPTSYNFILES VERILOGSIMFILES GRLIB_SIMULATOR TOP SIMTOP
	upvar $filetree ft
	upvar $fileinfo fi

	puts "GRLIB settings:"
	puts {\n}
	puts " GRLIB = $GRLIB"
	puts {\n}
	if {[string equal $GRLIB_CONFIG "dummy"]} {
		puts " GRLIB_CONFIG is library default"
	} else {
		puts " GRLIB_CONFIG = $GRLIB_CONFIG"
	}
	puts {\n}
	puts " GRLIB_SIMULATOR = $GRLIB_SIMULATOR"
	puts {\n}
	puts " TECHLIBS setting = $TECHLIBS"
	puts {\n}
	puts " Top-level design = $TOP"
	puts {\n}
	puts " Simulation top-level = $SIMTOP"
	puts {\n}
	puts "Scanning libraries:"

	set GRLIB_real [file normalize $GRLIB]
	set GRLIB_CONFIG_real [file normalize $GRLIB_CONFIG]

	foreach j [librarieslist] {
		set bn [exec basename $j]
		set k "$GRLIB/lib/$j"
		set k_real "$GRLIB_real/lib/$j"
		set k [expr {[string equal [glob -nocomplain $k] $k ] ? $k : "$EXTRALIBS/$j" } ]
		set tdirs [expr {[string equal $bn "techmap" ] ? "$TECHLIBS maps" : $DIRADD } ]
		if {[lsearch $XLIBSKIP $bn] < 0 && [string equal [glob -nocomplain "$k/dirs.txt"] "$k/dirs.txt" ] } {
			puts {\n}
			puts " $bn:"
			set libtree [dict create]
			foreach l [concat [listinfile $k/dirs.txt] $tdirs] {
				set l [expr {[expr [string equal $l "leon3" ] && [expr\
					![string equal $GRLIB_LEON3_VERSION "3"] ] ] ? "leon3pkgv1v2" : $l } ]
				if {[lsearch $XDIRSKIP $l] < 0 } {
					set flist {}
					foreach i {vlogsyn vhdlsyn svlogsyn vhdlmtie vhdlsynpe vhdldce vhdlcdse vhdlxile vhdlprec \
						vhdlprec vhdlfpro vhdlp1735 vlogsim vhdlsim svlogsim } {
						set m $k/$l/$i
						if {[string equal [glob -nocomplain "$m.txt" ] "$m.txt" ] && ![string equal $m ""] } {
							foreach q [concat [listinfile $m.txt] $FILEADD ] {
								set f $k/$l/$q
								set fx $l/$q
								set f_real $k_real/$l/$q
								if { [string equal $bn "grlib"] && [string equal $l "stdlib"] && \
								[string equal $q "config.vhd"] && ![string equal $GRLIB_CONFIG "dummy"] } {
									set f $GRLIB_CONFIG
									set f_real $GRLIB_CONFIG_real
									set grcfg $f
								}
								if {[lsearch $XFILESKIP $q ] < 0  && [string equal [glob -nocomplain $f] $f ] \
							&& ![string equal $f ""] } {
									set conffiledict [dict create bn $bn f_real $f_real q $q l $l i $i k $k]
									lappend flist $f
									dict set fi $f $conffiledict
								}
							}
						}
					}
					if {[string equal [glob -nocomplain "$k/$l" ] "$k/$l" ] } {
						puts "$l"
						dict set libtree $l $flist
					}
				}
			}
			set libdict [dict create k_real $k_real bn $bn]
			dict set ft $k $libtree
			dict set fi $k $libdict
		}
	}

	puts {\n}

	set flist {}
	foreach f [concat $VHDLOPTSYNFILES $VHDLSYNFILES]  {
		if {[file exists $f] } {
			lappend flist $f
			set conffiledict [dict create bn "work" l "local" i "vhdlsyn" q $f]
			dict set fi $f $conffiledict
		}
	}

	foreach f $VHDLSIMFILES  {
	    if {[file exists $f] } {
			lappend flist $f
			set conffiledict [dict create bn "work" l "local" i "vhdlsim" q $f]
			dict set fi $f $conffiledict
		}
	}

	foreach f [concat $VERILOGOPTSYNFILES $VERILOGSYNFILES]  {
		if {[file exists $f] } {
			lappend flist $f
			set conffiledict [dict create bn "work" l "local" i "vlogsyn" q $f]
			dict set fi $f $conffiledict
		}
	}

	foreach f $VERILOGSIMFILES  {
	    if {[file exists $f] } {
			lappend flist $f
			set conffiledict [dict create bn "work" l "local" i "vlogsim" q $f]
			dict set fi $f $conffiledict
		}
	}

	if {[dict exists $ft "$GRLIB/lib/work" ] } {
		set worklibdict [dict get $ft "$GRLIB/lib/work"]
	} else {
		set worklibdict [dict create]
		set libdict [dict create k_real "$GRLIB_real/lib/work" bn "work"]
		dict set fi "$GRLIB/lib/work" $libdict
	}

	dict set worklibdict "local" $flist
	set ft [dict remove $ft "work"]
	dict set ft "$GRLIB/lib/work" $worklibdict

}

proc mergefiletrees {filetree extrafiletree} {
	foreach extralib [dict keys $extrafiletree] {
		set foundlib 0
		foreach lib [dict keys $filetree] {
			if {[string equal $lib $extralib]} {
				set foundlib 1
				foreach extradir [dict keys [dict get $extrafiletree $lib] ] {
					set founddir 0
					foreach dir [dict keys [dict get $filetree $lib] ] {
						if {[string equal $dir $extradir] } {
							set founddir 1
							foreach extrafile [dict get [dict get $extrafiletree $extralib] $extradir] {
								set foundfile 0
								foreach regularfile [dict get [dict get $filetree $lib] $dir] {
									if {[string equal $regularfile $extrafile] } {
										set foundfile 1
										break
									}
								}
								if {!$foundfile} {
									set libdict [dict get $filetree $lib]
									set dirlist [dict get $libdict $dir]
									lappend dirlist $extrafile
									set libdict [dict remove $libdict $dir]
									dict set libdict $dir $dirlist
									set filetree [dict remove $filetree $lib]
									dict set filetree $lib $libdict
								}
							}
							break
						}
					}
					if {!$founddir} {
						set libdict [dict get $filetree $lib]
						dict set libdict $extradir [dict get [dict get $extrafiletree $extralib] $extradir]
						set filetree [dict remove $filetree $lib]
						dict set filetree $lib $libdict
					}
				}
				break
			}
		}
		if {!$foundlib} {
			dict set filetree $extralib [dict get $extrafiletree $extralib]
		}
	}
	return $filetree
}

proc mergefileinfos {fileinfo extrafileinfo} {
	foreach extrafile [dict keys $extrafileinfo] {
		set found 0
		foreach regularfile [dict keys $fileinfo] {
			if {[string equal $regularfile $extrafile] } {
				set fileinfo [dict remove $fileinfo $extrafile]
				dict set fileinfo $extrafile [dict get $extrafileinfo $extrafile]
				set found 1
			}
		}
		if {!$found} {
			dict set fileinfo $extrafile [dict get $extrafileinfo $extrafile]
		}
	}
	return $fileinfo
}

set varfile [open "$GRLIB/bin/scriptgen/scriptgen_variables.txt" r]
set envvars [split [read $varfile] "\n" ]

foreach envvar $envvars {
    if {$envvar != "" && ![info exists $envvar]} {
	        puts "No value found for $envvar, setting it to {}"
	        puts {\n}
	        set $envvar {}
	}
}

set filetree [dict create]
set fileinfo [dict create]
set GRLIB  [file dirname $GRLIB/bin]
generatefilelists filetree fileinfo 
set filetree [mergefiletrees $filetree $extrafiletree]
set fileinfo [mergefileinfos $fileinfo $extrafileinfo]



set basenames {}
foreach f [dict keys $filetree] {
	lappend basenames [dict get [dict get $fileinfo $f] bn]
}
set libtxtfile [open "libs.txt" w]
puts $libtxtfile "$basenames "
close $libtxtfile

foreach tool $tools {
	switch $tool {
		"actel" - "aldec" - "altera" - "cdns" -	"ghdl" -
		"lattice" - "mentor" - "microsemi" - "snps" -
		"xlnx" {
			if { [ file exists "$GRLIB/bin/scriptgen/filebuild/$tool.tcl" ] } {
				source "$GRLIB/bin/scriptgen/filebuild/$tool.tcl"
			}
			continue
		}
		default {
			if { [catch {source "scriptgenwork/filebuild/$tool.tcl"} fid] } {
				puts stderr "Error with added tool: \"$tool\"!"
				puts stderr "$fid\n"
				puts stderr "Continuing:\n"
			}
			continue
		}
	}
}
