### GRLIB general setup and extra target to clean software
include .config
GRLIB=../..
CLEAN=soft-clean

### Xilinx Vivado device and board setup
BOARD=xilinx-ac701-xc7a200t
DESIGN=leon3-xilinx-ac701
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)$(PACKAGE)-$(SPEED)
XDC=$(GRLIB)/boards/$(BOARD)/$(BOARD).xdc

### Simulation Options ###
# Design Top Level
TOP=leon3mp

# Simulation top level
SIMTOP=testbench

# Uncomment for Modelsim or change to specify your simulator
#GRLIB_SIMULATOR=ModelSim
#GRLIB_SIMULATOR=ALDEC

# Options used during compilation
VCOMOPT=-explicit -O0

# GRLIB Options
#VSIMOPT= -gdisas=1

# GRETH options
ifeq ($(CONFIG_GRETH_ENABLE),y)
VSIMOPT+= -L secureip -L unisims_ver -L unisim 
endif

# - MIG -
ifeq ($(CONFIG_MIG_7SERIES),y)
VSIMOPT+= -t fs -novopt
VSIMOPT+= -L secureip -L unisims_ver glbl
ifndef CONFIG_MIG_7SERIES_MODEL
VSIMOPT+= -gUSE_MIG_INTERFACE_MODEL=false -gSIM_BYPASS_INIT_CAL=FAST -gSIMULATION=TRUE
ASIMOPT+= -gUSE_MIG_INTERFACE_MODEL=false -gSIM_BYPASS_INIT_CAL=FAST -gSIMULATION=TRUE
else
VSIMOPT+= -gUSE_MIG_INTERFACE_MODEL=true -t ps
ASIMOPT+= -gUSE_MIG_INTERFACE_MODEL=true -t ps
endif
endif

# Simulator switches
ifeq ("$(GRLIB_SIMULATOR)","ALDEC")
VSIMOPT+= +access +w -voptargs="+acc" +notimingchecks
else
VSIMOPT+=-novopt +notimingchecks
endif

# Run simulation in batch mode
#VSIMOPT+= -c

# Remove collision check in UNSIM library
VSIMOPT+= -GSIM_COLLISION_CHECK="GENERATE_X_ONLY"
ASIMOPT+= -GSIM_COLLISION_CHECK="GENERATE_X_ONLY"

# Simulation scripts
VSIMOPT+= -do $(GRLIB)/bin/runvsim.do
ASIMDO = run -all

# Toplevel
VSIMOPT+= $(SIMTOP)

### End of Simulation Options ###

### Testbench, design and libraries to compile and not to compile

VHDLSYNFILES= config.vhd ahbrom.vhd leon3mp.vhd ddr_dummy.vhd
VHDLSIMFILES=testbench.vhd

TECHLIBS = unisim
SKIP_SIM_TECHLIBS = 1

LIBSKIP = pci pci/pcif core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp spw gsi cypress hynix \
	spansion leon4v0 secureip
DIRSKIP = b1553 pci pci/pcif leon2 leon2ft crypto satcan pci ambatest \
	spacewire ascs slink \
	pwm gr1553b iommu ac97 secureip
FILESKIP = grcan.vhd ddr2.v mobile_ddr.v adapters/sgmii.vhd

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile

##################  project specific targets ##########################
