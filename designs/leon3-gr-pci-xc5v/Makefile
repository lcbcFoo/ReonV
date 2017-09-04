include .config
GRLIB=../..
TOP=leon3mp
ifeq ("$(CONFIG_LEON4)","y")
GRLIB_CONFIG=grlib_config_leon4.vhd
endif
BOARD=gr-pci-xc5v
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
#UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
UCF=leon3mp.ucf
ifeq ("$(CONFIG_GR1553B_ENABLE)","y")
UCF+=leon3mp_1553.ucf
endif
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
XSTOPT=
ISEMAPOPT=-timing
VHDLSYNFILES=config.vhd lfclkgen.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
SDCFILE=default.sdc
#SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean
SYNPOPT="set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"
TECHLIBS = unisim
LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip hynix cypress ihp fmf spansion gsi
DIRSKIP = b1553 pci/pcif leon2 leon2ft leon3v1 leon3ftv2 leon3ftv1 \
	 crypto satcan ddr slink ascs hcan \
	i2c spi pwm iommu
ifeq ("$(CONFIG_LEON4)","")
DIRSKIP+=leon4v0
endif
FILESKIP = grcan.vhd i2c_slave_model.v \
	$(GRFPWNET) $(L3FTNET)

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile

##################  project specific targets ##########################
