set filelist [list]
lappend filelist "extrafile.vhd"
set dir "local"
set libdict [dict create]
dict set libdict $dir $filelist
set lib "$GRLIB/lib/work"
set extrafiletree [dict create]
dict set extrafiletree $lib $libdict

set extrafileinfo [dict create]
dict set extrafileinfo "$GRLIB/lib/work" [dict create k_real "/home/gaisler/grlib/lib/work" bn "work"]
dict set extrafileinfo "extrafile.vhd" [dict create bn "work" f_real "/home/gaisler/grlib/lib/work/local/extrafile.vhd" q "extrafile.vhd" l "local" i "vhdlsyn" k "../../lib/work"]
