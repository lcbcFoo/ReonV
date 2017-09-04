include .config

GRLIB=../..
TOP=leon3mp
BOARD=digilent-basys3-xc7a35t
DESIGN=leon3-digilent-basys3
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
UCF=$(TOP).ucf
UCF_PLANAHEAD=$(UCF)
XDC=$(TOP).xdc
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
XSTOPT=-uc leon3mp.xcf
SYNPOPT="set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"

VHDLSYNFILES=config.vhd ahbrom.vhd leon3mp.vhd

VHDLSIMFILES=testbench.vhd

SIMTOP=testbench
#SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
FDCFILE=$(GRLIB)/boards/$(BOARD)/default.fdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean

# Simulator switches
ifeq ("$(GRLIB_SIMULATOR)","ALDEC")
VSIMOPT+= +access +w -voptargs="+acc" +notimingchecks
else
VSIMOPT+= -novopt +notimingchecks
endif

# Simulation scripts
VSIMOPT+= -do wave.do -do $(GRLIB)/bin/runvsim.do

# Toplevel
VSIMOPT+= $(SIMTOP)

TECHLIBS = secureip unisim

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp usbhc spw esa fmf spansion gsi cypress \
	hynix micron
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan pci leon3ft ambatest can \
	usb grusbhc spacewire ascs slink hcan \
	leon4v0 l2cache pwm gr1553b iommu axi subsys grrm grdmac nand i2c ddr
FILESKIP = grcan.vhd

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile


##################  project specific targets ##########################
