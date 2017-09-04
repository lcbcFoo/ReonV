include .config

GRLIB=../..
TOP=leon3mp
#GRLIB_SIMULATOR=ModelSim-SE

# For FPGA Prototyping
# FPGA and Dev Board used in Design
TECHNOLOGY=Virtex7
PART=XC7VX485T
PACKAGE=ffg1761
PROTOBOARD=xilinx.com:virtex7:vc707:a
SPEED=2
PROMGENPAR=-x xcf08p -u 0 $(TOP).bit -p mcs -w -o $(BOARD)
BOARD=xilinx-vc707-xc7vx485t
DEVICE=$(PART)$(PACKAGE)-$(SPEED)
#XDC=$(GRLIB)/boards/$(BOARD)/$(BOARD).xdc
TCL=./grtechscripts/setup_unisim.tcl ./grtechscripts/timing_unisim.tcl

# Tech used
TECH = $(shell grep FABTECH config.vhd | grep -o "[^ ]*$$"  | sed -e 's/;//g')

# For SAED32
ifeq ("$(SAED32_HOME)","")
SAED32_HOME=/usr/local32/cad/synlibs/synopsys/
export SAED32_HOME
endif

# For RHS65
ifeq ("$(TECH)","rhs65")
VSIMOPT+= +nospecify +delay_mode_zero
endif

VHDLSYNFILES=config.vhd \
	spw_lvttl_pads.vhd bschain.vhd core_clock_mux.vhd leon3core.vhd core.vhd pads.vhd leon3mp.vhd

VHDLSIMFILES=testbench.vhd
SIMTOP=testbench

CLEAN=soft-clean

TECHLIBS = $(TECH) inferred grdware dware secureip unisim

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	openchip gsi spansion tmtc ihp fmf cypress hynix

DIRSKIP = b1553 pci/pcif leon2 leon2ft leon4v0 l2cache iommu \
	usb ddr crypto satcan slink ascs pwm gr1553b

FILESKIP =

# Modelsim Sim Options
#VSIMOPT+= -Gdisas=1
VSIMOPT+= -c

# Use 32 or 64 bit binary
LBITS := $(shell getconf LONG_BIT)
ifeq ($(LBITS),64)
   DCOPT += -64bit
else
   # do 32 bit stuff here
endif
DCOPT += -x "set argv [lindex [list $(TECHLIBS)] 0]; set top $(TOP)"
DCSCRIPT=dc.tcl

FMOPT = -x "set argv [lindex [list $(TECHLIBS)] 0]; set top $(TOP)"
FMSCRIPT=fm.tcl

VSIMOPT+= -t ps -L work -L $(TECH) -novopt $(SIMTOP)
VSIMGTLOPT=$(VSIMOPT) -do ./gtl.do  -sdfmax /$(SIMTOP)/$(TOP)=./synopsys/$(TOP)_$(grtechlib).sdf

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile

##################  project specific targets ##########################

all: help-local

help-local: help
	@echo
	@echo " design specific targets:"
	@echo
	@echo " make gtlsim                       : Run 'systest.c' on pre layout netlist"
	@echo
	@echo " ================================================================"
	@echo "         Quick start guide for simulation of systest.c"
	@echo
	@echo "  1. Setup search paths for ASIC Tech Lib, GCC and Modelsim "
	@echo "  2. make comp_saed32_sim (If SAED32 is used)"
	@echo "  3. make vsim"
	@echo "  4. make soft"
	@echo "  5. make vsim-launch"
	@echo
	@echo " Please note that this quick start guide will compile and simulate"
	@echo " a preconfigured version of the leon3 processor system."
	@echo " For customizing the leon3 susbsystem run make 'xconfig'"
	@echo " ================================================================"
	@echo
	@echo " ================================================================"
	@echo "     Quick start guide for creating and verifying a netlist"
	@echo
	@echo "  1. Setup search paths for Tech Lib, Synopsys, GCC and Modelsim "
	@echo "  2. make dc"
	@echo "  3. make fm"
	@echo "  4. make soft"
	@echo "  5. make gtl-vsim-launch"
	@echo
	@echo " Please note that this quick start guide will compile and simulate"
	@echo " a preconfigured version of the leon3 processor system."
	@echo " For customizing the leon3 susbsystem run make 'xconfig'"
	@echo " ================================================================"
	@echo

##############  GTL Post Simulation specific targets ###################
#
# To be able to run pre gate level simulations using targets below
# a netlist and SDF needs to be generated using 'make dc'.
#
# Main GTL Pre Simulation Targets:
#  gtl-vsim      - Compile complete design for pre layout simulation
#  gtl-vsim-launch - Run post layout simulation using 'gtl.do' script
#

# Compile enviroment, library and design
gtl-vsim: vsim
	vlog -work work "Add Tech Library files here!"
	vlog -work work synopsys/$(TOP)_$(grtechlib).v
	vcom -work work testbench.vhd

# Run Pre GTL simulation
gtl-vsim-launch : gtl-vsim
	vsim $(VSIMGTLOPT)

# Compile SAED32 SIM Library
comp_saed32_sim:
	-@MTI_DEFAULT_LIB_TYPE=0 vlib modelsim
	-@MTI_DEFAULT_LIB_TYPE=0 vlib ./modelsim/saed32
	vmap saed32 ./modelsim/saed32
	vlog -quiet -work saed32 $(SAED32_HOME)/SAED32_EDK/lib/pll/verilog/PLL.v
	vlog -quiet -work saed32 $(SAED32_HOME)/SAED32_EDK/lib/io_std/verilog/saed32nm_io_wb.v
	vlog -quiet -work saed32 $(SAED32_HOME)/SAED32_EDK/lib/stdcell_lvt/verilog/saed32nm_lvt.v
	vlog -quiet -work saed32 $(SAED32_HOME)/SAED32_EDK/lib/sram/verilog/saed32sram.v

