onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 15 /testbench/clk
add wave -noupdate -height 15 /testbench/Rst
add wave -noupdate -height 15 /testbench/wdogn
add wave -noupdate -height 15 -radix hexadecimal /testbench/address
add wave -noupdate -height 15 -radix hexadecimal /testbench/data
add wave -noupdate -height 15 /testbench/sdcke
add wave -noupdate -height 15 /testbench/sdcsn
add wave -noupdate -height 15 /testbench/sdwen
add wave -noupdate -height 15 /testbench/sdrasn
add wave -noupdate -height 15 /testbench/sdcasn
add wave -noupdate -height 15 /testbench/sddqm
add wave -noupdate -height 15 /testbench/sdclk
add wave -noupdate -height 15 -radix hexadecimal /testbench/sa
add wave -noupdate -height 15 -radix hexadecimal /testbench/sd
add wave -noupdate -height 15 /testbench/ramsn
add wave -noupdate -height 15 /testbench/ramoen
add wave -noupdate -height 15 /testbench/rwen
add wave -noupdate -height 15 /testbench/romsn
add wave -noupdate -height 15 /testbench/iosn
add wave -noupdate -height 15 /testbench/oen
add wave -noupdate -height 15 /testbench/read
add wave -noupdate -height 15 /testbench/writen
add wave -noupdate -height 15 /testbench/brdyn
add wave -noupdate -height 15 /testbench/bexcn
add wave -noupdate -height 15 /testbench/dsuen
add wave -noupdate -height 15 /testbench/dsutx
add wave -noupdate -height 15 /testbench/dsurx
add wave -noupdate -height 15 /testbench/dsubre
add wave -noupdate -height 15 /testbench/dsuact
add wave -noupdate -height 15 /testbench/dsurst
add wave -noupdate -height 15 /testbench/test
add wave -noupdate -height 15 /testbench/error
add wave -noupdate -height 15 /testbench/gpio
add wave -noupdate -height 15 -radix hexadecimal /testbench/d3/apbi
add wave -noupdate -height 15 -radix hexadecimal /testbench/d3/apbo
add wave -noupdate -height 15 -radix hexadecimal /testbench/d3/ahbsi
add wave -noupdate -height 15 -radix hexadecimal /testbench/d3/ahbso
add wave -noupdate -height 15 -radix hexadecimal -childformat {{/testbench/d3/ahbmi.hgrant -radix hexadecimal} {/testbench/d3/ahbmi.hready -radix hexadecimal} {/testbench/d3/ahbmi.hresp -radix hexadecimal} {/testbench/d3/ahbmi.hrdata -radix hexadecimal} {/testbench/d3/ahbmi.hirq -radix hexadecimal} {/testbench/d3/ahbmi.testen -radix hexadecimal} {/testbench/d3/ahbmi.testrst -radix hexadecimal} {/testbench/d3/ahbmi.scanen -radix hexadecimal} {/testbench/d3/ahbmi.testoen -radix hexadecimal} {/testbench/d3/ahbmi.testin -radix hexadecimal}} -expand -subitemconfig {/testbench/d3/ahbmi.hgrant {-height 15 -radix hexadecimal} /testbench/d3/ahbmi.hready {-height 15 -radix hexadecimal} /testbench/d3/ahbmi.hresp {-height 15 -radix hexadecimal} /testbench/d3/ahbmi.hrdata {-height 15 -radix hexadecimal} /testbench/d3/ahbmi.hirq {-height 15 -radix hexadecimal} /testbench/d3/ahbmi.testen {-height 15 -radix hexadecimal} /testbench/d3/ahbmi.testrst {-height 15 -radix hexadecimal} /testbench/d3/ahbmi.scanen {-height 15 -radix hexadecimal} /testbench/d3/ahbmi.testoen {-height 15 -radix hexadecimal} /testbench/d3/ahbmi.testin {-height 15 -radix hexadecimal}} /testbench/d3/ahbmi
add wave -noupdate -height 15 -radix hexadecimal -childformat {{/testbench/d3/ahbmo(15) -radix hexadecimal} {/testbench/d3/ahbmo(14) -radix hexadecimal} {/testbench/d3/ahbmo(13) -radix hexadecimal} {/testbench/d3/ahbmo(12) -radix hexadecimal} {/testbench/d3/ahbmo(11) -radix hexadecimal} {/testbench/d3/ahbmo(10) -radix hexadecimal} {/testbench/d3/ahbmo(9) -radix hexadecimal} {/testbench/d3/ahbmo(8) -radix hexadecimal} {/testbench/d3/ahbmo(7) -radix hexadecimal} {/testbench/d3/ahbmo(6) -radix hexadecimal} {/testbench/d3/ahbmo(5) -radix hexadecimal} {/testbench/d3/ahbmo(4) -radix hexadecimal} {/testbench/d3/ahbmo(3) -radix hexadecimal} {/testbench/d3/ahbmo(2) -radix hexadecimal} {/testbench/d3/ahbmo(1) -radix hexadecimal} {/testbench/d3/ahbmo(0) -radix hexadecimal -childformat {{/testbench/d3/ahbmo(0).hbusreq -radix hexadecimal} {/testbench/d3/ahbmo(0).hlock -radix hexadecimal} {/testbench/d3/ahbmo(0).htrans -radix hexadecimal} {/testbench/d3/ahbmo(0).haddr -radix hexadecimal} {/testbench/d3/ahbmo(0).hwrite -radix hexadecimal} {/testbench/d3/ahbmo(0).hsize -radix hexadecimal} {/testbench/d3/ahbmo(0).hburst -radix hexadecimal} {/testbench/d3/ahbmo(0).hprot -radix hexadecimal} {/testbench/d3/ahbmo(0).hwdata -radix hexadecimal} {/testbench/d3/ahbmo(0).hirq -radix hexadecimal} {/testbench/d3/ahbmo(0).hconfig -radix hexadecimal} {/testbench/d3/ahbmo(0).hindex -radix hexadecimal}}}} -expand -subitemconfig {/testbench/d3/ahbmo(15) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(14) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(13) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(12) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(11) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(10) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(9) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(8) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(7) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(6) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(5) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(4) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(3) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(2) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(1) {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(0) {-height 15 -radix hexadecimal -childformat {{/testbench/d3/ahbmo(0).hbusreq -radix hexadecimal} {/testbench/d3/ahbmo(0).hlock -radix hexadecimal} {/testbench/d3/ahbmo(0).htrans -radix hexadecimal} {/testbench/d3/ahbmo(0).haddr -radix hexadecimal} {/testbench/d3/ahbmo(0).hwrite -radix hexadecimal} {/testbench/d3/ahbmo(0).hsize -radix hexadecimal} {/testbench/d3/ahbmo(0).hburst -radix hexadecimal} {/testbench/d3/ahbmo(0).hprot -radix hexadecimal} {/testbench/d3/ahbmo(0).hwdata -radix hexadecimal} {/testbench/d3/ahbmo(0).hirq -radix hexadecimal} {/testbench/d3/ahbmo(0).hconfig -radix hexadecimal} {/testbench/d3/ahbmo(0).hindex -radix hexadecimal}} -expand} /testbench/d3/ahbmo(0).hbusreq {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(0).hlock {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(0).htrans {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(0).haddr {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(0).hwrite {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(0).hsize {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(0).hburst {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(0).hprot {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(0).hwdata {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(0).hirq {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(0).hconfig {-height 15 -radix hexadecimal} /testbench/d3/ahbmo(0).hindex {-height 15 -radix hexadecimal}} /testbench/d3/ahbmo
add wave -noupdate -height 15 -radix hexadecimal /testbench/d3/src/sr0/r
add wave -noupdate -height 15 -radix hexadecimal /testbench/d3/sdc/sdc/r
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1022735761 ps} 0} {{Cursor 2} {910510 ps} 0}
configure wave -namecolwidth 248
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2625 ns}
