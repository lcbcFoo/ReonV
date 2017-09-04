GRLIB=../..
TOP=leon3mp
BOARD=digilent-xc3s1000
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
#UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
UCF=leon3mp.ucf
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
XSTOPT=
SYNPOPT="set_option -pipe 0; set_option -retiming 0; set_option -write_apr_constraint 0"
VHDLSYNFILES=config.vhd ahbrom.vhd vga_clkgen.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
#SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
SDCFILE=default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean

TECHLIBS = unisim
LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF usbhc \
	tmtc openchip micron hynix cypress ihp opencores spw
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan pci leon3ft ambatest \
	spacewire ddr can usb grusbhc hcan \
	leon4v0 l2cache slink ascs pwm gr1553b iommu
FILESKIP = grcan.vhd i2cmst.vhd adapters/sgmii.vhd

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile


##################  project specific targets ##########################

