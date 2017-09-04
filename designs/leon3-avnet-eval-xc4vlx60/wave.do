onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk50
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/Rst
add wave -noupdate -radix hexadecimal /testbench/address
add wave -noupdate -radix hexadecimal /testbench/data
add wave -noupdate /testbench/romsn
add wave -noupdate /testbench/oen
add wave -noupdate /testbench/writen
add wave -noupdate /testbench/ddr_clk
add wave -noupdate /testbench/ddr_clkb
add wave -noupdate /testbench/ddr_cke
add wave -noupdate /testbench/ddr_clk_fb
add wave -noupdate /testbench/d3/clkm
add wave -noupdate /testbench/ddr_csb
add wave -noupdate /testbench/ddr_web
add wave -noupdate /testbench/ddr_rasb
add wave -noupdate /testbench/ddr_casb
add wave -noupdate /testbench/ddr_dm
add wave -noupdate /testbench/ddr_dqs
add wave -noupdate -radix hexadecimal /testbench/ddr_ad
add wave -noupdate -radix hexadecimal /testbench/ddr_ba
add wave -noupdate -radix hexadecimal /testbench/ddr_dq
add wave -noupdate -radix hexadecimal /testbench/d3/sdi
add wave -noupdate -radix hexadecimal /testbench/d3/sdo
add wave -noupdate -radix hexadecimal /testbench/d3/ahbsi
add wave -noupdate -radix hexadecimal /testbench/d3/ahbso
add wave -noupdate -radix hexadecimal /testbench/d3/ahbmi
add wave -noupdate -radix hexadecimal /testbench/d3/ahbmo
add wave -noupdate -radix hexadecimal /testbench/d3/apbi
add wave -noupdate -radix hexadecimal /testbench/d3/apbo
add wave -noupdate /testbench/d3/clkml
add wave -noupdate /testbench/d3/migsp0/ahb2mig0/rst_ddr
add wave -noupdate /testbench/d3/migsp0/ahb2mig0/rst_ahb
add wave -noupdate /testbench/d3/migsp0/ahb2mig0/clk_ddr
add wave -noupdate /testbench/d3/migsp0/ahb2mig0/clk_ahb
add wave -noupdate -radix hexadecimal /testbench/d3/migsp0/ahb2mig0/migi
add wave -noupdate -radix hexadecimal -childformat {{/testbench/d3/migsp0/ahb2mig0/migo.app_af_afull -radix hexadecimal} {/testbench/d3/migsp0/ahb2mig0/migo.app_wdf_afull -radix hexadecimal} {/testbench/d3/migsp0/ahb2mig0/migo.app_rd_data -radix hexadecimal} {/testbench/d3/migsp0/ahb2mig0/migo.app_rd_data_valid -radix hexadecimal}} -expand -subitemconfig {/testbench/d3/migsp0/ahb2mig0/migo.app_af_afull {-height 16 -radix hexadecimal} /testbench/d3/migsp0/ahb2mig0/migo.app_wdf_afull {-height 16 -radix hexadecimal} /testbench/d3/migsp0/ahb2mig0/migo.app_rd_data {-height 16 -radix hexadecimal} /testbench/d3/migsp0/ahb2mig0/migo.app_rd_data_valid {-height 16 -radix hexadecimal}} /testbench/d3/migsp0/ahb2mig0/migo
add wave -noupdate -radix hexadecimal /testbench/d3/migsp0/ahb2mig0/r
add wave -noupdate -radix hexadecimal /testbench/d3/migsp0/ahb2mig0/ra
add wave -noupdate /testbench/d3/migsp0/migv5/init_done
add wave -noupdate /testbench/d3/migsp0/migv5/sys_reset_in_n
add wave -noupdate /testbench/d3/migsp0/migv5/cntrl0_clk_tb
add wave -noupdate /testbench/d3/migsp0/migv5/cntrl0_reset_tb
add wave -noupdate /testbench/d3/cgi
add wave -noupdate -expand /testbench/d3/cgo
add wave -noupdate /testbench/d3/lock
add wave -noupdate /testbench/d3/migrst
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {38711250 ps} 0} {{Cursor 2} {1300100 ps} 0}
configure wave -namecolwidth 179
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
WaveRestoreZoom {0 ps} {27405660 ps}
