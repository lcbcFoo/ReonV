GRLIB=../..
TOP=leon3mp
BOARD=nuhorizons-sp3-1500
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=std
XSTOPT=
VHDLSYNFILES=config.vhd ahbrom.vhd smc_mctrl.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
SDCFILE=$(GRLIB)/boards/$(BOARD)/$(TOP).sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean

TECHLIBS = unisim
LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip hynix cypress ihp usbhc spw gsi fmf spansion
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan pci leon3ft ambatest ddr \
	grusbhc spacewire usb leon4v0 l2cache \
	slink ascs pwm gr1553b iommu
FILESKIP = grcan.vhd

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile


##################  project specific targets ##########################

