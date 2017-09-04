include .config

GRLIB=../..
TOP=leon3mp
BOARD=digilent-nexys4ddr-xc7a100t
DESIGN=leon3-digilent-nexys4ddr
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
#UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
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

TECHLIBS = secureip unisim

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp usbhc spw
LIBADD = testgrouppolito
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan pci leon3ft ambatest can \
	usb grusbhc spacewire ascs slink hcan \
	leon4v0 l2cache pwm gr1553b iommu
FILESKIP = grcan.vhd

# Options used during compilation
VCOMOPT=-explicit -O0

# - MIG -
ifeq ($(CONFIG_MIG_7SERIES),y)
SKIP_SIM_TECHLIBS = 1
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
VSIMOPT+= -do wave.do -do $(GRLIB)/bin/runvsim.do

# Toplevel
VSIMOPT+= $(SIMTOP)

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile


##################  project specific targets ##########################

# Additional files used for DPR demo
ifeq ($(CONFIG_PARTIAL),y)
VHDLSYNFILES+=./dprc_fir_demo/fir_ahb_dma_apb.vhd
VHDLSIMFILES+=./dprc_fir_demo/fir_v1.vhd
endif

CONFIG_PARTIAL ?= 0

ifeq ("$(CONFIG_EDAC)","y")
	CONFIG_BLOCK ?= -1
else
	CONFIG_BLOCK ?= 0
endif

dprc-demo: dprc-demo-clean
ifeq ("$(CONFIG_PARTIAL)","0")
	@echo "DPRC not instantiated in the design"
else 
	@make vivado/leon3mp_vivado.tcl
	vivado -mode batch -source ./dprc_fir_demo/dpr_demo.tcl
	@echo "Compiling dprc_sw utility"
	g++ -Wall -fexceptions -O2 -c ../../software/dprc/main.cpp -o ../../software/dprc/main.o
	g++  -o ../../software/dprc/dprc_sw ../../software/dprc/main.o
	@echo "Parsing partial bitstream files for dprc"
	@mkdir dpr_demo
	@../../software/dprc/dprc_sw ./config1_pblock_fir_core_partial.rbt ./config2_pblock_fir_core_partial.rbt $(CONFIG_BLOCK) ./dpr_demo/bitstream.h 
	cp ./dprc_fir_demo/pr_fir_demo.c ./dpr_demo/pr_fir_demo.c
	@echo "Compiling test program"
	sparc-elf-gcc -O0 -o ./dpr_demo/dpr_test ./dpr_demo/pr_fir_demo.c
endif

dprc-demo-soft:
	@if test -r "dpr_demo/"; then \
      rm -r dpr_demo/; \
	fi;
	@echo "Compiling dprc_sw utility"
	g++ -Wall -fexceptions -O2 -c ../../software/dprc/main.cpp -o ../../software/dprc/main.o
	g++  -o ../../software/dprc/dprc_sw ../../software/dprc/main.o
	@echo "Parsing partial bitstream files for dprc"
	@mkdir dpr_demo
	@../../software/dprc/dprc_sw ./config1_pblock_fir_core_partial.rbt ./config2_pblock_fir_core_partial.rbt $(CONFIG_BLOCK) ./dpr_demo/bitstream.h 
	cp ./dprc_fir_demo/pr_fir_demo.c ./dpr_demo/pr_fir_demo.c
	@echo "Compiling test program"
	sparc-elf-gcc -O0 -o ./dpr_demo/dpr_test ./dpr_demo/pr_fir_demo.c

dprc-demo-prog:
	@echo "fpga -f ./config1.bit" > ./xmd.ini
	@echo "exit" >> ./xmd.ini
	xmd

dprc-demo-clean:
	rm -rf dpr_demo/ *.dcp pr_verify.log *.bit *.rbt
