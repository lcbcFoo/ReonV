if {[info exists ::env(GRLIB)]} {
	set GRLIB $::env(GRLIB)
}

if {[catch {dict get {}}]} {
        puts stderr "Error! Script generation terminated.\nBuilt-in tcl command \"dict\" not supported by Tcl version $tcl_version.\nDictionaries are added in Tcl 8.5.\nReasons for having an older tcl version could be if the tclsh provided with ISE is used."
        close [open "scriptgendone" w]
        return
}

source "scriptgenwork/tools.tcl"
source "scriptgenwork/extrafiles.tcl"

source "$GRLIB/bin/scriptgen/database.tcl"

close [open "scriptgendone" w]
