onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Testbench}
add wave -noupdate -format Logic /testbench/*
add wave -noupdate -divider {LEON3MP}
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/*
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {141151108 ps} 0}
configure wave -namecolwidth 234
configure wave -valuecolwidth 77
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
WaveRestoreZoom {0 ps} {525 us}
