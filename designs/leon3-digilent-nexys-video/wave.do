onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 15 /testbench/d3/rstn
add wave -noupdate -height 15 /testbench/led
add wave -noupdate -divider {CPU 1}
add wave -noupdate -height 15 /testbench/d3/clkm
add wave -noupdate -height 15 -radix hexadecimal /testbench/d3/apbi
add wave -noupdate -height 15 -radix hexadecimal /testbench/d3/apbo
add wave -noupdate -height 15 -radix hexadecimal /testbench/d3/ahbsi
add wave -noupdate -height 15 -radix hexadecimal /testbench/d3/ahbso
add wave -noupdate -height 15 -radix hexadecimal /testbench/d3/ahbmi
add wave -noupdate -height 15 -radix hexadecimal /testbench/d3/ahbmo
add wave -noupdate -height 15 /testbench/fabtech
add wave -noupdate -height 15 /testbench/memtech
add wave -noupdate -height 15 /testbench/padtech
add wave -noupdate -height 15 /testbench/clktech
add wave -noupdate -height 15 /testbench/disas
add wave -noupdate -height 15 /testbench/dbguart
add wave -noupdate -height 15 /testbench/pclow
add wave -noupdate -height 15 /testbench/USE_MIG_INTERFACE_MODEL
add wave -noupdate -height 15 /testbench/clkperiod
add wave -noupdate -height 15 /testbench/sysclk
add wave -noupdate -height 15 /testbench/led
add wave -noupdate -height 15 /testbench/btnc
add wave -noupdate -height 15 /testbench/btnd
add wave -noupdate -height 15 /testbench/btnl
add wave -noupdate -height 15 /testbench/btnr
add wave -noupdate -height 15 /testbench/cpu_resetn
add wave -noupdate -height 15 /testbench/sw
add wave -noupdate -height 15 /testbench/uart_tx_in
add wave -noupdate -height 15 /testbench/uart_rx_out
add wave -noupdate -height 15 /testbench/ddr3_dq
add wave -noupdate -height 15 /testbench/ddr3_dqs_p
add wave -noupdate -height 15 /testbench/ddr3_dqs_n
add wave -noupdate -height 15 /testbench/ddr3_addr
add wave -noupdate -height 15 /testbench/ddr3_ba
add wave -noupdate -height 15 /testbench/ddr3_ras_n
add wave -noupdate -height 15 /testbench/ddr3_cas_n
add wave -noupdate -height 15 /testbench/ddr3_we_n
add wave -noupdate -height 15 /testbench/ddr3_reset_n
add wave -noupdate -height 15 /testbench/ddr3_ck_p
add wave -noupdate -height 15 /testbench/ddr3_ck_n
add wave -noupdate -height 15 /testbench/ddr3_cke
add wave -noupdate -height 15 /testbench/ddr3_dm
add wave -noupdate -height 15 /testbench/ddr3_odt
add wave -noupdate -height 15 /testbench/fan_pwm
add wave -noupdate -height 15 /testbench/qspi_cs
add wave -noupdate -height 15 /testbench/qspi_dq
add wave -noupdate -height 15 /testbench/scl
add wave -noupdate -height 15 /testbench/gnd
add wave -noupdate -height 15 /testbench/promfile
add wave -noupdate -height 15 /testbench/sdramfile
add wave -noupdate -height 15 /testbench/ct
add wave -noupdate -height 15 /testbench/SIM_BYPASS_INIT_CAL
add wave -noupdate -height 15 /testbench/SIMULATION
add wave -noupdate -height 15 /testbench/d3/sysclk
add wave -noupdate -height 15 /testbench/d3/led
add wave -noupdate -height 15 /testbench/d3/btnc
add wave -noupdate -height 15 /testbench/d3/btnd
add wave -noupdate -height 15 /testbench/d3/btnl
add wave -noupdate -height 15 /testbench/d3/btnr
add wave -noupdate -height 15 /testbench/d3/cpu_resetn
add wave -noupdate -height 15 /testbench/d3/sw
add wave -noupdate -height 15 /testbench/d3/uart_tx_in
add wave -noupdate -height 15 /testbench/d3/uart_rx_out
add wave -noupdate -height 15 /testbench/d3/ddr3_dq
add wave -noupdate -height 15 /testbench/d3/ddr3_dqs_p
add wave -noupdate -height 15 /testbench/d3/ddr3_dqs_n
add wave -noupdate /testbench/d3/ddr3_addr
add wave -noupdate /testbench/d3/ddr3_ba
add wave -noupdate /testbench/d3/ddr3_ras_n
add wave -noupdate /testbench/d3/ddr3_cas_n
add wave -noupdate /testbench/d3/ddr3_we_n
add wave -noupdate /testbench/d3/ddr3_reset_n
add wave -noupdate /testbench/d3/ddr3_ck_p
add wave -noupdate /testbench/d3/ddr3_ck_n
add wave -noupdate /testbench/d3/ddr3_cke
add wave -noupdate /testbench/d3/ddr3_dm
add wave -noupdate /testbench/d3/ddr3_odt
add wave -noupdate /testbench/d3/fan_pwm
add wave -noupdate /testbench/d3/qspi_cs
add wave -noupdate /testbench/d3/qspi_dq
add wave -noupdate /testbench/d3/scl
add wave -noupdate /testbench/d3/vcc
add wave -noupdate /testbench/d3/gnd
add wave -noupdate /testbench/d3/gpioi
add wave -noupdate /testbench/d3/gpioo
add wave -noupdate /testbench/d3/apbi
add wave -noupdate /testbench/d3/apbo
add wave -noupdate /testbench/d3/ahbsi
add wave -noupdate /testbench/d3/ahbso
add wave -noupdate /testbench/d3/ahbmi
add wave -noupdate /testbench/d3/ahbmo
add wave -noupdate /testbench/d3/cgi
add wave -noupdate /testbench/d3/cgo
add wave -noupdate /testbench/d3/cgo1
add wave -noupdate /testbench/d3/u1i
add wave -noupdate /testbench/d3/dui
add wave -noupdate /testbench/d3/u1o
add wave -noupdate /testbench/d3/duo
add wave -noupdate /testbench/d3/irqi
add wave -noupdate /testbench/d3/irqo
add wave -noupdate /testbench/d3/dbgi
add wave -noupdate /testbench/d3/dbgo
add wave -noupdate /testbench/d3/dsui
add wave -noupdate /testbench/d3/dsuo
add wave -noupdate /testbench/d3/ndsuact
add wave -noupdate /testbench/d3/ethi
add wave -noupdate /testbench/d3/etho
add wave -noupdate /testbench/d3/gpti
add wave -noupdate /testbench/d3/spmi
add wave -noupdate /testbench/d3/spmo
add wave -noupdate /testbench/d3/clkm
add wave -noupdate /testbench/d3/clkm2x
add wave -noupdate /testbench/d3/rstn
add wave -noupdate /testbench/d3/tck
add wave -noupdate /testbench/d3/tms
add wave -noupdate /testbench/d3/tdi
add wave -noupdate /testbench/d3/tdo
add wave -noupdate /testbench/d3/rstraw
add wave -noupdate /testbench/d3/lcpu_resetn
add wave -noupdate /testbench/d3/lock
add wave -noupdate /testbench/d3/clkinmig
add wave -noupdate /testbench/d3/clkref
add wave -noupdate /testbench/d3/calib_done
add wave -noupdate /testbench/d3/migrstn
add wave -noupdate /testbench/d3/rxd1
add wave -noupdate /testbench/d3/txd1
add wave -noupdate /testbench/d3/BOARD_FREQ
add wave -noupdate /testbench/d3/CPU_FREQ
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {141151108000 fs} 0}
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
WaveRestoreZoom {0 fs} {525 us}
