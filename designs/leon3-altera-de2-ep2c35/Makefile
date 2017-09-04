include .config
GRLIB=../..
TOP=leon3mp
BOARD=altera-de2-ep2c35
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
#UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
UCF=leon3mp.ucf
#UCF=leon3mp_gbit_usb.ucf
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
XSTOPT=
ISEMAPOPT=-timing
VHDLSYNFILES=config.vhd clkgen_de2.vhd mypackage.vhd sdctrl16.vhd \
	apblcd.vhd leon3mp.vhd
VHDLSIMFILES= mt48lc16m16a2.vhd testbench.vhd
SIMTOP=testbench
SDCFILE=default.sdc
#SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean
SYNPOPT="set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"

TECHLIBS = altera altera_mf stratixii
LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip hynix cypress ihp fmf spansion gsi
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan ddr \
	slink ascs leon3ft leon4v0 l2cache \
	spacewire usb pwm gr1553b iommu pci leon3ft hcan 

FILESKIP = grcan.vhd i2c_slave_model.v

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile

##################  project specific targets ##########################
