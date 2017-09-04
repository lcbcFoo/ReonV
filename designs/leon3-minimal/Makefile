GRLIB=../..
TOP=leon3mp
TECHNOLOGY=Artix7

PART=XC7A100T
PACKAGE=csg324
SPEED=-2
DEVICE=$(PART)-$(PACKAGE)$(SPEED)

UCF=$(TOP).ucf
UCF_PLANAHEAD=$(UCF)
EFFORT=high
VHDLSYNFILES=config.vhd ahbrom.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
CLEAN=soft-clean
TECHLIBS = unisim 

# Libraries, directories and files in GRLIB that should not be compiled for this design
LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp usbhc spw
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan pci leon3ft ambatest can \
	usb grusbhc spacewire ascs slink hcan \
	leon4v0 l2cache pwm gr1553b iommu
FILESKIP = grcan.vhd

include $(GRLIB)/bin/Makefile 
include $(GRLIB)/software/leon3/Makefile

##################  project specific targets ##########################
