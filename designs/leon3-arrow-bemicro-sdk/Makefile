GRLIB=../..
TOP=leon3mp
BOARD=arrow-bemicro-sdk
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=std
XSTOPT=
SYNPOPT="set_option -pipe 1; set_option -retiming 1"
VHDLSYNFILES=config.vhd ahbrom.vhd leon3mp.vhd 
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean

TECHLIBS = altera altera_mf cycloneiii
LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp stratixii stratixiii spw \
	oppencores
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan pci leon3ft ambatest can \
	grusbhc spacewire hcan leon4v0 l2cache iommu slink ascs pwm \
	gr1553b usb 
FILESKIP = grcan.vhd

include $(GRLIB)/software/leon3/Makefile
include $(GRLIB)/bin/Makefile


##################  project specific targets ##########################

