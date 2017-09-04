
set toolsstring ""

if {[info exists ::env(TOP)]} {
	set TOP $::env(TOP)
}
if {[info exists ::env(GRLIB)]} {
	set GRLIB $::env(GRLIB)
}

if {[expr ![string equal [glob -nocomplain -type d scriptgenwork] scriptgenwork ] ] } {
	if {[expr ![string equal [glob -nocomplain -type d scriptgencfg] scriptgencfg ] ] } {    
		file copy $GRLIB/bin/scriptgen/scriptgencfg scriptgenwork
	} else {
		file copy scriptgencfg scriptgenwork
	}
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
			append toolsstring "$TOP\.rc "
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
			append toolsstring "modelsim.ini "
			append toolsstring "$TOP\_rtl_fpro.fl "
			continue
		}
		"microsemi" {
			append toolsstring "$TOP\_designer.tcl "
			append toolsstring "$TOP\_libero.prj "
			continue
		}
		"snps" {
			append toolsstring "compile.simv "
			append toolsstring "synopsys_sim.setup "
			append toolsstring "compile.dc "
			append toolsstring "compile.synp "
			append toolsstring "$TOP\_synplify.prj "
			append toolsstring "$TOP\_dc.tcl "
			continue
		}
		"xlnx" {
			append toolsstring "vivado/$TOP\_vivado.tcl "
			append toolsstring "planahead/$TOP\_planAhead.tcl "
			append toolsstring "compile.xst "
			append toolsstring "$TOP.xst "
			append toolsstring "$TOP.npl "
			append toolsstring "$TOP\_ise.tcl "
			continue
		}
	}
}

puts $toolsstring
