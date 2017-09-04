GRLIB=../..
TOP=leon3mp
BOARD=digilent-xup-xc2vp
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
#UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
UCF=leon3mp.ucf
#ISEMAPOPT=-timing
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
SYNPOPT="set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"
XSTOPT=-uc leon3mp.xcf
VHDLSYNFILES=config.vhd ahbrom.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
#SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
SDCFILE=default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean

TECHLIBS = unisim
LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF usbhc hynix \
	tmtc openchip cypress ihp opencores spw fmf gsi spansion
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan pci leon3ft ambatest \
	can usb spacewire grusbhc hcan leon4v0 l2cache \
	slink ascs pwm gr1553b iommu
FILESKIP = grcan.vhd i2cmst.vhd adapters/sgmii.vhd

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile


##################  project specific targets ##########################

