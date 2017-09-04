include .config

GRLIB=../..
TOP=leon3mp
BOARD=digilent-atlys
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
UCF=leon3mp.ucf
EFFORT=high
ISEMAPOPT=-timing
XSTOPT=""
SYNPOPT="set_option -maxfan 100; set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"
VHDLSYNFILES=config.vhd ahbrom.vhd vga_clkgen.vhd vga2tmds.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
SDCFILE=default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean
VCOMOPT=-explicit
TECHLIBS = unisim 

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip cypress ihp gleichmann gsi fmf spansion micron
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan pci leon3ft ambatest \
	leon4v0 l2cache gr1553b iommu haps ascs slink coremp7 pwm \
	ac97 hcan leon4v0
FILESKIP = grcan.vhd

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile


##################  project specific targets ##########################

.SECONDARY: ahbrom.exe
ahbrom.exe: ahbrom.S
	$(XCC) -nostdlib -Tlinkprom -Ttext=0 ahbrom.S -o ahbrom.exe

ahbrom.vhd: FILE=ahbrom.exe
ahbrom.vhd: ahbrom.exe

ddrtune.exe: ddrtune.S
	$(XCC) -nostdlib -Ttext=0xa0000000 ddrtune.S -o ddrtune.exe

.PHONY: atlys-clean
atlys-clean:
	$(RM) ahbrom.exe ahbrom.vhd ddrtune.exe

