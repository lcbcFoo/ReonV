include .config
GRLIB=../..
TOP=leon3mp
BOARD=xilinx-ml40x-xc4v
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
#UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
UCF=leon3mp.ucf
XSTOPT=-uc leon3mp.xcf
SYNPOPT="set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
ISEMAPOPT=-m -timing
VHDLSYNFILES=config.vhd ahbrom.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
#SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
SDCFILE=default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean

TECHLIBS = unisim

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip hynix ihp fmf gsi spansion
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan pci leon3ft ambatest can usb \
	hcan leon4v0 l2cache slink ascs pwm gr1553b iommu

FILESKIP = grcan.vhd

include $(GRLIB)/software/leon3/Makefile

include $(GRLIB)/bin/Makefile


##################  project specific targets ##########################

