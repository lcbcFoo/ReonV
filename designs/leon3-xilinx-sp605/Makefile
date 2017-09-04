include .config

GRLIB=../..
TOP=leon3mp
BOARD=xilinx-sp605-xc6slx45t
DESIGN=leon3-xilinx-sp605
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
ISEMAPOPT=-timing
XSTOPT=
SYNPOPT="set_option -maxfan 100; set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"
VHDLOPTSYNFILES= mig38/mig_38/user_design/rtl/iodrp_controller.vhd \
	mig38/mig_38/user_design/rtl/iodrp_mcb_controller.vhd \
	mig38/mig_38/user_design/rtl/mcb_raw_wrapper.vhd \
	mig38/mig_38/user_design/rtl/mcb_soft_calibration.vhd \
	mig38/mig_38/user_design/rtl/mcb_soft_calibration_top.vhd \
	mig38/mig_38/user_design/rtl/memc3_infrastructure.vhd \
	mig38/mig_38/user_design/rtl/memc3_wrapper.vhd \
	mig38/mig_38/user_design/rtl/mig_38.vhd \
	mig39/mig_39/user_design/rtl/iodrp_controller.vhd \
	mig39/mig_39/user_design/rtl/iodrp_mcb_controller.vhd \
	mig39/mig_39/user_design/rtl/mcb_raw_wrapper.vhd \
	mig39/mig_39/user_design/rtl/mcb_soft_calibration.vhd \
	mig39/mig_39/user_design/rtl/mcb_soft_calibration_top.vhd \
	mig39/mig_39/user_design/rtl/memc3_infrastructure.vhd \
	mig39/mig_39/user_design/rtl/memc3_wrapper.vhd \
	mig39/mig_39/user_design/rtl/mig_39.vhd \
	pcie/s6_pcie_v1_4/source/pcie_bram_top_s6.vhd \
	pcie/s6_pcie_v1_4/source/pcie_brams_s6.vhd \
	pcie/s6_pcie_v1_4/source/pcie_bram_s6.vhd \
	pcie/s6_pcie_v1_4/source/s6_pcie_v1_4.vhd \
        pcie.vhd \
        pciahbmst.vhd \
        dmactrl.vhd \
        pcie/s6_pcie_v1_4/source/gtpa1_dual_wrapper_tile.vhd \
	pcie/s6_pcie_v1_4/source/gtpa1_dual_wrapper.vhd \
        config.vhd svga2ch7301c.vhd ahbrom.vhd \
        ahb2mig_sp605.vhd vga_clkgen.vhd leon3mp.vhd

#UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
UCF=leon3mp.ucf
ifeq ("$(CONFIG_PCIEXP_MASTER_TARGET)","y")
  UCF+=pcie_master_target.ucf
  VHDLOPTSYNFILES+=pcie_master_target_sp605.vhd
endif
ifeq ("$(CONFIG_PCIEXP_MASTER_FIFO)","y")
  ifneq ("$(CONFIG_PCIEXP_MASTER_FIFO_DMA)","y")
  UCF+=pcie_master_fifo.ucf
  VHDLOPTSYNFILES+=pcie_master_fifo_sp605.vhd
  endif
  ifeq ("$(CONFIG_PCIEXP_MASTER_FIFO_DMA)","y")
  UCF+=pcie_master_fifo_with_dma.ucf
  VHDLOPTSYNFILES+=pcie_master_fifo_sp605.vhd
  VHDLOPTSYNFILES+=pciedma.vhd
  endif
endif
UCF_PLANAHEAD=$(UCF)

VHDLSIMFILES=testbench.vhd
ifeq ("$(CONFIG_PCIEXP_MASTER_TARGET)","y")
VHDLSIMFILES+=$(GRLIB)/lib/tech/unisim/ise/GTPA1_DUAL.vhd $(GRLIB)/lib/tech/unisim/ise/GTP_DUAL.vhd \
$(GRLIB)/lib/tech/unisim/ise/GTXE1.vhd $(GRLIB)/lib/tech/unisim/ise/GTX_DUAL.vhd \
$(GRLIB)/lib/tech/unisim/ise/PCIE_2_0.vhd $(GRLIB)/lib/tech/unisim/ise/PCIE_A1.vhd \
pcie/s6_pcie_v1_4/simulation/functional/sys_clk_gen_ds.vhd pcie/s6_pcie_v1_4/simulation/functional/sys_clk_gen.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/test_interface.vhd pcie/s6_pcie_v1_4/simulation/tests/tests.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pci_exp_usrapp_tx.vhd pcie/s6_pcie_v1_4/simulation/dsport/pci_exp_usrapp_cfg.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pci_exp_usrapp_rx.vhd pcie/s6_pcie_v1_4/simulation/dsport/xilinx_pcie_2_0_rport_v6.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pcie_2_0_rport_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/pcie_2_0_v6_rp.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pcie_upconfig_fix_3451_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/gtx_drp_chanalign_fix_3752_v6.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/gtx_rx_valid_filter_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/pci_exp_usrapp_pl.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pcie_clocking_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/pcie_reset_delay_v6.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pcie_pipe_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/pcie_pipe_misc_v6.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pcie_pipe_lane_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/gtx_wrapper_v6.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/gtx_tx_sync_rate_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/pcie_gtx_v6.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pcie_bram_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/pcie_brams_v6.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pcie_bram_top_v6.vhd
else 
ifeq ("$(CONFIG_PCIEXP_MASTER_FIFO)","y")
VHDLSIMFILES+=$(GRLIB)/lib/tech/unisim/ise/GTPA1_DUAL.vhd $(GRLIB)/lib/tech/unisim/ise/GTP_DUAL.vhd \
$(GRLIB)/lib/tech/unisim/ise/GTXE1.vhd $(GRLIB)/lib/tech/unisim/ise/GTX_DUAL.vhd \
$(GRLIB)/lib/tech/unisim/ise/PCIE_2_0.vhd $(GRLIB)/lib/tech/unisim/ise/PCIE_A1.vhd \
pcie/s6_pcie_v1_4/simulation/functional/sys_clk_gen_ds.vhd pcie/s6_pcie_v1_4/simulation/functional/sys_clk_gen.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/test_interface.vhd pcie/s6_pcie_v1_4/simulation/tests/tests.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pci_exp_usrapp_tx.vhd pcie/s6_pcie_v1_4/simulation/dsport/pci_exp_usrapp_cfg.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pci_exp_usrapp_rx.vhd pcie/s6_pcie_v1_4/simulation/dsport/xilinx_pcie_2_0_rport_v6.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pcie_2_0_rport_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/pcie_2_0_v6_rp.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pcie_upconfig_fix_3451_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/gtx_drp_chanalign_fix_3752_v6.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/gtx_rx_valid_filter_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/pci_exp_usrapp_pl.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pcie_clocking_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/pcie_reset_delay_v6.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pcie_pipe_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/pcie_pipe_misc_v6.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pcie_pipe_lane_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/gtx_wrapper_v6.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/gtx_tx_sync_rate_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/pcie_gtx_v6.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pcie_bram_v6.vhd pcie/s6_pcie_v1_4/simulation/dsport/pcie_brams_v6.vhd\
pcie/s6_pcie_v1_4/simulation/dsport/pcie_bram_top_v6.vhd
endif
endif

SIMTOP=testbench
#SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
SDCFILE=default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean migclean pcieclean 
VCOMOPT=-explicit
TECHLIBS = secureip unisim

VSIMOPT= -t ps -do $(GRLIB)/bin/runvsim.do $(SIMTOP)

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip cypress ihp gsi fmf spansion 
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan ambatest \
	leon4v0 l2cache gr1553b iommu ascs slink pwm \
	hcan usb grfpc4 grlfpc4
FILEADD = MCB.vhd
FILESKIP = grcan.vhd ddr2.v mobile_ddr.v

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile


##################  project specific targets ##########################

mig:
	cp -r grlib_mig/mig38 .
	coregen -b mig38/mig.xco -p mig38
	patch -p0 < grlib_mig/mig.diff

mig39:
	cp -r grlib_mig/mig39 .
	coregen -b mig39/mig.xco -p mig39
	patch -p0 < grlib_mig/mig_patch.txt
	patch -p0 < grlib_mig/memc3_infrastructure_patch.txt
	patch -p0 < grlib_mig/mcb_soft_calibration_patch.txt

migclean:
	-rm -rf mig38 mig39

pcie:
	coregen -b pcie/pcie.xco -p pcie
	patch -p0 < pcie.diff

pcieclean:
	-rm -rf pcie/s6_pcie_v1_4* pcie/tmp pcie/coregen.cgc tx.dat rx.dat

.PHONY : pcie migclean pcieclean
