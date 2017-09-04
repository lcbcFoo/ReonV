include .config
GRLIB=../..
TOP=leon3mp
BOARD=avnet-eval-xc4vlx60
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
#UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
#UCF=$(GRLIB)/boards/$(BOARD)/leon3mp.ucf
UCF=leon3mp.ucf
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
XSTOPT=-uc leon3mp.xcf
ISEMAPOPT=-timing
SYNPOPT="set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"
VHDLOPTSYNFILES= \
	mig_36_1/user_design/rtl/mig_36_1_parameters_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_backend_fifos_0.vhd\
	mig_36_1/user_design/rtl/mig_36_1_controller_iobs_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_data_path_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_data_path_iobs_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_data_tap_inc_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_data_write_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_ddr_controller_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_idelay_ctrl.vhd \
	mig_36_1/user_design/rtl/mig_36_1_infrastructure.vhd \
	mig_36_1/user_design/rtl/mig_36_1_infrastructure_iobs_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_iobs_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_pattern_compare8.vhd \
	mig_36_1/user_design/rtl/mig_36_1_ram_d_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_rd_data_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_rd_data_fifo_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_rd_wr_addr_fifo_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_tap_ctrl_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_tap_logic_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_top_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_user_interface_0.vhd \
	mig_36_1/user_design/rtl/mig_36_1_v4_dm_iob.vhd \
	mig_36_1/user_design/rtl/mig_36_1_v4_dq_iob.vhd \
	mig_36_1/user_design/rtl/mig_36_1_v4_dqs_iob.vhd \
	mig_36_1/user_design/rtl/mig_36_1_wr_data_fifo_16.vhd \
	mig_36_1/user_design/rtl/mig_36_1.vhd 
VHDLSYNFILES=config.vhd \
	ahb2mig_avnet_eval.vhd ahbrom.vhd leon3mp.vhd

VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
#SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
SDCFILE=default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean migclean
VCOMOPT=-explicit
TECHLIBS = unisim
LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip hynix cypress ihp usbhc spw \
	fmf gsi spansion 
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan pci leon3ft \
	spacewire ambatest can grusbhc usb hasp spi \
	hcan leon4v0 l2cache slink ascs pwm gr1553b iommu 
FILESKIP = grcan.vhd i2cmst.vhd



include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile


##################  project specific targets ##########################

mig_36_1 mig:
	cp grlib_mig/* .
	coregen -b mig.xco -p .
	patch -p0 < mig.diff

migclean:
	-rm -rf coregen.* mig_36* mig.* mig.diff tmp

