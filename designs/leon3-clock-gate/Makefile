GRLIB=../..
TOP=leon3mp
BOARD=gr-cpci-xc4v
#BOARD=gr-cpci-xc2v
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=std
XSTOPT=
VHDLSYNFILES=config.vhd ahbrom.vhd clkgate.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean

TECHLIBS = unisim simprim
LIBSKIP = tmtc gsi fmf dare hynix openchip cypress \
	ihp core1553bbc core1553brt core1553brm corePCIF gr1553 \
	spansion 
DIRSKIP = b1553 usb ddr crypto satcan slink ascs pwm gr1553b iommu \
	eon3ft leon4v0 l2cache pci/pcif spi hcan

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile


##################  project specific targets ##########################

