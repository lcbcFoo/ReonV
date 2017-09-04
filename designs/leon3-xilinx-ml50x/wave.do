onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/sys_clk
add wave -noupdate /testbench/sys_rst_in
add wave -noupdate -radix hexadecimal /testbench/address
add wave -noupdate -radix hexadecimal /testbench/data
add wave -noupdate /testbench/sram_cen
add wave -noupdate /testbench/sram_bw
add wave -noupdate /testbench/sram_flash_we_n
add wave -noupdate /testbench/sram_clk
add wave -noupdate /testbench/sram_clk_fb
add wave -noupdate /testbench/sram_mode
add wave -noupdate /testbench/sram_adv_ld_n
add wave -noupdate /testbench/ddr_clk
add wave -noupdate /testbench/ddr_clkb
add wave -noupdate /testbench/ddr_cke
add wave -noupdate /testbench/ddr_csb
add wave -noupdate /testbench/ddr_web
add wave -noupdate /testbench/ddr_rasb
add wave -noupdate /testbench/ddr_casb
add wave -noupdate /testbench/ddr_dm
add wave -noupdate -radix hexadecimal /testbench/ddr_dq
add wave -noupdate -radix hexadecimal /testbench/ddr_ad
add wave -noupdate -radix hexadecimal /testbench/ddr_ba
add wave -noupdate -divider {CPU 1}
add wave -noupdate -radix hexadecimal /testbench/cpu/apbi
add wave -noupdate -radix hexadecimal /testbench/cpu/apbo
add wave -noupdate -radix hexadecimal /testbench/cpu/ahbsi
add wave -noupdate -radix hexadecimal /testbench/cpu/ahbso
add wave -noupdate -radix hexadecimal /testbench/cpu/ahbmi
add wave -noupdate -radix hexadecimal /testbench/cpu/ahbmo
add wave -noupdate /testbench/cpu/cgi
add wave -noupdate /testbench/cpu/cgi2
add wave -noupdate /testbench/cpu/cgo
add wave -noupdate /testbench/cpu/cgo2
add wave -noupdate /testbench/cpu/ps2_mouse_clk
add wave -noupdate /testbench/cpu/ps2_mouse_data
add wave -noupdate /testbench/cpu/clk_sel
add wave -noupdate /testbench/cpu/clkvga
add wave -noupdate /testbench/cpu/phy_gtx_clk
add wave -noupdate /testbench/cpu/phy_mii_data
add wave -noupdate /testbench/cpu/phy_tx_clk
add wave -noupdate /testbench/cpu/phy_rx_clk
add wave -noupdate -radix hexadecimal /testbench/cpu/phy_rx_data
add wave -noupdate /testbench/cpu/phy_dv
add wave -noupdate /testbench/cpu/phy_rx_er
add wave -noupdate /testbench/cpu/phy_col
add wave -noupdate /testbench/cpu/phy_crs
add wave -noupdate -radix hexadecimal /testbench/cpu/phy_tx_data
add wave -noupdate /testbench/cpu/phy_tx_en
add wave -noupdate /testbench/cpu/phy_tx_er
add wave -noupdate /testbench/cpu/phy_mii_clk
add wave -noupdate /testbench/cpu/phy_rst_n
add wave -noupdate -radix hexadecimal /testbench/cpu/migi
add wave -noupdate -radix hexadecimal /testbench/cpu/migo
add wave -noupdate /testbench/cpu/phy_init_done
add wave -noupdate /testbench/cpu/clk0_tb
add wave -noupdate /testbench/cpu/rst0_tb
add wave -noupdate /testbench/cpu/rst0_tbn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {52212589 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {157518816 ps} {158558471 ps}
