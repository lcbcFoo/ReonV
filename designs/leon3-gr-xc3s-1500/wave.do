onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /testbench/clk
add wave -noupdate -format Logic /testbench/rst
add wave -noupdate -format Logic /testbench/errorn
add wave -noupdate -format Literal -radix hexadecimal /testbench/address
add wave -noupdate -format Literal -radix hexadecimal /testbench/data
add wave -noupdate -format Literal /testbench/ramsn
add wave -noupdate -format Literal /testbench/ramoen
add wave -noupdate -format Literal /testbench/rwen
add wave -noupdate -format Literal /testbench/romsn
add wave -noupdate -format Logic /testbench/iosn
add wave -noupdate -format Logic /testbench/oen
add wave -noupdate -format Logic /testbench/read
add wave -noupdate -format Logic /testbench/writen
add wave -noupdate -format Literal /testbench/sdcke
add wave -noupdate -format Literal /testbench/sdcsn
add wave -noupdate -format Logic /testbench/sdwen
add wave -noupdate -format Logic /testbench/sdrasn
add wave -noupdate -format Logic /testbench/sdcasn
add wave -noupdate -format Literal /testbench/sddqm
add wave -noupdate -format Logic /testbench/sdclk
add wave -noupdate -format Logic /testbench/dsuen
add wave -noupdate -format Logic /testbench/dsubre
add wave -noupdate -format Logic /testbench/dsuact
add wave -noupdate -divider {CPU 1}
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/apbi
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/apbo
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbsi
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbso
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbmi
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbmo
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/dcomgen/dcom0/dcom_uart0/r
add wave -noupdate -format Literal -radix hexadecimal /testbench/from_ata
add wave -noupdate -format Literal -radix hexadecimal /testbench/to_ata
add wave -noupdate -format Logic /testbench/cpu/spw_clk
add wave -noupdate -format Literal /testbench/cpu/spw_rxdp
add wave -noupdate -format Literal /testbench/cpu/spw_rxdn
add wave -noupdate -format Literal /testbench/cpu/spw_rxsp
add wave -noupdate -format Literal /testbench/cpu/spw_rxsn
add wave -noupdate -format Literal /testbench/cpu/spw_txdp
add wave -noupdate -format Literal /testbench/cpu/spw_txdn
add wave -noupdate -format Literal /testbench/cpu/spw_txsp
add wave -noupdate -format Literal /testbench/cpu/spw_txsn
add wave -noupdate -format Logic /testbench/wdogn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {869597000 ps} 0}
configure wave -namecolwidth 162
configure wave -valuecolwidth 110
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
update
WaveRestoreZoom {805588699 ps} {850580882 ps}
