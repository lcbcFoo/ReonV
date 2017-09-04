include .config
GRLIB=../..
TOP=leon3mp
ifeq ("$(CONFIG_LEON4)","y")
GRLIB_CONFIG=grlib_config_leon4.vhd
endif
BOARD=xilinx-ml50x
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
UCF=leon3mp.ucf

ifeq ("$(CONFIG_MIG_DDR2)","y")
ifeq ("$(CONFIG_BOARD_ML505)","y")
UCF+=ml505_mig.ucf
DESIGN=leon-xilinx-ml505
endif
ifeq ("$(CONFIG_BOARD_ML506)","y")
UCF+=ml506_mig.ucf
DESIGN=leon-xilinx-ml506
endif
ifeq ("$(CONFIG_BOARD_ML507)","y")
UCF+=ml507_mig.ucf
DESIGN=leon-xilinx-ml507
endif
ifeq ("$(CONFIG_BOARD_ML509)","y")
UCF+=ml509_mig.ucf
DESIGN=leon-xilinx-ml509
endif
endif

ifeq ("$(CONFIG_DDR2SP)","y")
UCF+=ddr2spa.ucf
endif
ifeq ("$(CONFIG_GRETH_GIGA)","y")
UCF+=greth1g.ucf
endif
ifeq ("$(CONFIG_SVGA_ENABLE)","y")
UCF+=svga.ucf
endif

UCF_PLANAHEAD=$(UCF)

XSTOPT=-uc leon3mp.xcf
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
ISEMAPOPT=-m
SYNPOPT="set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"
VERILOGOPTSYNFILES= \
	pcie/endpoint_blk_plus_v1_14/source/use_newinterrupt.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_blk_if.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_blk_ll.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_blk_ll_tx.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_blk_ll_tx_arb.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_blk_plus_ll_tx.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_blk_plus_ll_rx.v \
	pcie/endpoint_blk_plus_v1_14/source/tlm_rx_data_snk.v \
	pcie/endpoint_blk_plus_v1_14/source/tlm_rx_data_snk_mal.v \
	pcie/endpoint_blk_plus_v1_14/source/tlm_rx_data_snk_bar.v \
	pcie/endpoint_blk_plus_v1_14/source/tlm_rx_data_snk_pwr_mgmt.v \
	pcie/endpoint_blk_plus_v1_14/source/cmm_decoder.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_blk_ll_oqbqfifo.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_blk_ll_arb.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_blk_ll_credit.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_blk_cf.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_blk_cf_mgmt.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_blk_cf_err.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_blk_cf_pwr.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_blk_cf_arb.v \
	pcie/endpoint_blk_plus_v1_14/source/cmm_errman_cnt_en.v \
	pcie/endpoint_blk_plus_v1_14/source/cmm_errman_cnt_nfl_en.v \
	pcie/endpoint_blk_plus_v1_14/source/cmm_errman_cor.v \
	pcie/endpoint_blk_plus_v1_14/source/cmm_errman_cpl.v \
	pcie/endpoint_blk_plus_v1_14/source/cmm_errman_ftl.v \
	pcie/endpoint_blk_plus_v1_14/source/cmm_errman_nfl.v \
	pcie/endpoint_blk_plus_v1_14/source/cmm_errman_ram4x26.v \
	pcie/endpoint_blk_plus_v1_14/source/cmm_errman_ram8x26.v \
	pcie/endpoint_blk_plus_v1_14/source/cmm_intr.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_soft_int.v \
	pcie/endpoint_blk_plus_v1_14/source/bram_common.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_clocking.v \
	pcie/endpoint_blk_plus_v1_14/source/tx_sync_gtx.v \
	pcie/endpoint_blk_plus_v1_14/source/tx_sync_gtp.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_gtx_wrapper.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_gt_wrapper.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_gt_wrapper_top.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_mim_wrapper.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_reset_logic.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_top.v \
	pcie/endpoint_blk_plus_v1_14/source/prod_fixes.v \
	pcie/endpoint_blk_plus_v1_14/source/sync_fifo.v  \
	pcie/endpoint_blk_plus_v1_14/source/extend_clk.v \
	pcie/endpoint_blk_plus_v1_14/source/pcie_ep.v \
	pcie/endpoint_blk_plus_v1_14/source/endpoint_blk_plus_v1_14.v \
	$$XILINX/verilog/src/glbl.v

VHDLOPTSYNFILES= \
	mig_36_1/user_design/rtl/ddr2_chipscope.vhd \
	mig_36_1/user_design/rtl/ddr2_ctrl.vhd \
	mig_36_1/user_design/rtl/ddr2_idelay_ctrl.vhd \
	mig_36_1/user_design/rtl/ddr2_infrastructure.vhd \
	mig_36_1/user_design/rtl/ddr2_mem_if_top.vhd \
	mig_36_1/user_design/rtl/ddr2_phy_calib.vhd \
	mig_36_1/user_design/rtl/ddr2_phy_ctl_io.vhd \
	mig_36_1/user_design/rtl/ddr2_phy_dm_iob.vhd \
	mig_36_1/user_design/rtl/ddr2_phy_dq_iob.vhd \
	mig_36_1/user_design/rtl/ddr2_phy_dqs_iob.vhd \
	mig_36_1/user_design/rtl/ddr2_phy_init.vhd \
	mig_36_1/user_design/rtl/ddr2_phy_io.vhd \
	mig_36_1/user_design/rtl/ddr2_phy_top.vhd \
	mig_36_1/user_design/rtl/ddr2_phy_write.vhd \
	mig_36_1/user_design/rtl/ddr2_top.vhd \
	mig_36_1/user_design/rtl/ddr2_usr_addr_fifo.vhd \
	mig_36_1/user_design/rtl/ddr2_usr_rd.vhd \
	mig_36_1/user_design/rtl/ddr2_usr_top.vhd \
	mig_36_1/user_design/rtl/ddr2_usr_wr.vhd \
	mig_36_1/user_design/rtl/mig_36_1.vhd \
        $(GRLIB)/lib/gaisler/pcie/pcie.vhd

ifeq ("$(CONFIG_BOARD_ML505)","y")
  ifeq ("$(CONFIG_PCIEXP_MASTER_TARGET)","y")
  UCF+=pcie_master_target.ucf
  VHDLOPTSYNFILES+=$(GRLIB)/lib/gaisler/pcie/pcie_master_target_virtex.vhd
  endif
  ifeq ("$(CONFIG_PCIEXP_MASTER_FIFO)","y")
    ifneq ("$(CONFIG_PCIEXP_MASTER_FIFO_DMA)","y")
    UCF+=pcie_master_fifo.ucf
    VHDLOPTSYNFILES+=$(GRLIB)/lib/gaisler/pcie/pcie_master_fifo_virtex.vhd
    endif
    ifeq ("$(CONFIG_PCIEXP_MASTER_FIFO_DMA)","y")
    UCF+=pcie_master_fifo_with_dma.ucf
    VHDLOPTSYNFILES+=$(GRLIB)/lib/gaisler/pcie/pcie_master_fifo_virtex.vhd
    VHDLOPTSYNFILES+=$(GRLIB)/lib/gaisler/pcie/pciedma.vhd
    endif
  endif
endif

VHDLSYNFILES=config.vhd ahb2mig_ml50x.vhd ahbrom.vhd svga2ch7301c.vhd leon3mp.vhd 
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
SDCFILE=default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean migclean pcieclean


include $(GRLIB)/software/leon3/Makefile

TECHLIBS = xilinxcorelib_ver secureip_ver unisims_ver secureip unisim virtex5

VSIMOPT= -gDEBUG=0 +nowarnTSCALE -L work -L secureip_ver -L xilinxcorelib_ver -L unisims_ver glbl +nowarnTFMPC +nowarnPCDPC -t 1ps -do $(GRLIB)/bin/runvsim.do $(SIMTOP)

ASIMOPT= -gDEBUG=0 +nowarnTSCALE +nowarnTFMPC +nowarnPCDPC

VLOGOPT= +define+MODEL_TECH=1

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp usbhc spw fmf gsi spansion
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan can leon3ft ambatest \
	grusbhc usb spacewire hcan l2cache \
	slink ascs pwm gr1553b iommu
ifeq ("$(CONFIG_LEON4)","")
DIRSKIP+=leon4v0
endif

FILESKIP = grcan.vhd ahb2mig_series7_ddr2.vhd

include $(GRLIB)/bin/Makefile


##################  project specific targets ##########################


mig_36_1 mig:
	cp grlib_mig/* .
	coregen -b mig.xco -p .
	patch -p0 < mig.diff

migclean:
	-rm -rf coregen.* mig_36* mig.* mig.diff tmp coregen.log

pcie:
	coregen -b pcie/pcie.xco -p pcie

pcieclean:
	-rm -rf pcie/endpoint_blk_plus_v1_14* pcie/tmp pcie/coregen.cgc tx.dat rx.dat

.PHONY : pcie pcieclean
