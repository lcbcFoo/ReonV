# Xilinx Vivado script for LEON/GRLIB
# Create a new project
create_project leon3-zedboard-xc7z020 ./vivado/leon3-zedboard-xc7z020 -part XC7Z020CLG484-1 -force
set_property top testbench [get_filesets sim_1]
set_property target_language verilog [current_project]
# Add files for simulation and synthesis
read_vhdl -library grlib ../../lib/grlib/stdlib/version.vhd
read_vhdl -library grlib ../../lib/grlib/stdlib/config_types.vhd
read_vhdl -library grlib ../../lib/grlib/stdlib/config.vhd
read_vhdl -library grlib ../../lib/grlib/stdlib/stdlib.vhd
read_vhdl -library grlib ../../lib/grlib/stdlib/stdio.vhd
set_property used_in_synthesis false [get_files ../../lib/grlib/stdlib/stdio.vhd]
read_vhdl -library grlib ../../lib/grlib/stdlib/testlib.vhd
set_property used_in_synthesis false [get_files ../../lib/grlib/stdlib/testlib.vhd]
read_vhdl -library grlib ../../lib/grlib/util/util.vhd
set_property used_in_synthesis false [get_files ../../lib/grlib/util/util.vhd]
read_vhdl -library grlib ../../lib/grlib/sparc/sparc.vhd
read_vhdl -library grlib ../../lib/grlib/sparc/sparc_disas.vhd
set_property used_in_synthesis false [get_files ../../lib/grlib/sparc/sparc_disas.vhd]
read_vhdl -library grlib ../../lib/grlib/sparc/cpu_disas.vhd
set_property used_in_synthesis false [get_files ../../lib/grlib/sparc/cpu_disas.vhd]
read_vhdl -library grlib ../../lib/grlib/modgen/multlib.vhd
read_vhdl -library grlib ../../lib/grlib/modgen/leaves.vhd
read_vhdl -library grlib ../../lib/grlib/amba/amba.vhd
read_vhdl -library grlib ../../lib/grlib/amba/devices.vhd
read_vhdl -library grlib ../../lib/grlib/amba/defmst.vhd
read_vhdl -library grlib ../../lib/grlib/amba/apbctrl.vhd
read_vhdl -library grlib ../../lib/grlib/amba/apbctrlx.vhd
read_vhdl -library grlib ../../lib/grlib/amba/apbctrldp.vhd
read_vhdl -library grlib ../../lib/grlib/amba/apbctrlsp.vhd
read_vhdl -library grlib ../../lib/grlib/amba/ahbctrl.vhd
read_vhdl -library grlib ../../lib/grlib/amba/dma2ahb_pkg.vhd
read_vhdl -library grlib ../../lib/grlib/amba/dma2ahb.vhd
read_vhdl -library grlib ../../lib/grlib/amba/ahbmst.vhd
read_vhdl -library grlib ../../lib/grlib/amba/dma2ahb_tp.vhd
set_property used_in_synthesis false [get_files ../../lib/grlib/amba/dma2ahb_tp.vhd]
read_vhdl -library grlib ../../lib/grlib/amba/amba_tp.vhd
set_property used_in_synthesis false [get_files ../../lib/grlib/amba/amba_tp.vhd]
read_vhdl -library grlib ../../lib/grlib/dftlib/dftlib.vhd
read_vhdl -library grlib ../../lib/grlib/dftlib/synciotest.vhd
read_vhdl -library techmap ../../lib/techmap/gencomp/gencomp.vhd
read_vhdl -library techmap ../../lib/techmap/gencomp/netcomp.vhd
read_vhdl -library techmap ../../lib/techmap/inferred/memory_inferred.vhd
read_vhdl -library techmap ../../lib/techmap/inferred/ddr_inferred.vhd
read_vhdl -library techmap ../../lib/techmap/inferred/mul_inferred.vhd
read_vhdl -library techmap ../../lib/techmap/inferred/ddr_phy_inferred.vhd
read_vhdl -library techmap ../../lib/techmap/inferred/ddrphy_datapath.vhd
read_vhdl -library techmap ../../lib/techmap/inferred/fifo_inferred.vhd
read_vhdl -library techmap ../../lib/techmap/inferred/sim_pll.vhd
set_property used_in_synthesis false [get_files ../../lib/techmap/inferred/sim_pll.vhd]
read_vhdl -library techmap ../../lib/techmap/inferred/lpddr2_phy_inferred.vhd
set_property used_in_synthesis false [get_files ../../lib/techmap/inferred/lpddr2_phy_inferred.vhd]
read_vhdl -library techmap ../../lib/techmap/unisim/memory_unisim.vhd
read_vhdl -library techmap ../../lib/techmap/unisim/buffer_unisim.vhd
read_vhdl -library techmap ../../lib/techmap/unisim/pads_unisim.vhd
read_vhdl -library techmap ../../lib/techmap/unisim/clkgen_unisim.vhd
read_vhdl -library techmap ../../lib/techmap/unisim/tap_unisim.vhd
read_vhdl -library techmap ../../lib/techmap/unisim/ddr_unisim.vhd
read_vhdl -library techmap ../../lib/techmap/unisim/ddr_phy_unisim.vhd
read_vhdl -library techmap ../../lib/techmap/unisim/sysmon_unisim.vhd
read_vhdl -library techmap ../../lib/techmap/unisim/mul_unisim.vhd
read_vhdl -library techmap ../../lib/techmap/unisim/spictrl_unisim.vhd
read_vhdl -library techmap ../../lib/techmap/maps/allclkgen.vhd
read_vhdl -library techmap ../../lib/techmap/maps/techbuf.vhd
read_vhdl -library techmap ../../lib/techmap/maps/allddr.vhd
read_vhdl -library techmap ../../lib/techmap/maps/allmem.vhd
read_vhdl -library techmap ../../lib/techmap/maps/allmul.vhd
read_vhdl -library techmap ../../lib/techmap/maps/allpads.vhd
read_vhdl -library techmap ../../lib/techmap/maps/alltap.vhd
read_vhdl -library techmap ../../lib/techmap/maps/clkgen.vhd
read_vhdl -library techmap ../../lib/techmap/maps/clkmux.vhd
read_vhdl -library techmap ../../lib/techmap/maps/clkinv.vhd
read_vhdl -library techmap ../../lib/techmap/maps/clkand.vhd
read_vhdl -library techmap ../../lib/techmap/maps/grgates.vhd
read_vhdl -library techmap ../../lib/techmap/maps/ddr_ireg.vhd
read_vhdl -library techmap ../../lib/techmap/maps/ddr_oreg.vhd
read_vhdl -library techmap ../../lib/techmap/maps/clkpad.vhd
read_vhdl -library techmap ../../lib/techmap/maps/clkpad_ds.vhd
read_vhdl -library techmap ../../lib/techmap/maps/inpad.vhd
read_vhdl -library techmap ../../lib/techmap/maps/inpad_ds.vhd
read_vhdl -library techmap ../../lib/techmap/maps/iodpad.vhd
read_vhdl -library techmap ../../lib/techmap/maps/iopad.vhd
read_vhdl -library techmap ../../lib/techmap/maps/iopad_ds.vhd
read_vhdl -library techmap ../../lib/techmap/maps/lvds_combo.vhd
read_vhdl -library techmap ../../lib/techmap/maps/odpad.vhd
read_vhdl -library techmap ../../lib/techmap/maps/outpad.vhd
read_vhdl -library techmap ../../lib/techmap/maps/outpad_ds.vhd
read_vhdl -library techmap ../../lib/techmap/maps/toutpad.vhd
read_vhdl -library techmap ../../lib/techmap/maps/toutpad_ds.vhd
read_vhdl -library techmap ../../lib/techmap/maps/skew_outpad.vhd
read_vhdl -library techmap ../../lib/techmap/maps/ddrphy.vhd
read_vhdl -library techmap ../../lib/techmap/maps/syncram.vhd
read_vhdl -library techmap ../../lib/techmap/maps/syncram64.vhd
read_vhdl -library techmap ../../lib/techmap/maps/syncram_2p.vhd
read_vhdl -library techmap ../../lib/techmap/maps/syncram_dp.vhd
read_vhdl -library techmap ../../lib/techmap/maps/syncfifo_2p.vhd
read_vhdl -library techmap ../../lib/techmap/maps/regfile_3p.vhd
read_vhdl -library techmap ../../lib/techmap/maps/tap.vhd
read_vhdl -library techmap ../../lib/techmap/maps/nandtree.vhd
read_vhdl -library techmap ../../lib/techmap/maps/grlfpw_net.vhd
read_vhdl -library techmap ../../lib/techmap/maps/grfpw_net.vhd
read_vhdl -library techmap ../../lib/techmap/maps/leon3_net.vhd
read_vhdl -library techmap ../../lib/techmap/maps/leon4_net.vhd
read_vhdl -library techmap ../../lib/techmap/maps/mul_61x61.vhd
read_vhdl -library techmap ../../lib/techmap/maps/cpu_disas_net.vhd
read_vhdl -library techmap ../../lib/techmap/maps/ringosc.vhd
read_vhdl -library techmap ../../lib/techmap/maps/grpci2_phy_net.vhd
read_vhdl -library techmap ../../lib/techmap/maps/system_monitor.vhd
read_vhdl -library techmap ../../lib/techmap/maps/inpad_ddr.vhd
read_vhdl -library techmap ../../lib/techmap/maps/outpad_ddr.vhd
read_vhdl -library techmap ../../lib/techmap/maps/iopad_ddr.vhd
read_vhdl -library techmap ../../lib/techmap/maps/syncram128bw.vhd
read_vhdl -library techmap ../../lib/techmap/maps/syncram256bw.vhd
read_vhdl -library techmap ../../lib/techmap/maps/syncram128.vhd
read_vhdl -library techmap ../../lib/techmap/maps/syncram156bw.vhd
read_vhdl -library techmap ../../lib/techmap/maps/techmult.vhd
read_vhdl -library techmap ../../lib/techmap/maps/spictrl_net.vhd
read_vhdl -library techmap ../../lib/techmap/maps/scanreg.vhd
read_vhdl -library techmap ../../lib/techmap/maps/syncrambw.vhd
read_vhdl -library techmap ../../lib/techmap/maps/syncram_2pbw.vhd
read_vhdl -library techmap ../../lib/techmap/maps/sdram_phy.vhd
read_vhdl -library techmap ../../lib/techmap/maps/syncreg.vhd
read_vhdl -library techmap ../../lib/techmap/maps/serdes.vhd
read_vhdl -library techmap ../../lib/techmap/maps/iopad_tm.vhd
read_vhdl -library techmap ../../lib/techmap/maps/toutpad_tm.vhd
read_vhdl -library techmap ../../lib/techmap/maps/memrwcol.vhd
read_vhdl -library techmap ../../lib/techmap/maps/cdcbus.vhd
read_vhdl -library eth ../../lib/eth/comp/ethcomp.vhd
read_vhdl -library eth ../../lib/eth/core/greth_pkg.vhd
read_vhdl -library eth ../../lib/eth/core/eth_rstgen.vhd
read_vhdl -library eth ../../lib/eth/core/eth_edcl_ahb_mst.vhd
read_vhdl -library eth ../../lib/eth/core/eth_ahb_mst.vhd
read_vhdl -library eth ../../lib/eth/core/greth_tx.vhd
read_vhdl -library eth ../../lib/eth/core/greth_rx.vhd
read_vhdl -library eth ../../lib/eth/core/grethc.vhd
read_vhdl -library eth ../../lib/eth/wrapper/greth_gen.vhd
read_vhdl -library eth ../../lib/eth/wrapper/greth_gbit_gen.vhd
read_vhdl -library opencores ../../lib/opencores/i2c/i2c_master_bit_ctrl.vhd
read_vhdl -library opencores ../../lib/opencores/i2c/i2c_master_byte_ctrl.vhd
read_vhdl -library opencores ../../lib/opencores/i2c/i2coc.vhd
read_verilog -library opencores ../../lib/opencores/ge_1000baseX/clean_rst.v
read_verilog -library opencores ../../lib/opencores/ge_1000baseX/decoder_8b10b.v
read_verilog -library opencores ../../lib/opencores/ge_1000baseX/encoder_8b10b.v
read_verilog -library opencores ../../lib/opencores/ge_1000baseX/ge_1000baseX_constants.v
read_verilog -library opencores ../../lib/opencores/ge_1000baseX/ge_1000baseX_regs.v
read_verilog -library opencores ../../lib/opencores/ge_1000baseX/ge_1000baseX_test.v
read_verilog -library opencores ../../lib/opencores/ge_1000baseX/timescale.v
read_vhdl -library opencores ../../lib/opencores/ge_1000baseX/ge_1000baseX_comp.vhd
read_verilog -library opencores -sv ../../lib/opencores/ge_1000baseX/ge_1000baseX.v
read_verilog -library opencores -sv ../../lib/opencores/ge_1000baseX/ge_1000baseX_an.v
read_verilog -library opencores -sv ../../lib/opencores/ge_1000baseX/ge_1000baseX_mdio.v
read_verilog -library opencores -sv ../../lib/opencores/ge_1000baseX/ge_1000baseX_rx.v
read_verilog -library opencores -sv ../../lib/opencores/ge_1000baseX/ge_1000baseX_sync.v
read_verilog -library opencores -sv ../../lib/opencores/ge_1000baseX/ge_1000baseX_tx.v
read_vhdl -library gaisler ../../lib/gaisler/arith/arith.vhd
read_vhdl -library gaisler ../../lib/gaisler/arith/mul32.vhd
read_vhdl -library gaisler ../../lib/gaisler/arith/div32.vhd
read_vhdl -library gaisler ../../lib/gaisler/memctrl/memctrl.vhd
read_vhdl -library gaisler ../../lib/gaisler/memctrl/sdctrl.vhd
read_vhdl -library gaisler ../../lib/gaisler/memctrl/sdctrl64.vhd
read_vhdl -library gaisler ../../lib/gaisler/memctrl/sdmctrl.vhd
read_vhdl -library gaisler ../../lib/gaisler/memctrl/srctrl.vhd
read_vhdl -library gaisler ../../lib/gaisler/srmmu/mmuconfig.vhd
read_vhdl -library gaisler ../../lib/gaisler/srmmu/mmuiface.vhd
read_vhdl -library gaisler ../../lib/gaisler/srmmu/libmmu.vhd
read_vhdl -library gaisler ../../lib/gaisler/srmmu/mmutlbcam.vhd
read_vhdl -library gaisler ../../lib/gaisler/srmmu/mmulrue.vhd
read_vhdl -library gaisler ../../lib/gaisler/srmmu/mmulru.vhd
read_vhdl -library gaisler ../../lib/gaisler/srmmu/mmutlb.vhd
read_vhdl -library gaisler ../../lib/gaisler/srmmu/mmutw.vhd
read_vhdl -library gaisler ../../lib/gaisler/srmmu/mmu.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3/leon3.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3/grfpushwx.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/tbufmem.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/tbufmem_2p.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/dsu3x.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/dsu3.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/dsu3_mb.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/libfpu.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/libiu.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/libcache.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/libleon3.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/regfile_3p_l3.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/mmu_acache.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/mmu_icache.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/mmu_dcache.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/cachemem.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/mmu_cache.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/grfpwx.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/grlfpwx.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/iu3.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/proc3.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/grfpwxsh.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/leon3x.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/leon3cg.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/leon3s.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/leon3sh.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/l3stat.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon3v3/cmvalidbits.vhd
read_vhdl -library gaisler ../../lib/gaisler/leon4/leon4.vhd
read_vhdl -library gaisler ../../lib/gaisler/irqmp/irqmp.vhd
read_vhdl -library gaisler ../../lib/gaisler/l2cache/pkg/l2cache.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/misc.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/rstgen.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/gptimer.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/ahbram.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/ahbdpram.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/ahbtrace_mmb.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/ahbtrace_mb.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/ahbtrace.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/grgpio.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/ahbstat.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/logan.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/apbps2.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/charrom_package.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/charrom.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/apbvga.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/svgactrl.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/grsysmon.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/gracectrl.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/grgpreg.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/ahb_mst_iface.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/grgprbank.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/apb3cdc.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/ahbsmux.vhd
read_vhdl -library gaisler ../../lib/gaisler/misc/ahbmmux.vhd
read_vhdl -library gaisler ../../lib/gaisler/net/net.vhd
read_vhdl -library gaisler ../../lib/gaisler/uart/uart.vhd
read_vhdl -library gaisler ../../lib/gaisler/uart/libdcom.vhd
read_vhdl -library gaisler ../../lib/gaisler/uart/apbuart.vhd
read_vhdl -library gaisler ../../lib/gaisler/uart/dcom.vhd
read_vhdl -library gaisler ../../lib/gaisler/uart/dcom_uart.vhd
read_vhdl -library gaisler ../../lib/gaisler/uart/ahbuart.vhd
read_vhdl -library gaisler ../../lib/gaisler/sim/sim.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/sim.vhd]
read_vhdl -library gaisler ../../lib/gaisler/sim/sram.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/sram.vhd]
read_vhdl -library gaisler ../../lib/gaisler/sim/sram16.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/sram16.vhd]
read_vhdl -library gaisler ../../lib/gaisler/sim/phy.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/phy.vhd]
read_vhdl -library gaisler ../../lib/gaisler/sim/ser_phy.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/ser_phy.vhd]
read_vhdl -library gaisler ../../lib/gaisler/sim/ahbrep.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/ahbrep.vhd]
read_vhdl -library gaisler ../../lib/gaisler/sim/delay_wire.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/delay_wire.vhd]
read_vhdl -library gaisler ../../lib/gaisler/sim/pwm_check.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/pwm_check.vhd]
read_vhdl -library gaisler ../../lib/gaisler/sim/ddrram.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/ddrram.vhd]
read_vhdl -library gaisler ../../lib/gaisler/sim/ddr2ram.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/ddr2ram.vhd]
read_vhdl -library gaisler ../../lib/gaisler/sim/ddr3ram.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/ddr3ram.vhd]
read_vhdl -library gaisler ../../lib/gaisler/sim/sdrtestmod.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/sdrtestmod.vhd]
read_vhdl -library gaisler ../../lib/gaisler/sim/ahbram_sim.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/ahbram_sim.vhd]
read_vhdl -library gaisler ../../lib/gaisler/sim/aximem.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/aximem.vhd]
read_vhdl -library gaisler ../../lib/gaisler/sim/axirep.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/sim/axirep.vhd]
read_vhdl -library gaisler ../../lib/gaisler/jtag/jtag.vhd
read_vhdl -library gaisler ../../lib/gaisler/jtag/libjtagcom.vhd
read_vhdl -library gaisler ../../lib/gaisler/jtag/jtagcom.vhd
read_vhdl -library gaisler ../../lib/gaisler/jtag/bscanregs.vhd
read_vhdl -library gaisler ../../lib/gaisler/jtag/bscanregsbd.vhd
read_vhdl -library gaisler ../../lib/gaisler/jtag/jtagcom2.vhd
read_vhdl -library gaisler ../../lib/gaisler/jtag/ahbjtag.vhd
read_vhdl -library gaisler ../../lib/gaisler/jtag/ahbjtag_bsd.vhd
read_vhdl -library gaisler ../../lib/gaisler/jtag/jtagtst.vhd
set_property used_in_synthesis false [get_files ../../lib/gaisler/jtag/jtagtst.vhd]
read_vhdl -library gaisler ../../lib/gaisler/greth/ethernet_mac.vhd
read_vhdl -library gaisler ../../lib/gaisler/greth/greth.vhd
read_vhdl -library gaisler ../../lib/gaisler/greth/greth_mb.vhd
read_vhdl -library gaisler ../../lib/gaisler/greth/greth_gbit.vhd
read_vhdl -library gaisler ../../lib/gaisler/greth/greths.vhd
read_vhdl -library gaisler ../../lib/gaisler/greth/greth_gbit_mb.vhd
read_vhdl -library gaisler ../../lib/gaisler/greth/greths_mb.vhd
read_vhdl -library gaisler ../../lib/gaisler/greth/grethm.vhd
read_vhdl -library gaisler ../../lib/gaisler/greth/grethm_mb.vhd
read_vhdl -library gaisler ../../lib/gaisler/greth/adapters/rgmii.vhd
read_vhdl -library gaisler ../../lib/gaisler/greth/adapters/comma_detect.vhd
read_vhdl -library gaisler ../../lib/gaisler/greth/adapters/sgmii.vhd
read_vhdl -library gaisler ../../lib/gaisler/greth/adapters/elastic_buffer.vhd
read_vhdl -library gaisler ../../lib/gaisler/greth/adapters/gmii_to_mii.vhd
read_vhdl -library gaisler ../../lib/gaisler/greth/adapters/word_aligner.vhd
read_vhdl -library gaisler ../../lib/gaisler/axi/axi.vhd
read_vhdl -library gaisler ../../lib/gaisler/axi/ahbm2axi.vhd
read_vhdl -library gaisler ../../lib/gaisler/axi/ahbm2axi3.vhd
read_vhdl -library gaisler ../../lib/gaisler/axi/ahbm2axi4.vhd
read_vhdl -library gaisler ../../lib/gaisler/axi/axinullslv.vhd
read_vhdl -library gaisler ../../lib/gaisler/axi/ahb2axib.vhd
read_vhdl -library gaisler ../../lib/gaisler/axi/ahb2axi3b.vhd
read_vhdl -library gaisler ../../lib/gaisler/axi/ahb2axi4b.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ddrpkg.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ddrintpkg.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ddrphy_wrap.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ddr2spax_ahb.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ddr2spax_ddr.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ddr2buf.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ddr2spax.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ddr2spa.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ddr1spax.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ddr1spax_ddr.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ddrspa.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ahb2mig_7series_pkg.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ahb2mig_7series.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ahb2mig_7series_ddr2_dq16_ad13_ba3.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ahb2mig_7series_ddr3_dq16_ad15_ba3.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ahb2mig_7series_cpci_xc7k.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ahb2axi_mig_7series.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ahb2avl_async.vhd
read_vhdl -library gaisler ../../lib/gaisler/ddr/ahb2avl_async_be.vhd
read_verilog -library gaisler ../../lib/gaisler/ddr/mig_interface_model.v
set_property used_in_synthesis false [get_files ../../lib/gaisler/ddr/mig_interface_model.v]
read_vhdl -library gaisler ../../lib/gaisler/i2c/i2c.vhd
read_vhdl -library gaisler ../../lib/gaisler/i2c/i2cmst.vhd
read_vhdl -library gaisler ../../lib/gaisler/i2c/i2cmst_gen.vhd
read_vhdl -library gaisler ../../lib/gaisler/i2c/i2cslv.vhd
read_vhdl -library gaisler ../../lib/gaisler/i2c/i2c2ahbx.vhd
read_vhdl -library gaisler ../../lib/gaisler/i2c/i2c2ahb.vhd
read_vhdl -library gaisler ../../lib/gaisler/i2c/i2c2ahb_apb.vhd
read_vhdl -library gaisler ../../lib/gaisler/i2c/i2c2ahb_gen.vhd
read_vhdl -library gaisler ../../lib/gaisler/i2c/i2c2ahb_apb_gen.vhd
read_verilog -library gaisler ../../lib/gaisler/i2c/i2c_slave_model.v
set_property used_in_synthesis false [get_files ../../lib/gaisler/i2c/i2c_slave_model.v]
read_vhdl -library gaisler ../../lib/gaisler/grdmac/grdmac_pkg.vhd
read_vhdl -library gaisler ../../lib/gaisler/grdmac/apbmem.vhd
read_vhdl -library gaisler ../../lib/gaisler/grdmac/grdmac_ahbmst.vhd
read_vhdl -library gaisler ../../lib/gaisler/grdmac/grdmac_alignram.vhd
read_vhdl -library gaisler ../../lib/gaisler/grdmac/grdmac.vhd
read_vhdl -library gaisler ../../lib/gaisler/grdmac/grdmac_1p.vhd
read_vhdl -library gaisler ../../lib/gaisler/subsys/subsys.vhd
read_vhdl -library gaisler ../../lib/gaisler/subsys/leon_dsu_stat_base.vhd
read_vhdl -library esa ../../lib/esa/memoryctrl/memoryctrl.vhd
read_vhdl -library esa ../../lib/esa/memoryctrl/mctrl.vhd
read_vhdl -library fmf ../../lib/fmf/utilities/conversions.vhd
set_property used_in_synthesis false [get_files ../../lib/fmf/utilities/conversions.vhd]
read_vhdl -library fmf ../../lib/fmf/utilities/gen_utils.vhd
set_property used_in_synthesis false [get_files ../../lib/fmf/utilities/gen_utils.vhd]
read_vhdl -library fmf ../../lib/fmf/flash/flash.vhd
set_property used_in_synthesis false [get_files ../../lib/fmf/flash/flash.vhd]
read_vhdl -library fmf ../../lib/fmf/flash/s25fl064a.vhd
set_property used_in_synthesis false [get_files ../../lib/fmf/flash/s25fl064a.vhd]
read_vhdl -library fmf ../../lib/fmf/flash/m25p80.vhd
set_property used_in_synthesis false [get_files ../../lib/fmf/flash/m25p80.vhd]
read_vhdl -library fmf ../../lib/fmf/fifo/idt7202.vhd
set_property used_in_synthesis false [get_files ../../lib/fmf/fifo/idt7202.vhd]
read_verilog -library micron ../../lib/micron/sdram/mobile_sdr.v
set_property used_in_synthesis false [get_files ../../lib/micron/sdram/mobile_sdr.v]
read_vhdl -library work ../../lib/work/debug/debug.vhd
set_property used_in_synthesis false [get_files ../../lib/work/debug/debug.vhd]
read_vhdl -library work ../../lib/work/debug/grtestmod.vhd
set_property used_in_synthesis false [get_files ../../lib/work/debug/grtestmod.vhd]
read_vhdl -library work ../../lib/work/debug/cpu_disas.vhd
set_property used_in_synthesis false [get_files ../../lib/work/debug/cpu_disas.vhd]
read_vhdl -library work config.vhd
read_vhdl -library work ahbrom.vhd
read_vhdl -library work ahb2axi.vhd
read_vhdl -library work leon3mp.vhd
read_vhdl -library work leon3_zedboard_stub_sim.vhd
set_property used_in_synthesis false [get_files leon3_zedboard_stub_sim.vhd]
read_vhdl -library work testbench.vhd
set_property used_in_synthesis false [get_files testbench.vhd]
add_files -fileset sim_1 prom.srec ram.srec
# Read board specific constraints
read_xdc leon3mp.xdc
set_property used_in_synthesis true [get_files leon3mp.xdc]
set_property used_in_implementation true [get_files leon3mp.xdc]
source stub.tcl
# Board, part and design properties
set_property target_simulator ModelSim [current_project]
set_property top_lib work [current_fileset]
set_property top_arch rtl [current_fileset]
set_property top leon3mp [current_fileset]
set_property board_part em.avnet.com:zynq:zed:c [current_project]
