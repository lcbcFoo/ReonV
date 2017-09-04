onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Literal /testbench/fabtech
add wave -noupdate -format Literal /testbench/memtech
add wave -noupdate -format Literal /testbench/padtech
add wave -noupdate -format Literal /testbench/clktech
add wave -noupdate -format Literal /testbench/ncpu
add wave -noupdate -format Literal /testbench/disas
add wave -noupdate -format Literal /testbench/dbguart
add wave -noupdate -format Literal /testbench/pclow
add wave -noupdate -format Literal /testbench/clkperiod
add wave -noupdate -format Literal /testbench/romwidth
add wave -noupdate -format Literal /testbench/romdepth
add wave -noupdate -format Logic /testbench/sys_clk
add wave -noupdate -format Logic /testbench/sys_rst_in
add wave -noupdate -format Logic /testbench/sysace_fpga_clk
add wave -noupdate -format Logic /testbench/flash_we_b
add wave -noupdate -format Logic /testbench/flash_wait
add wave -noupdate -format Logic /testbench/flash_reset_b
add wave -noupdate -format Logic /testbench/flash_oe_b
add wave -noupdate -format Literal -radix hexadecimal /testbench/flash_d
add wave -noupdate -format Logic /testbench/flash_clk
add wave -noupdate -format Logic /testbench/flash_ce_b
add wave -noupdate -format Logic /testbench/flash_adv_b
add wave -noupdate -format Literal -radix hexadecimal /testbench/flash_a
add wave -noupdate -format Logic /testbench/sram_bw
add wave -noupdate -format Literal /testbench/sim_d
add wave -noupdate -format Logic /testbench/iosn
add wave -noupdate -format Logic /testbench/dimm1_ddr2_we_b
add wave -noupdate -format Literal /testbench/dimm1_ddr2_s_b
add wave -noupdate -format Logic /testbench/dimm1_ddr2_ras_b
add wave -noupdate -format Logic /testbench/dimm1_ddr2_pll_clkin_p
add wave -noupdate -format Logic /testbench/dimm1_ddr2_pll_clkin_n
add wave -noupdate -format Literal /testbench/dimm1_ddr2_odt
add wave -noupdate -format Literal /testbench/dimm1_ddr2_dqs_p
add wave -noupdate -format Literal /testbench/dimm1_ddr2_dqs_n
add wave -noupdate -format Literal /testbench/dimm1_ddr2_dqm
add wave -noupdate -format Literal /testbench/dimm1_ddr2_dq
add wave -noupdate -format Literal /testbench/dimm1_ddr2_dq2
add wave -noupdate -format Literal /testbench/dimm1_ddr2_cke
add wave -noupdate -format Logic /testbench/dimm1_ddr2_cas_b
add wave -noupdate -format Literal /testbench/dimm1_ddr2_ba
add wave -noupdate -format Literal /testbench/dimm1_ddr2_a
add wave -noupdate -format Logic /testbench/dimm0_ddr2_we_b
add wave -noupdate -format Literal /testbench/dimm0_ddr2_s_b
add wave -noupdate -format Logic /testbench/dimm0_ddr2_ras_b
add wave -noupdate -format Logic /testbench/dimm0_ddr2_pll_clkin_p
add wave -noupdate -format Logic /testbench/dimm0_ddr2_pll_clkin_n
add wave -noupdate -format Literal /testbench/dimm0_ddr2_odt
add wave -noupdate -format Literal /testbench/dimm0_ddr2_dqs_p
add wave -noupdate -format Literal /testbench/dimm0_ddr2_dqs_n
add wave -noupdate -format Literal /testbench/dimm0_ddr2_dqm
add wave -noupdate -format Literal /testbench/dimm0_ddr2_dq
add wave -noupdate -format Literal /testbench/dimm0_ddr2_dq2
add wave -noupdate -format Literal /testbench/dimm0_ddr2_cke
add wave -noupdate -format Logic /testbench/dimm0_ddr2_cas_b
add wave -noupdate -format Literal /testbench/dimm0_ddr2_ba
add wave -noupdate -format Literal /testbench/dimm0_ddr2_a
add wave -noupdate -format Logic /testbench/phy0_txer
add wave -noupdate -format Literal /testbench/phy0_txd
add wave -noupdate -format Logic /testbench/phy0_txctl_txen
add wave -noupdate -format Logic /testbench/phy0_txclk
add wave -noupdate -format Logic /testbench/phy0_rxer
add wave -noupdate -format Literal /testbench/phy0_rxd
add wave -noupdate -format Logic /testbench/phy0_rxctl_rxdv
add wave -noupdate -format Logic /testbench/phy0_rxclk
add wave -noupdate -format Logic /testbench/phy0_reset
add wave -noupdate -format Logic /testbench/phy0_mdio
add wave -noupdate -format Logic /testbench/phy0_mdc
add wave -noupdate -format Literal /testbench/sysace_mpa
add wave -noupdate -format Logic /testbench/sysace_mpce
add wave -noupdate -format Logic /testbench/sysace_mpirq
add wave -noupdate -format Logic /testbench/sysace_mpoe
add wave -noupdate -format Logic /testbench/sysace_mpwe
add wave -noupdate -format Literal /testbench/sysace_mpd
add wave -noupdate -format Literal /testbench/dbg_led
add wave -noupdate -format Logic /testbench/opb_bus_error
add wave -noupdate -format Logic /testbench/plb_bus_error
add wave -noupdate -format Logic /testbench/dvi_xclk_p
add wave -noupdate -format Logic /testbench/dvi_xclk_n
add wave -noupdate -format Logic /testbench/dvi_v
add wave -noupdate -format Logic /testbench/dvi_reset_b
add wave -noupdate -format Logic /testbench/dvi_h
add wave -noupdate -format Logic /testbench/dvi_gpio1
add wave -noupdate -format Logic /testbench/dvi_de
add wave -noupdate -format Literal /testbench/dvi_d
add wave -noupdate -format Logic /testbench/pci_p_trdy_b
add wave -noupdate -format Logic /testbench/pci_p_stop_b
add wave -noupdate -format Logic /testbench/pci_p_serr_b
add wave -noupdate -format Logic /testbench/pci_p_rst_b
add wave -noupdate -format Literal /testbench/pci_p_req_b
add wave -noupdate -format Logic /testbench/pci_p_perr_b
add wave -noupdate -format Logic /testbench/pci_p_par
add wave -noupdate -format Logic /testbench/pci_p_lock_b
add wave -noupdate -format Logic /testbench/pci_p_irdy_b
add wave -noupdate -format Logic /testbench/pci_p_intd_b
add wave -noupdate -format Logic /testbench/pci_p_intc_b
add wave -noupdate -format Logic /testbench/pci_p_intb_b
add wave -noupdate -format Logic /testbench/pci_p_inta_b
add wave -noupdate -format Literal /testbench/pci_p_gnt_b
add wave -noupdate -format Logic /testbench/pci_p_frame_b
add wave -noupdate -format Logic /testbench/pci_p_devsel_b
add wave -noupdate -format Logic /testbench/pci_p_clk5_r
add wave -noupdate -format Logic /testbench/pci_p_clk5
add wave -noupdate -format Logic /testbench/pci_p_clk4_r
add wave -noupdate -format Logic /testbench/pci_p_clk3_r
add wave -noupdate -format Logic /testbench/pci_p_clk1_r
add wave -noupdate -format Logic /testbench/pci_p_clk0_r
add wave -noupdate -format Literal /testbench/pci_p_cbe_b
add wave -noupdate -format Literal /testbench/pci_p_ad
add wave -noupdate -format Logic /testbench/sbr_pwg_rsm_rstj
add wave -noupdate -format Logic /testbench/sbr_nmi_r
add wave -noupdate -format Logic /testbench/sbr_intr_r
add wave -noupdate -format Logic /testbench/sbr_ide_rst_b
add wave -noupdate -format Logic /testbench/iic_sda_dvi
add wave -noupdate -format Logic /testbench/iic_scl_dvi
add wave -noupdate -format Logic /testbench/fpga_sda
add wave -noupdate -format Logic /testbench/fpga_scl
add wave -noupdate -format Logic /testbench/iic_therm_b
add wave -noupdate -format Logic /testbench/iic_reset_b
add wave -noupdate -format Logic /testbench/iic_irq_b
add wave -noupdate -format Logic /testbench/iic_alert_b
add wave -noupdate -format Logic /testbench/spi_data_out
add wave -noupdate -format Logic /testbench/spi_data_in
add wave -noupdate -format Logic /testbench/spi_data_cs_b
add wave -noupdate -format Logic /testbench/spi_clk
add wave -noupdate -format Logic /testbench/uart1_txd
add wave -noupdate -format Logic /testbench/uart1_rxd
add wave -noupdate -format Logic /testbench/uart1_rts_b
add wave -noupdate -format Logic /testbench/uart1_cts_b
add wave -noupdate -format Logic /testbench/uart0_txd
add wave -noupdate -format Logic /testbench/uart0_rxd
add wave -noupdate -format Logic /testbench/uart0_rts_b
add wave -noupdate -divider {CPU 1}
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/apbi
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/apbo
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbsi
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbso
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbmi
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbmo
add wave -noupdate -format Literal /testbench/cpu/cgi
add wave -noupdate -format Literal /testbench/cpu/cgi2
add wave -noupdate -format Literal /testbench/cpu/cgo
add wave -noupdate -format Literal /testbench/cpu/cgo2
add wave -noupdate -format Literal /testbench/cpu/clk_sel
add wave -noupdate -format Logic /testbench/cpu/clkvga
add wave -noupdate -format Literal -expand /testbench/cpu/migsp0/ahb2mig0/migi
add wave -noupdate -format Literal -expand /testbench/cpu/migsp0/ahb2mig0/migo
add wave -noupdate -format Literal -expand /testbench/cpu/migsp0/ahb2mig0/r
add wave -noupdate -format Literal -radix hexadecimal -expand /testbench/cpu/migsp0/ahb2mig0/ra
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/ddr2_dq
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/ddr2_a
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/ddr2_ba
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/ddr2_ras_n
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/ddr2_cas_n
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/ddr2_we_n
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/ddr2_cs_n
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/ddr2_odt
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/ddr2_cke
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/ddr2_dm
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/sys_clk
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/idly_clk_200
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/sys_rst_n
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/phy_init_done
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/rst0_tb
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/clk0_tb
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/app_wdf_afull
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/app_af_afull
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/rd_data_valid
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/app_wdf_wren
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/app_af_wren
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/app_af_addr
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/app_af_cmd
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/rd_data_fifo_out
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/app_wdf_data
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/app_wdf_mask_data
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/ddr2_dqs
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/ddr2_dqs_n
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/ddr2_ck
add wave -noupdate -format Literal /testbench/cpu/migsp0/migv5/ddr2_ck_n
add wave -noupdate -format Logic /testbench/cpu/clkm
add wave -noupdate -format Logic /testbench/cpu/clkm2x
add wave -noupdate -format Logic /testbench/cpu/rstn
add wave -noupdate -format Logic /testbench/cpu/rstraw
add wave -noupdate -format Logic /testbench/cpu/clkddr
add wave -noupdate -format Logic /testbench/cpu/clk_200
add wave -noupdate -format Logic /testbench/cpu/clk25
add wave -noupdate -format Logic /testbench/cpu/clk40
add wave -noupdate -format Logic /testbench/cpu/clk65
add wave -noupdate -format Literal -expand /testbench/cpu/cgi
add wave -noupdate -format Literal /testbench/cpu/cgi3
add wave -noupdate -format Literal /testbench/cpu/cgo3
add wave -noupdate -format Logic /testbench/cpu/clklock
add wave -noupdate -format Logic /testbench/cpu/lock0
add wave -noupdate -format Logic /testbench/cpu/lock1
add wave -noupdate -format Logic /testbench/cpu/lclk
add wave -noupdate -format Logic /testbench/cpu/clkml0
add wave -noupdate -format Logic /testbench/cpu/clkml1
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/u_ddr2_idelay_ctrl/clk200
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/u_ddr2_idelay_ctrl/rst200
add wave -noupdate -format Logic /testbench/cpu/migsp0/migv5/u_ddr2_idelay_ctrl/idelay_ctrl_rdy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {515000 ps} 0} {{Cursor 5} {86792500 ps} 0}
configure wave -namecolwidth 191
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
WaveRestoreZoom {0 ps} {140077875 ps}
