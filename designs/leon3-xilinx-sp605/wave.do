onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /testbench/cpu/address
add wave -noupdate -radix hexadecimal /testbench/cpu/data
add wave -noupdate /testbench/cpu/oen
add wave -noupdate /testbench/cpu/writen
add wave -noupdate /testbench/cpu/romsn
add wave -noupdate /testbench/cpu/ddr_clk
add wave -noupdate /testbench/cpu/ddr_clkb
add wave -noupdate /testbench/cpu/ddr_cke
add wave -noupdate /testbench/cpu/ddr_odt
add wave -noupdate /testbench/cpu/ddr_reset_n
add wave -noupdate /testbench/cpu/ddr_we
add wave -noupdate /testbench/cpu/ddr_ras
add wave -noupdate /testbench/cpu/ddr_cas
add wave -noupdate /testbench/cpu/ddr_dm
add wave -noupdate /testbench/cpu/ddr_dqs
add wave -noupdate /testbench/cpu/ddr_dqs_n
add wave -noupdate -radix hexadecimal /testbench/cpu/ddr_ad
add wave -noupdate -radix hexadecimal /testbench/cpu/ddr_ba
add wave -noupdate -radix hexadecimal /testbench/cpu/ddr_dq
add wave -noupdate /testbench/cpu/ddr_rzq
add wave -noupdate /testbench/cpu/ddr_zio
add wave -noupdate /testbench/cpu/txd1
add wave -noupdate /testbench/cpu/rxd1
add wave -noupdate /testbench/cpu/ctsn1
add wave -noupdate /testbench/cpu/rtsn1
add wave -noupdate /testbench/cpu/switch
add wave -noupdate /testbench/cpu/led
add wave -noupdate /testbench/cpu/iic_scl
add wave -noupdate /testbench/cpu/iic_sda
add wave -noupdate /testbench/cpu/ddc_scl
add wave -noupdate /testbench/cpu/ddc_sda
add wave -noupdate /testbench/cpu/dvi_iic_scl
add wave -noupdate /testbench/cpu/dvi_iic_sda
add wave -noupdate /testbench/cpu/tft_lcd_data
add wave -noupdate /testbench/cpu/tft_lcd_clk_p
add wave -noupdate /testbench/cpu/tft_lcd_clk_n
add wave -noupdate /testbench/cpu/tft_lcd_hsync
add wave -noupdate /testbench/cpu/tft_lcd_vsync
add wave -noupdate /testbench/cpu/tft_lcd_de
add wave -noupdate /testbench/cpu/tft_lcd_reset_b
add wave -noupdate /testbench/cpu/spi_sel_n
add wave -noupdate /testbench/cpu/spi_clk
add wave -noupdate /testbench/cpu/spi_mosi
add wave -noupdate -radix hexadecimal /testbench/cpu/apbi
add wave -noupdate -radix hexadecimal /testbench/cpu/apbo
add wave -noupdate -radix hexadecimal /testbench/cpu/ahbsi
add wave -noupdate -radix hexadecimal /testbench/cpu/ahbso
add wave -noupdate -radix hexadecimal /testbench/cpu/ahbmi
add wave -noupdate -radix hexadecimal /testbench/cpu/ahbmo
add wave -noupdate /testbench/cpu/clkm
add wave -noupdate /testbench/cpu/rstn
add wave -noupdate /testbench/cpu/rstraw
add wave -noupdate /testbench/cpu/mig_gen/ddrc/MCB_inst/c3_sys_clk
add wave -noupdate /testbench/cpu/mig_gen/ddrc/MCB_inst/c3_calib_done
add wave -noupdate /testbench/cpu/vgadvi/dvi0/clk
add wave -noupdate /testbench/cpu/vgadvi/dvi0/vgao
add wave -noupdate /testbench/cpu/vgadvi/dvi0/vgaclk
add wave -noupdate /testbench/cpu/vgadvi/dvi0/dclk_p
add wave -noupdate /testbench/cpu/vgadvi/dvi0/dclk_n
add wave -noupdate /testbench/cpu/svga/svga0/vgaclk
add wave -noupdate -radix hexadecimal /testbench/cpu/svga/svga0/vgao
add wave -noupdate -radix hexadecimal /testbench/cpu/svga/svga0/clk_sel
add wave -noupdate -radix hexadecimal /testbench/cpu/svga/svga0/t
add wave -noupdate -radix hexadecimal /testbench/cpu/svga/svga0/r
add wave -noupdate -radix hexadecimal /testbench/cpu/svga/svga0/dmai
add wave -noupdate -radix hexadecimal /testbench/cpu/svga/svga0/dmao
add wave -noupdate /testbench/cpu/mig_gen/ddrc/calib_done
add wave -noupdate -radix hexadecimal /testbench/cpu/mig_gen/ddrc/r
add wave -noupdate -radix hexadecimal /testbench/cpu/mig_gen/ddrc/i
add wave -noupdate -radix hexadecimal /testbench/cpu/mig_gen/ddrc/ahbmi
add wave -noupdate -radix hexadecimal /testbench/cpu/mig_gen/ddrc/ahbmo
add wave -noupdate -radix hexadecimal /testbench/cpu/mig_gen/ddrc/r2
add wave -noupdate -radix hexadecimal /testbench/cpu/mig_gen/ddrc/p2
add wave -noupdate /testbench/cpu/phy_gtx_clk
add wave -noupdate /testbench/cpu/phy_mii_data
add wave -noupdate /testbench/cpu/phy_tx_clk
add wave -noupdate /testbench/cpu/phy_rx_clk
add wave -noupdate /testbench/cpu/phy_rx_data
add wave -noupdate /testbench/cpu/phy_dv
add wave -noupdate /testbench/cpu/phy_rx_er
add wave -noupdate /testbench/cpu/phy_col
add wave -noupdate /testbench/cpu/phy_crs
add wave -noupdate /testbench/cpu/phy_tx_data
add wave -noupdate /testbench/cpu/phy_tx_en
add wave -noupdate /testbench/cpu/phy_tx_er
add wave -noupdate /testbench/cpu/phy_mii_clk
add wave -noupdate /testbench/cpu/phy_rst_n
add wave -noupdate /testbench/cpu/egtx_clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {3787500 ps} 0} {{Cursor 3} {3807500 ps} 0}
configure wave -namecolwidth 212
configure wave -valuecolwidth 100
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
WaveRestoreZoom {48575 ps} {76724 ps}
