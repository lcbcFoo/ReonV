include .config

GRLIB=../..
TOP=leon3mp
BOARD=digilent-nexys-video-xc7a200t
DESIGN=leon3-digilent-nexys-video
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
UCF=$(TOP).ucf
UCF_PLANAHEAD=$(UCF)
XDC=$(TOP).xdc
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
XSTOPT=-uc leon3mp.xcf
SYNPOPT="set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"

# Uncomment for Modelsim or change to specify your simulator
#GRLIB_SIMULATOR=ModelSim
#GRLIB_SIMULATOR=ALDEC

VHDLSYNFILES=config.vhd ahbrom.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd

SIMTOP=testbench
#SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
FDCFILE=$(GRLIB)/boards/$(BOARD)/default.fdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean

TECHLIBS = unisim
SKIP_SIM_TECHLIBS = 1

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp usbhc spw
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan pci leon3ft ambatest can \
	usb grusbhc spacewire ascs slink hcan \
	leon4v0 l2cache pwm gr1553b iommu
FILESKIP = grcan.vhd

# Options used during compilation
VCOMOPT=-explicit -O0

# GRETH options
ifeq ($(CONFIG_GRETH_ENABLE),y)
VSIMOPT+= -L secureip -L unisims_ver -L unisim 
endif

# - MIG -
ifeq ($(CONFIG_MIG_7SERIES),y)
VSIMOPT+= -t fs -novopt
VSIMOPT+= -L secureip_ver -L xilinxcorelib_ver -L unisims_ver glbl
ifndef CONFIG_MIG_SERIES_7_MODEL
VSIMOPT+= -gUSE_MIG_INTERFACE_MODEL=false -gSIM_BYPASS_INIT_CAL=FAST -gSIMULATION=TRUE
else
VSIMOPT+= -gUSE_MIG_INTERFACE_MODEL=true -t ps
endif
endif

# Simulator switches
ifeq ("$(GRLIB_SIMULATOR)","ALDEC")
VSIMOPT+= +access +w -voptargs="+acc" +notimingchecks
else
VSIMOPT+= -novopt +notimingchecks
endif

# Simulation scripts
VSIMOPT+= -do "wave.do; $(GRLIB)/bin/runvsim.do"

# Toplevel
VSIMOPT+= $(SIMTOP)

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile


##################  project specific targets ##########################
