include .config
GRLIB=../..
GRLIB_CONFIG=grlib_config.vhd
TOP=leon3mp
BOARD=terasic-de4
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
#UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
UCF=leon3mp.ucf
#UCF=leon3mp_gbit_usb.ucf
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
ifeq ("$(GRLIB_SIMULATOR)", "ALDEC")
VSIMOPT=-ieee_nowarn -dbg -O2 +access +r -t ps -L work -L dll0 -L oct0 -L s0 -L m0 -L p0 -L pll0 -L uniphy -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiv_hssi_ver -L stratixiv_pcie_hip_ver -L stratixiv_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L stratixiv_hssi -L stratixiv_pcie_hip -L stratixiv -do $(GRLIB)/bin/runvsim.do $(SIMTOP)
else
VSIMOPT=-novopt -t ps -L work -L work_lib -L dll0 -L oct0 -L s0 -L m0 -L p0 -L pll0 -L uniphy -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiv_hssi_ver -L stratixiv_pcie_hip_ver -L stratixiv_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L stratixiv_hssi -L stratixiv_pcie_hip -L stratixiv -do $(GRLIB)/bin/runvsim.do $(SIMTOP)
endif
QSF_APPEND=qsf_append.qsf
QSF_NEXT=qsf_pin_assign.tcl

TECHLIBS = altera altera_mf stratixiii stratixiv
LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip hynix cypress ihp fmf spansion gsi
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan \
	slink ascs leon3ft \
	spacewire usb pwm gr1553b iommu pci hcan 
ifeq ("$(CONFIG_LEON4)","")
DIRSKIP+=leon4v0
endif
FILESKIP = grcan.vhd altera_mf_components.vhd altera_mf.vhd

CLEAN=localclean

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile

##################  project specific targets ##########################

qwiz:
	@cp $(GRLIB)/boards/$(BOARD)/uniphy_266.vhd uniphy.vhd
	@if [ ! -d ./uniphy/ ]; then \
		qmegawiz -silent uniphy.vhd ; \
	else \
		echo "Uniphy core already compiled"; \
	fi ;

ifeq ("$(GRLIB_SIMULATOR)", "ALDEC")
QWIZ_TCL=aldec/rivierapro_setup.tcl
else
QWIZ_TCL=mentor/msim_setup.tcl
endif

qwiz-sim: scripts modelsim
	sed 's/libraries/modelsim/' uniphy_sim/$(QWIZ_TCL) > precompile.tcl
	vsim -c -do "set QSYS_SIMDIR ./uniphy_sim/; do precompile.tcl; dev_com; com; exit;"
	#vlib modelsim/techmap
	vcom uniphy.vhd -work techmap
	vcom $(GRLIB)/bin/altera/altera_mf.vhd -work altera_mf #fix weird JTAG simulation model
	#MTI_DEFAULT_LIB_TYPE=0 vsim -c -quiet -do "do libs.do; quit"


localclean:
	@-rm -rf uniphy.vhd uniphy uniphy_sim uniphy_example_design uniphy.[bcpqs]* uniphy_sim.f precompile.tcl
	@-rm uniphy_p0_all_pins.txt uniphy_s0_AC_ROM.hex uniphy_s0_AC_ROM.ver uniphy_s0_inst_ROM.hex uniphy_s0_inst_ROM.ver uniphy_s0_sequencer_mem.hex uniphy_s0_sequencer_mem.ver leon3mp_quartus.sld

