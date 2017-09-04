include .config
GRLIB=../..


TOP=leon3mp
ifeq ("$(CONFIG_LEON4)","y")
GRLIB_CONFIG=grlib_config_leon4.vhd
endif

# Select device based on choice make in xconfig.
# To always select the Virtex5 QV custom design,
# only assign: BOARD=xilinx-ml510-xqr5vfx130
ifeq ("$(CONFIG_DEVICE_XQR5V)","y")
BOARD=xilinx-ml510-xqr5vfx130
UCF=$(GRLIB)/boards/$(BOARD)/leon3mp_xqr5v.ucf
XSTOPT=-uc leon3mp.xcf -shreg_extract no -ram_extract no -fsm_encoding sequential -use_clock_enable no
EXTRA_SOFT=checkbits.srec
else
BOARD=xilinx-ml510-xc5vfx130t
UCF=leon3mp.ucf
XSTOPT=-uc leon3mp.xcf
endif


# Include settings for selected board
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)


QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
ISEMAPOPT=-m -timing -global_opt speed
#ISEMAPOPT=-m -timing
SYNPOPT="set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"
VHDLSYNFILES= config.vhd ahbrom.vhd \
	svga2ch7301c.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd

VERILOGSIMFILES = $$XILINX/verilog/src/glbl.v

SIMTOP=testbench
SDCFILE=default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean

include $(GRLIB)/software/leon3/Makefile

VSIMOPT= -gDEBUG=0 +nowarnTSCALE +nowarnTFMPC +nowarnPCDPC -t 1ps -do $(GRLIB)/bin/runvsim.do $(SIMTOP)

VLOGOPT= +define+MODEL_TECH=1

TECHLIBS = xilinxcorelib_ver secureip_ver unisims_ver secureip unisim virtex5
LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp usbhc spw micron
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan can \
	grusbhc usb spacewire hcan \
	slink ascs pwm gr1553b iommu ambatest atf
ifeq ("$(CONFIG_LEON4)","")
DIRSKIP+=leon4v0
endif
FILESKIP = grcan.vhd ahb2mig_series7_ddr2.vhd

include $(GRLIB)/bin/Makefile


##################  project specific targets ##########################

checkbits.srec: ram.srec
	tclsh $(GRLIB)/bin/ftddrcb.tcl 32 <ram.srec >checkbits.srec

