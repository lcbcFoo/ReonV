set toolsstring ""

if {[info exists ::env(TOP)]} {
	set TOP $::env(TOP)
}
source "scriptgenwork/tools.tcl"
foreach tool $tools {
	switch $tool {
		"aldec" {
			append toolsstring "compile.asim "
			append toolsstring "make.riviera "
			append toolsstring "riviera_ws_create.do "
			continue
		}
		"altera" {
			append toolsstring "$TOP\_quartus.qsf "
			continue
		}
		"cdns" {
			append toolsstring "compile.ncsim "
			append toolsstring "compile.rc "
			continue
		}
		"ghdl" {
			append toolsstring "make.ghdl "
			continue
		}
		"lattice" {
			append toolsstring "$TOP\.ldf "
			continue
		}
		"mentor" {
			append toolsstring "compile.vsim "
			append toolsstring "$TOP\_precision.tcl "
			append toolsstring "modelsim.ini "
			append toolsstring "$TOP\_rtl_fpro.fl "
			continue

		}
		"microsemi" {
			append toolsstring "$TOP\_libero.prj "
			continue
		}
		"snps" {
			append toolsstring "compile.dc "
			append toolsstring "compile.synp "
			continue
		}
		"xlnx" {
			append toolsstring "vivado/$TOP\_vivado.tcl "
			append toolsstring "planahead/$TOP\_planAhead.tcl "
			append toolsstring "compile.xst "
			append toolsstring "$TOP.npl "
			append toolsstring "$TOP\_ise.tcl "
			append toolsstring "$TOP.xise "
			continue
		}
	}
}
if {[string length $toolsstring] > 0 } {
	set toolsstring [string range $toolsstring 0 end-1]
}

puts $toolsstring
