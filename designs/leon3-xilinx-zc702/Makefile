include .config

GRLIB=../..
TOP=leon3mp
BOARD=xilinx-zc702-xc7z020
DESIGN=leon3-zc702
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
#PROTOBOARD=xilinx.com:zc702:part0:1.2

DEVICE=$(PART)$(PACKAGE)-$(SPEED)
UCF_PLANAHEAD=$(GRLIB)/boards/$(BOARD)/xilinx-zx702.ucf
XDC=leon3mp.xdc
TCL=stub.tcl

VHDLSYNFILES= \
	config.vhd ahbrom.vhd leon3mp.vhd

VHDLSIMFILES= \
	leon3_zc702_stub_sim.vhd testbench.vhd

NETLISTTECH = Virtex4

SIMTOP=testbench
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean
VCOMOPT=-explicit
TECHLIBS = secureip unisim 

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp usbhc gsi cypress hynix \
	spansion leon4v0 spw
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan pci ambatest can \
	usb grusbhc ascs slink spi hcan spacewire \
	leon4v0 l2cache pwm gr1553b iommu ac97 secureip
FILESKIP = grcan.vhd ddr2.v mobile_ddr.v

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile

##################  project specific targets ##########################

all: help-local

help-local: help
	@echo
	@echo " -----------------------------------------------------------------------------------------"
	@echo " design specific targets:"
	@echo
	@echo " make program-zc702              : Load Leon3 Design and start clocks"
	@echo

program-zc702:
	@echo "fpga -f ./vivado/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).bit" > ./xmd.ini
	@echo "connect arm hw" >> ./xmd.ini
	@echo "source ./vivado/$(DESIGN)/$(DESIGN).sdk/SDK/SDK_Export/hw/ps7_init.tcl" >> ./xmd.ini
	@echo "ps7_init" >> ./xmd.ini
	@echo "init_user" >> ./xmd.ini
	@echo "exit" >> ./xmd.ini
	xmd

program-zc702-ref:
	@echo "fpga -f ./bitfiles/$(TOP).bit" > ./xmd.ini
	@echo "connect arm hw" >> ./xmd.ini
	@echo "source ./vivado/$(DESIGN)/$(DESIGN).sdk/SDK/SDK_Export/hw/ps7_init.tcl" >> ./xmd.ini
	@echo "ps7_init" >> ./xmd.ini
	@echo "init_user" >> ./xmd.ini
	@echo "exit" >> ./xmd.ini
	xmd

