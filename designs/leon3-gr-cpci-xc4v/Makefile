include .config
GRLIB=../..
TOP=leon3mp
BOARD=gr-cpci-xc4v
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
ifeq ("$(CONFIG_SPW_ENABLE)","y")
UCF+=$(GRLIB)/boards/$(BOARD)/$(TOP)_spw.ucf
endif
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
XSTOPT=
ISEMAPOPT=-timing
VHDLSYNFILES=config.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
SDCFILE=default.sdc
#SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean
SYNPOPT="set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"

TECHLIBS = unisim secureip
LIBSKIP = core1553bbc core1553brm core1553brt gr1553 \
	tmtc openchip hynix cypress ihp usbhc fmf spansion gsi
LIBADD = testgrouppolito
DIRSKIP = b1553 leon2 leon2ft crypto satcan ddr usb grusbhc \
	leon4v0 l2cache iommu pci/pcif slink ascs

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile

##################  project specific targets ##########################

# Additional files used for DPR demo
ifeq ($(CONFIG_PARTIAL),y)
VHDLSYNFILES+=./dprc_fir_demo/fir_ahb_dma_apb.vhd
VHDLSIMFILES+=./dprc_fir_demo/fir_v1.vhd
UCF+=$(GRLIB)/lib/testgrouppolito/pr/icapv4v5.ucf
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
	@make $(TOP).ngc
	@planAhead -mode batch -source ./dprc_fir_demo/dpr_demo.tcl
	@echo "Compiling dprc_sw utility"
	g++ -Wall -fexceptions -O2 -c ../../software/dprc/main.cpp -o ../../software/dprc/main.o
	g++  -o ../../software/dprc/dprc_sw ../../software/dprc/main.o
	@echo "Generating partial bitstream files for dprc"
	@../../software/dprc/dprc_sw ./dpr_demo/dpr_demo.runs/config_1/config_1_prc_fir_ex_fir_core_firv1_partial.rbt ./dpr_demo/dpr_demo.runs/config_2/config_2_prc_fir_ex_fir_core_firv2_partial.rbt  $(CONFIG_BLOCK) ./dpr_demo/bitstream.h 
	cp ./dprc_fir_demo/pr_fir_demo.c ./dpr_demo/pr_fir_demo.c
	@echo "Compiling test program"
	sparc-elf-gcc -O0 -o ./dpr_demo/dpr_test ./dpr_demo/pr_fir_demo.c
endif

dprc-demo-prog:
	cp ./dpr_demo/dpr_demo.runs/config_1/config_1.bit $(BOARD).bit
	cp ./dpr_demo/dpr_demo.runs/config_1/config_1.msk $(BOARD).msk
	impact -batch $(GRLIB)/boards/$(BOARD)/fpga.cmd

dprc-demo-clean:
	rm -rf dpr_demo/

