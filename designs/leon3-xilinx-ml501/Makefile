include .config
GRLIB=../..
TOP=leon3mp
BOARD=xilinx-ml501-xc5vlx50
DESIGN=leon3-xilinx-ml501
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
#UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
UCF=leon3mp.ucf
ifeq ("$(CONFIG_MIG_DDR2)","y")
UCF+=leon3mp_mig.ucf
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
	mig_36_1/user_design/rtl/mig_36_1.vhd
VHDLSYNFILES=config.vhd \
	ahb2mig_ml50x.vhd ahbrom.vhd svga2ch7301c.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
#SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
SDCFILE=default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean migclean

include $(GRLIB)/software/leon3/Makefile

TECHLIBS = unisim

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp usbhc spw fmf gsi spansion
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan can pci leon3ft ambatest \
	grusbhc usb spacewire hcan leon4v0 l2cache \
	slink ascs pwm gr1553b iommu

FILESKIP = grcan.vhd

include $(GRLIB)/bin/Makefile


##################  project specific targets ##########################

mig_36_1 mig:
	cp grlib_mig/* .
	coregen -b mig.xco -p .
	patch -p0 < mig.diff

migclean:
	-rm -rf coregen.* mig_36* mig.* mig.diff tmp
