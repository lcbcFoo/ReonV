onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /testbench/d3/reset
add wave -noupdate -format Logic /testbench/d3/errorn
add wave -noupdate -format Logic /testbench/d3/clk_ref_p
add wave -noupdate -format Logic /testbench/d3/clk_ref_n
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/address
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/data
add wave -noupdate -format Logic /testbench/d3/romsn
add wave -noupdate -format Logic /testbench/d3/oen
add wave -noupdate -format Logic /testbench/d3/writen
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/ddr3_dq
add wave -noupdate -format Literal /testbench/d3/ddr3_dm
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/ddr3_addr
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/ddr3_ba
add wave -noupdate -format Logic /testbench/d3/ddr3_ras_n
add wave -noupdate -format Logic /testbench/d3/ddr3_cas_n
add wave -noupdate -format Logic /testbench/d3/ddr3_we_n
add wave -noupdate -format Logic /testbench/d3/ddr3_reset_n
add wave -noupdate -format Literal /testbench/d3/ddr3_cs_n
add wave -noupdate -format Literal /testbench/d3/ddr3_odt
add wave -noupdate -format Literal /testbench/d3/ddr3_cke
add wave -noupdate -format Literal /testbench/d3/ddr3_dqs_p
add wave -noupdate -format Literal /testbench/d3/ddr3_dqs_n
add wave -noupdate -format Literal /testbench/d3/ddr3_ck_p
add wave -noupdate -format Literal /testbench/d3/ddr3_ck_n
add wave -noupdate -format Logic /testbench/d3/dsubre
add wave -noupdate -format Logic /testbench/d3/dsurx
add wave -noupdate -format Logic /testbench/d3/dsutx
add wave -noupdate -format Logic /testbench/d3/etx_clk
add wave -noupdate -format Logic /testbench/d3/erx_clk
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/erxd
add wave -noupdate -format Logic /testbench/d3/erx_dv
add wave -noupdate -format Logic /testbench/d3/erx_er
add wave -noupdate -format Logic /testbench/d3/erx_col
add wave -noupdate -format Logic /testbench/d3/erx_crs
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/etxd
add wave -noupdate -format Logic /testbench/d3/etx_en
add wave -noupdate -format Logic /testbench/d3/etx_er
add wave -noupdate -format Logic /testbench/d3/emdc
add wave -noupdate -format Logic /testbench/d3/emdio
add wave -noupdate -format Literal /testbench/d3/led
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/apbi
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/apbo
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/ahbsi
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/ahbso
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/ahbmi
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/ahbmo
add wave -noupdate -format Logic /testbench/d3/clkm
add wave -noupdate -format Logic /testbench/d3/rstn
add wave -noupdate -format Logic /testbench/d3/ahb2mig0/clk_ddr
add wave -noupdate -format Logic /testbench/d3/ahb2mig0/clk_ahb
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/ahb2mig0/migi
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/ahb2mig0/migo
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/ahb2mig0/r
add wave -noupdate -format Literal -radix hexadecimal /testbench/d3/ahb2mig0/ra
add wave -noupdate -format Logic /testbench/d3/gmiiclk_p
add wave -noupdate -format Logic /testbench/d3/gmiiclk_n
add wave -noupdate -format Logic /testbench/d3/egtx_clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {54330000 ps} 0} {{Cursor 4} {54335000 ps} 0}
configure wave -namecolwidth 228
configure wave -valuecolwidth 169
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
WaveRestoreZoom {54325843 ps} {54327644 ps}
