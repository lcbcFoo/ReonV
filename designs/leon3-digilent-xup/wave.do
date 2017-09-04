onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/cpu/resetn
add wave -noupdate /testbench/cpu/clk
add wave -noupdate /testbench/cpu/errorn
add wave -noupdate /testbench/cpu/ddr_clk
add wave -noupdate /testbench/cpu/ddr_clkb
add wave -noupdate /testbench/cpu/ddr_clk_fb
add wave -noupdate /testbench/cpu/ddr_clk_fb_out
add wave -noupdate /testbench/cpu/ddr_cke
add wave -noupdate /testbench/cpu/ddr_csb
add wave -noupdate /testbench/cpu/ddr_web
add wave -noupdate /testbench/cpu/ddr_rasb
add wave -noupdate /testbench/cpu/ddr_casb
add wave -noupdate /testbench/cpu/ddr_dm
add wave -noupdate /testbench/cpu/ddr_dqs
add wave -noupdate -radix hexadecimal /testbench/cpu/ddr_ad
add wave -noupdate -radix hexadecimal /testbench/cpu/ddr_ba
add wave -noupdate -radix hexadecimal /testbench/cpu/ddr_dq
add wave -noupdate -radix hexadecimal /testbench/cpu/apbi
add wave -noupdate -radix hexadecimal /testbench/cpu/apbo
add wave -noupdate -radix hexadecimal /testbench/cpu/ahbsi
add wave -noupdate -radix hexadecimal /testbench/cpu/ahbso
add wave -noupdate -radix hexadecimal /testbench/cpu/ahbmi
add wave -noupdate -radix hexadecimal /testbench/cpu/ahbmo
add wave -noupdate /testbench/cpu/clkm
add wave -noupdate /testbench/cpu/rstn
add wave -noupdate /testbench/cpu/ddrlock
add wave -noupdate /testbench/cpu/lock
add wave -noupdate /testbench/cpu/clkml
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10461406 ps} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 151
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
WaveRestoreZoom {10407448 ps} {10535762 ps}
