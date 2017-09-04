onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Testbench top-level}
add wave -noupdate -format Literal /testbench/fabtech
add wave -noupdate -format Literal /testbench/memtech
add wave -noupdate -format Literal /testbench/padtech
add wave -noupdate -format Literal /testbench/clktech
add wave -noupdate -format Literal /testbench/ncpu
add wave -noupdate -format Literal /testbench/disas
add wave -noupdate -format Literal /testbench/dbguart
add wave -noupdate -format Literal /testbench/pclow
add wave -noupdate -format Literal /testbench/clkperiod
add wave -noupdate -format Logic /testbench/cpu_rst_n
add wave -noupdate -format Logic /testbench/clk_fpga_50m
add wave -noupdate -format Literal /testbench/ram_a
add wave -noupdate -format Logic /testbench/ram_ck_p
add wave -noupdate -format Logic /testbench/ram_ck_n
add wave -noupdate -format Logic /testbench/ram_cke
add wave -noupdate -format Logic /testbench/ram_cs_n
add wave -noupdate -format Logic /testbench/ram_ws_n
add wave -noupdate -format Logic /testbench/ram_ras_n
add wave -noupdate -format Logic /testbench/ram_cas_n
add wave -noupdate -format Literal /testbench/ram_dm
add wave -noupdate -format Literal /testbench/ram_dqs
add wave -noupdate -format Literal /testbench/ram_ba
add wave -noupdate -format Literal /testbench/ram_d
add wave -noupdate -format Literal /testbench/txd
add wave -noupdate -format Literal /testbench/rxd
add wave -noupdate -format Logic /testbench/tx_clk
add wave -noupdate -format Logic /testbench/rx_clk
add wave -noupdate -format Logic /testbench/tx_en
add wave -noupdate -format Logic /testbench/rx_dv
add wave -noupdate -format Logic /testbench/eth_crs
add wave -noupdate -format Logic /testbench/rx_er
add wave -noupdate -format Logic /testbench/eth_col
add wave -noupdate -format Logic /testbench/mdio
add wave -noupdate -format Logic /testbench/mdc
add wave -noupdate -format Logic /testbench/eth_reset_n
add wave -noupdate -format Logic /testbench/temp_sc
add wave -noupdate -format Logic /testbench/temp_cs_n
add wave -noupdate -format Logic /testbench/temp_sio
add wave -noupdate -format Literal /testbench/f_led
add wave -noupdate -format Logic /testbench/pbsw_n
add wave -noupdate -format Literal /testbench/reconfig_sw
add wave -noupdate -format Logic /testbench/sd_dat0
add wave -noupdate -format Logic /testbench/sd_dat1
add wave -noupdate -format Logic /testbench/sd_dat2
add wave -noupdate -format Logic /testbench/sd_dat3
add wave -noupdate -format Logic /testbench/sd_cmd
add wave -noupdate -format Logic /testbench/sd_clk
add wave -noupdate -format Logic /testbench/phy_tx_er
add wave -noupdate -format Logic /testbench/phy_gtx_clk
add wave -noupdate -format Literal /testbench/txdt
add wave -noupdate -format Literal /testbench/rxdt
add wave -noupdate -divider {CPU 1}
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/p0/iu0/ici
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/p0/iu0/ico
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/p0/iu0/dci
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/p0/iu0/dco
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/p0/iu0/rfi
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/p0/iu0/rfo
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/p0/iu0/irqi
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/p0/iu0/irqo
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/p0/iu0/dbgi
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/p0/iu0/dbgo
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/p0/iu0/r
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/p0/iu0/wpr
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/p0/iu0/dsur
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/p0/iu0/ir
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/cmem0/crami
add wave -noupdate -format Literal -height 15 -radix hexadecimal /testbench/d3/l3/cpu__0/u0/cmem0/cramo
add wave -noupdate -divider AMBA
add wave -noupdate -format Literal -height 15 /testbench/d3/apbi
add wave -noupdate -format Literal -height 15 /testbench/d3/apbo
add wave -noupdate -format Literal -height 15 /testbench/d3/ahbsi
add wave -noupdate -format Literal -height 15 /testbench/d3/ahbso
add wave -noupdate -format Literal -height 15 /testbench/d3/ahbmi
add wave -noupdate -format Literal -height 15 /testbench/d3/ahbmo
add wave -noupdate -format Logic -height 15 /testbench/d3/clkm
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {119390198 ps} 0}
configure wave -namecolwidth 314
configure wave -valuecolwidth 136
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
WaveRestoreZoom {0 ps} {16767909732 ps}
