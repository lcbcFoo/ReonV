include .config
GRLIB=../..
GRLIB_CONFIG=grlib_config.vhd
TOP=leon3mp
BOARD=terasic-s5gs-dsp
ALTCABLE=USB-BlasterII
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
#UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
UCF=none
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
XSTOPT=
ISEMAPOPT=-timing
VHDLSYNFILES=config.vhd ddr3if.vhd leon3mp.vhd
VHDLSIMFILES=memifsim.vhd testbench.vhd
SIMTOP=testbench
SDCFILE=default.sdc
#SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean
SYNPOPT="set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"
ifeq ("$(GRLIB_SIMULATOR)", "ALDEC")
VSIMOPT=-ieee_nowarn -dbg -O2 +access +r -t ps -L work -L dll0 -L oct0 -L s0 -L m0 -L p0 -L pll0 -L uniphy -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiv_hssi_ver -L stratixiv_pcie_hip_ver -L stratixiv_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L stratixiv_hssi -L stratixiv_pcie_hip -L stratixiv -do $(GRLIB)/bin/runvsim.do $(SIMTOP)
else
VSIMOPT=-novopt -t ps -L work -L work_lib -L dll0 -L oct0 -L s0 -L m0 -L p0 -L pll0 -L uniphy -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiv_hssi_ver -L stratixiv_pcie_hip_ver -L stratixiv_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L stratixiv_hssi -L stratixiv_pcie_hip -L stratixiv -do $(GRLIB)/bin/runvsim.do $(SIMTOP)
endif
QSF_APPEND=qsf_append.qsf
QSF_NEXT=qsf_pin_assign.tcl

TECHLIBS = altera altera_mf stratixiii stratixv
LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip hynix cypress ihp fmf spansion gsi idt
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan \
	slink ascs leon3ft \
	spacewire usb pwm gr1553b iommu pci hcan 
ifeq ("$(CONFIG_LEON4)","")
DIRSKIP+=leon4v0
endif
FILESKIP = grcan.vhd

CLEAN=localclean

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile

##################  project specific targets ##########################

qwiz:
	@if [ ! -d ./ddr3ctrl/ ]; then \
		qmegawiz -silent ddr3ctrl.vhd ; \
	else \
		echo "DDR3 controller core already compiled"; \
	fi ;

localclean:
	@-rm -rf ddr3ctrl ddr3ctrl_example_design ddr3ctrl_sim
	@-rm -f ddr3ctrl.bsf ddr3ctrl.cmp ddr3ctrl_p0_all_pins.txt ddr3ctrl.ppf
	@-rm -f ddr3ctrl.qip ddr3ctrl_sim.f ddr3ctrl.sip ddr3ctrl.sopcinfo
	@-rm -f ddr3ctrl.spd


