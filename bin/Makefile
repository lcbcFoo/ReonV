VER=$(VNAME)2017.2
BID=4194
CC=gcc
SED=sed

ASICLIBS = ihp25 sgb25vrh ut025crh virage rh_lib18t rh_lib18t_io2 rh_lib13t\
	atc18 artisan umc18 virage90 tsmc90 dare nextreme atc18rha_cell smic13 \
	tm65gplus st65lp st65gp cmos9sf nextreme2 gf65g saed32
FPGALIBS = apa proasic3 axcelerator ec fusion unisim virtex virtex5 secureip unimacro altera altera_mf \
	 stratixii eclipsee cycloneiii stratixiii synplify simprim stratixiv \
	proasic3e proasic3l smartfusion2 rtg4

ifeq ("$(GRLIB_CONFIG)","")
GRLIB_CONFIG = dummy
endif
ifeq ("$(GRLIB_SIMULATOR)","")
GRLIB_SIMULATOR = ModelSim
endif

# Select LEON3 version
# The switch between gaisler/leon3 and gaisler/leon3pkgv1v2 is handled
# by a hack in the script generation (see if (test $$l = "leon3") ..)
ifeq ("$(GRLIB_LEON3_VERSION)","")
GRLIB_LEON3_VERSION = 3
else
ifeq ("$(GRLIB_LEON3_VERSION)","2")
DIRSKIP += leon3v3 grfpc grlfpc
DIRADD += leon3v1 leon3ftv2 grfpcv1 grlfpcv1 grfpcft grlfpcft
endif
ifeq ("$(GRLIB_LEON3_VERSION)","1")
DIRSKIP += leon3v3 grfpc grlfpc
DIRADD += leon3v1 leon3ftv1 grfpcv1 grlfpcv1 grfpcft grlfpcft
endif
endif

# Target technology libraries and techmap
ifeq ("$(TECHLIBS)","")
TECHLIBS=$(FPGALIBS) $(ASICLIBS)
endif
# The unisim techmap in GRLIB has been divided into several parts since
# new releases of the Xilinx libs lack support for the older technologies.
# The hack below expands techlibs for technologies that previously only
# required unisim but now also require the techmap/virtex directory
ifneq (,$(findstring unisim,$(TECHLIBS)))
# Virtex2, Virtex4, Spartan3, Spartan3e and Spartan6 currently depend
# on techmap/virtex
ifneq (,$(filter Virtex2 Virtex2p Virtex4 Spartan3 Spartan-3A-DSP Spartan3E Spartan6,$(TECHNOLOGY)))
ifeq (,$(findstring virtex,$(TECHLIBS)))
TECHLIBS+=virtex
endif
endif
endif

# Option to avoid scan of tech/, useful when tech libraries are compiled
# with separate tool:
ifeq ("$(SKIP_SIM_TECHLIBS)","")
XTECHLIBS = $(TECHLIBS:%=tech/% )
endif
SIMLIBS = hynix micron cypress
ACTELLIBS = apa apa3 axcelerator proasic3 proasic3e proasic3l fusion smartfusion2 rtg4
XILINXLIBS = unisim simprim unimacro virtex virtex5
ALTERALIBS = altera_mf stratixii altera cycloneiii stratixiii
ALTERAFILES = $(ALTERALIBS:%=lib/techmap/%) $(RMCOMLIBS:%=lib/tech/%) netlists/altera
LATTICELIBS = ec



BRMLIBS = core1553bbc core1553brm core1553brt gr1553
COREPCILIB = corePCIF
CONTRIBLIBS = openchip gleichmann contrib sun

RMFTLIBS=ihp25 sgb25vrh ut025crh rh_lib18t rh_lib18t_io2 rh_lib13t pere05 \
	rhumc tsmc90 atc18rha_cell
RMCOMLIBS=artisan cust1 virage90 nextreme nextreme2

RMFTLIBSX = $(RMFTLIBS:%=lib/techmap/%) $(RMFTLIBS:%=lib/tech/%)
RMCOMLIBSX = $(RMCOMLIBS:%=lib/techmap/%) $(RMCOMLIBS:%=lib/tech/%)
RMFPGALIBSX = $(ASICLIBS:%=lib/techmap/%) $(ASICLIBS:%=lib/tech/%)

ALIB = alib
ACOM = acom -quiet $(ACOMOPT) -work
ALOG = alog -quiet $(ALOGOPT) -work
AVHDL = avhdl

VLIB = vlib
ifeq ("$(GRLIB_SIMULATOR)", "ALDEC")
VCOM = vcom -incr -nowarn ELAB1_0026 -nowarn COMP96_0259 -quiet $(VCOMOPT) -93
VLOG = vlog -incr -v2k5 -quiet $(VLOGOPT)
SVLOG = vlog -incr -quiet $(VLOGOPT)
else
VCOM = vcom -quiet $(VCOMOPT) -93
VLOG = vlog -quiet $(VLOGOPT)
SVLOG = $(VLOG)
endif


OS = `uname`

ifeq ("$(SIMTOP)","")
SIMTOP=$(TOP)
endif

ifeq ("$(LIBSKIP)","")
XLIBSKIP="x"
else
XLIBSKIP= $(LIBSKIP:%=%|) dummy
endif

XXDIRSKIP=$(DIRSKIP:%=%/core)
YDIRSKIP=$(DIRSKIP) $(XXDIRSKIP) $(LIBSKIP)

ifeq ("$(YDIRSKIP)","")
XDIRSKIP="dummy"
else
XDIRSKIP= $(YDIRSKIP:%=%|) $(LIBSKIP:%=%|) dummy
endif

XFILESKIP = $(FILESKIP:%=%|) $(LIBSKIP:%=*_%.vhd|) dummy
# Note that XFILESKIP is updated in Xilinx targets below


# GRLIB_NHCPU defines # of CPUs available on host for synthesis, value
# may be used in script generation
ifeq ("$(GRLIB_NHCPU)","")
GRLIB_NHCPU=4
endif

all: help

help:
	@echo
	@echo " installation targets: 	  : see doc/grlib.pdf for library installation targets"
	@echo
	@echo " interactive targets:"
	@echo "  simulation:"
	@echo "   make avhdl-launch         : start Active-HDL GUI mode"
	@echo "   make avhdl                : compile design using Active-HDL gui mode"
	@echo "   make ncsim-launch         : start NCSim GUI"
	@echo "   make riviera-launch       : start RivieraPRO"
	@echo "   make vsim-launch          : start ModelSim/QuestaSim"
	@echo "  verification:"
	@echo "   make alint-launch         : start Alint elaboration time linting"
	@echo "   make fpro-launch          : start FormalPro GUI"
	@echo "  implementation:"
	@echo "   make actel-launch         : start Actel Designer for current project"
	@echo "   make ise-launch           : start ISE project navigator for XST project"
	@echo "   make ise-launch-synp      : start ISE project navigator for synplify project"
	@echo "   make libero-launch        : start Microsemi Libero"
	@echo "   make planahead-launch     : start PlanAhead project navigator"
	@echo "   make quartus-launch       : start Quartus for current project"
	@echo "   make quartus-launch-synp  : start Quartus for synplify project"
	@echo "   make synplify-launch      : start Synplify"
	@echo "   make vivado-launch        : start Vivado project navigator"
	@echo "  other GRLIB targets:"
	@echo "   make xgrlib               : start GRLIB GUI"
	@echo
	@echo " batch targets:"
	@echo "  simulation:"
	@echo "   make vsimsa          : compile design using Active-HDL batch mode"
	@echo "   make riviera         : compile design using riviera"
	@echo "   make vsim            : compile design using modelsim"
	@echo "   make ncsim           : compile design using ncsim"
	@echo "   make ghdl            : compile design using GHDL"
	@echo "  verification:"
	@echo "   make alint-comp      : alint compilation time linting"
	@echo "   make fm              : Formal equivalence check using Synopsys Formality"
	@echo "  implementation:"
	@echo "   make actel           : synthesize with synplify, place&route Actel Designer"
	@echo "   make dc              : synthesize design usign Synopsys Design Compiler"
	@echo "   make ise             : synthesize and place&route with Xilinx ISE"
	@echo "   make ise-map         : synthesize design using Xilinx XST"
	@echo "   make ise-prec        : synthesize with precision, place&route with Xilinx ISE"
	@echo "   make ise-synp        : synthesize with synplify, place&route with Xilinx ISE"
	@echo "   make isp-synp        : synthesize with synplify, place&route with ISPLever"
	@echo "   make planahead       : synthesize and place&route with Xilinx PlanAhead"
	@echo "   make precision       : synthesize design using precision"
	@echo "   make quartus         : synthesize and place&route using Quartus"
	@echo "   make quartus-map     : synthesize design using Quartus"
	@echo "   make quartus-synp    : synthesize with synplify, place&route with Quartus"
	@echo "   make synplify        : synthesize design using synplify"
	@echo "   make vivado          : synthesize and place&route with Xilinx Vivado"
	@echo "  other GRLIB targets:"
	@echo "   make scripts         : generate compile scripts only"
	@echo "   make clean           : remove all temporary files except scripts"
	@echo "   make distclean       : remove all temporary files"
	@echo

make xgrlib:
	  @if test -r "/mingw/bin/wish84.exe"; then \
	    if !(test -r "/mingw/bin/echo.bat"); then \
	      cp $(GRLIB)/bin/echo.bat /mingw/bin/echo.bat; \
	    fi; \
	    if !(test -r "/mingw/bin/wish"); then \
	      cp $(GRLIB)/bin/wish /mingw/bin/wish; \
	    fi; \
	  fi; \
	unset LD_LIBRARY_PATH ; \
	$(GRLIB)/bin/xgrlib.tcl $(TOP) $(TECHNOLOGY) $(DEVICE) $(BOARD)

############  AHB ROM Generation     ########################

FILE=prom.exe

ahbrom: $(GRLIB)/bin/ahbrom.c
	@if test -r "/mingw/bin/gcc.exe"; then \
	  $(CC) $(GRLIB)/bin/ahbrom.c -o ahbrom -lwsock32; \
	else \
	  $(CC) $(GRLIB)/bin/ahbrom.c -o ahbrom; \
	fi;

ahbrom.vhd:
	make ahbrom
	sparc-elf-objcopy -O binary $(FILE) ahbrom.bin
	./ahbrom ahbrom.bin ahbrom.vhd

ahbrom64.vhd:
	make ahbrom
	sparc-elf-objcopy -O binary $(FILE) ahbrom.bin
	./ahbrom ahbrom.bin ahbrom64.vhd 64

ahbrom128.vhd:
	make ahbrom
	sparc-elf-objcopy -O binary $(FILE) ahbrom.bin
	./ahbrom ahbrom.bin ahbrom128.vhd 128

#########    Active-HDL batch mode targets   ############

vsimsa: compile.vsim
	@cat libs.do | sed -e s/modelsim/activehdl/ | sed -e s/vlib/alib/ > alibs-batch.do
	@echo "do alibs-batch.do" > vsimsa-batch.do
	@vsimsa vsimsa-batch.do
	@vmap work activehdl/work
	@make -f make.vsim
	@-rm -f alibs-batch.do vsimsa-batch.do

vsimsa-run:
	@vsim $(SIMTOP) <  $(GRLIB)/bin/runvsim.do

vsimsa-launch: vsimsa-run

vsimsa-clean:
	-rm -rf activehdl vsimsa.cfg library.cfg wave.asdb alibs-batch.do vsimsa-batch.do

#vsimsa-modelsim:
#	echo "importmodelsim $(SIMTOP).mpf" . > activehdl.tcl
#	echo "quiet on" >> activehdl.tcl
#	echo "SET SIM_WORKING_FOLDER ..\\.." >> activehdl.tcl
#	AVHDL -do activehdl.tcl &

#########    Active-HDL gui mode targets   ############

avhdl: compile.asim
	@echo "createdesign work ." > avhdl.tcl
	@echo "opendesign -a work.adf" >> avhdl.tcl
	@cat alibs.do >> avhdl.tcl
	@echo "" >> avhdl.tcl
	@cat make.asim-addfile >> avhdl.tcl
	@cat make.asim >> avhdl.tcl
	@echo "" >> avhdl.tcl
	@echo SET SIM_WORKING_FOLDER $$\DSN/.. >> avhdl.tcl
	@echo "" >> avhdl.tcl
	@echo asim work.$(SIMTOP) >> avhdl.tcl

avhdl-run: avhdl-launch

avhdl-launch:
	@avhdl -do avhdl.tcl

avhdl-clean:
	-rm -rf work avhdl.tcl vsimsa.cfg wave.asdb

#########    Riviera targets    ############

ifeq ("$(GRLIB_SIMULATOR)", "ALDEC")
riviera: make.riviera
	@MTI_DEFAULT_LIB_TYPE=0 vsimsa -quiet -do "do libs.do; quit"
	make -f make.riviera

riviera-run:
ifeq ("$(VSIMOPT)","")
	@vsim -c $(SIMTOP) -do $(GRLIB)/bin/runvsim.do
else
	@vsim -c $(VSIMOPT)
endif

riviera-launch:
ifeq ("$(VSIMOPT)","")
	@vsim $(SIMTOP) -do $(GRLIB)/bin/runvsim.do
else
	@vsim $(VSIMOPT)
endif

else
### Riviera targets using WS

riviera_ws: riviera_ws_create.do
	vsimsa -quiet -do "do riviera_ws_create.do; quit"

riviera: riviera_ws
	vsimsa -quiet -do "workspace.open riviera_ws/riviera_ws.rwsp; workspace.compile; quit"

ifeq ("$(ASIMOPT)","")
ASIMOPT = $(VSIMOPT)
endif

# Allow to override
ifeq ("$(RIVIERA_DO)","")
RIVIERA_DO = workspace.open riviera_ws/riviera_ws.rwsp; simulation.initialize $(SIMTOP)
endif

riviera-run: riviera_ws
	cp *.srec riviera_ws/
ifeq ("$(VSIMOPT)","")
	vsimsa -c -do "$(RIVIERA_DO); do $(realpath $(GRLIB))/bin/runvsim.do"
else
	vsimsa -c $(ASIMOPT) -do "$(RIVIERA_DO); $(ASIMDO)" 
endif

riviera-launch: riviera_ws
	cp *.srec riviera_ws/
ifeq ("$(VSIMOPT)","")
	riviera -do "$(RIVIERA_DO); do $(realpath $(GRLIB))/bin/runvsim.do"
else
	riviera $(ASIMOPT) -do "$(RIVIERA_DO); $(ASIMDO)"
endif

endif ### end of Riviera targets using WS

riviera-clean:
	-rm -rf riviera_ws riviera_ws_*.do vsimsa.cfg wave.asdb library.cfg .riviera_project rlibs.do compile.riviera make.riviera dataset.asdb

#########    Alint targets   ############

# Alint compilation time linting
alint-comp: compile.vsim
	@vsim -c -do "do libs.do; quit"
	@sed -r -e 's/\b(vcom|vlog)\b/\1 -alint -alint_elabchecks -alint_avdb alint\.avdb/' make.vsim > make.alint
	@make -f make.alint
	@vmap work modelsim/work

# Alint elaboration time linting
alint-elab: alint-comp
	vlint -c -alint_maxwarn none -alint_maxrulewarn none -alint_avdb alint.avdb -asim $(TOP)

#########    Modelsim targets   ############

UNISIMSRC = $(XILINX)/vhdl/src/unisims/unisim_VPKG.vhd  \
	$(XILINX)/vhdl/src/unisims/unisim_VCOMP.vhd \
	$(XILINX)/vhdl/src/unisims/unisim_VITAL.vhd

SIMPRIMSRC = $(XILINX)/vhdl/src/simprims/simprim_Vpackage.vhd  \
	$(XILINX)/vhdl/src/simprims/simprim_Vcomponents.vhd \
	$(XILINX)/vhdl/src/simprims/simprim_VITAL.vhd

vsim: make.work
	@make -f make.work

make.work: compile.vsim modelsim
	@make -f make.vsim
	@echo "" > make.work
	@for i in `cat libs.txt`; do vmake $$i >> make.work ; done
	@cat make.work | sed 's/\([a-zA-Z]\)\(:[\\\/]\)/\/cygdrive\/\L\1\//' > make.work2
	@mv make.work2 make.work

# If we have paths with ':' we assume that we are running on Cygwin:
vsim-fix:
#	@cat make.work | sed 's/\([a-zA-Z]\)\(:\\\)/\/\1\//'  > make.work2
	@cat make.work | sed 's/\([a-zA-Z]\)\(:[\\\/]\)/\/cygdrive\/\L\1\//' > make.work2
	@mv make.work2 make.work

VLOGANOPT = 
SVLOGANOPT =
VHDLANOPT =
VCSELAB = -debug_access+all

vcs-comp:
	@sh vcs_libs
	@make -f make.simv

vcs-elab: vcs-comp
	vcs work.$(SIMTOP) $(VCSELAB)

vcs-run: vcs-elab
	./simv

vcs-launch: vcs-elab
	./simv -gui

vcs-clean:
	rm -rf vcs/ simv.daidir/ csrc DVEfiles/
	rm -f simv vcs_libs synopsys_sim.setup .vdbg_combination_lock .vlogansetup.args .vlogansetup.env ucli.key inter.vpd


modelsim: compile.vsim
	@MTI_DEFAULT_LIB_TYPE=0 vsim -c -quiet -do "do libs.do; quit"

vsim-grlib: modelsim
	make vsim
#	@for i in `cat libs.txt`; do \
#	  make -f modelsim/make.$$i ; \
#	done ;

vsim-run: vsim
ifeq ("$(VSIMOPT)","")
	@vsim -c $(SIMTOP) <  $(GRLIB)/bin/runvsim.do
else
	@vsim -c $(VSIMOPT)
endif

vsim-launch: scripts modelsim
ifeq ("$(VSIMOPT)","")
	@vsim -i -quiet $(SIMTOP)
else
	vsim -i -quiet $(VSIMOPT)
endif

vsim-mcb: scripts
	-vlib modelsim
	-vlib modelsim/unisim
	vcom -quiet -explicit -work unisim $(XILINX)/vhdl/src/unisims/secureip/MCB.vhd

vsim-unisim: modelsim
	vcom -quiet -explicit -work unisim $(UNISIMSRC)

vsim-simprim: modelsim
	vcom -quiet -explicit -work simprim -ignorevitalerrors $(SIMPRIMSRC)

# Ugly hardcode of testbench.vhd..
vsim-netgen-syn:
	vcom -quiet -explicit -work work netgen/translate/$(TOP)_translate.vhd
	vcom -quiet -explicit -work work testbench.vhd

vsim-netgen-par:
	vcom -quiet -explicit -work work netgen/par/$(TOP)_timesim.vhd
	vcom -quiet -explicit -work work testbench.vhd

vsim-clean:
	-rm -rf modelsim transcript *.mti stdout.log vsim.wlf vsim_stacktrace.vstf \
	$(SIMTOP).mpf.bak $(SIMTOP).mti *.mpf wlft*

#########   FormalPro targets ############

fpro-launch: $(TOP)_rtl_fpro.fl
	formalpro -gui -a -fl $(TOP)_rtl_fpro.fl -mod $(TOP)

# Target rtl2rtl for sanity check
fpro-launch-rtl2rtl: $(TOP)_rtl_fpro.fl
	formalpro -gui -a -fl $(TOP)_rtl_fpro.fl -mod $(TOP) -b -fl $(TOP)_rtl_fpro.fl -mod $(TOP)

fpro-run-rtl2rtl: $(TOP)_rtl_fpro.fl
	formalpro -a -fl $(TOP)_rtl_fpro.fl -mod $(TOP) -b -fl $(TOP)_rtl_fpro.fl -mod $(TOP)

fpro-clean:
	-rm -rf $(TOP)_rtl_fpro.fl formalpro.log formalpro.cache


#########   GHDL targets   ############
# Outdated files are resolved by "GHDLM".

GHDL ?= ghdl
GHDLI = $(GHDL) -i
GHDLM = $(GHDL) -m
GHDLMOPT ?= -fexplicit --ieee=synopsys --mb-comments --warn-no-binding
GHDLRUNOPT ?= --assert-level=error --ieee-asserts=disable

# Compile design

.PHONY: ghdl-import
ghdl-import gnu: make.ghdl
	make -f make.ghdl ghdl-import

.PHONY: ghdl
ghdl: $(SIMTOP)

# Analyse outdated files and elaborate design.
.PHONY: $(SIMTOP)
$(SIMTOP): gnu
	$(GHDLM) $(GHDLMOPT) --workdir=gnu/work --work=work `cat ghdl.path` $@

# Run testbench SIMTOP
.PHONY: ghdl-run
ghdl-run: $(SIMTOP)
	./$(SIMTOP) $(GHDLRUNOPT)

ghdl-clean:
	-rm -rf gnu $(SIMTOP) make.ghdl

#########   NcSim targets   ############

ncsim: xncsim/done
	ncupdate $(SIMTOP)

ncsim-run: ncsim
	ncsim $(SIMTOP)

ncsim-launch: ncsim
	ncsim -gui $(SIMTOP)&

xncsim xncsim/done : compile.ncsim
	-rm -rf xncsim
	make -f make.ncsim
	touch xncsim/done

ncsim-clean:
	-rm -rf xncsim nc*.log ncsim.key

#########   Lattice ISPLEVER targets   ############



isp-synp: $(TOP)_synplify.prj synplify/$(TOP).edf
	$(GRLIB)/bin/route_lattice $(TOP) $(UCF) $(PART) synplify $(ISPLIB) $(ISPPACKAGE) $(BITGEN)

isp-prec: $(TOP)_precision.prj precision/$(TOP).edf
	$(GRLIB)/bin/route_lattice $(TOP) $(UCF) $(PART) precision $(ISPLIB) $(ISPPACKAGE) $(BITGEN)

isp-launch-synp: $(TOP)_synplify.prj synplify/$(TOP).edf
	projnav ./$(TOP).syn

isp-launch-prec: $(TOP)_precision.prj precision/$(TOP).edf
	projnav ./$(TOP)_precision.syn

diamond-launch: $(TOP).ldf
	diamond $(TOP).ldf

isp-prom:
	synsvf $(PROMGENPAR)
isp-clean:
	-rm -rf $(TOP).dir *.jid *.alt *.lci *.mt *.nc1 *.nc2 *.p?t \
	*.err compxlib.cfg *.jhd *.lct $(TOP).log *.ngy *.prf  *.pt *.rev \
	*.syn *.t2b *.tcm *.tcp *.tw1 $(TOP).tcl *.sty *.svl *.env fonts.dir \
	$(TOP)_tcl.ini lattice $(TOP).ldf $(TOP).lpf


#########   Xilinx targets    ############
ifeq ("$(NETLISTTECH)","")
# Some netlists are reused for other FPGA families
ifeq ("$(TECHNOLOGY)","zynq7000")
NETLISTTECH = Zynq
else
ifeq ("$(TECHNOLOGY)","Virtex7")
NETLISTTECH = Virtex7
else
ifeq ("$(TECHNOLOGY)","Kintex7")
NETLISTTECH = Kintex7
else
ifeq ("$(TECHNOLOGY)","Artix7")
NETLISTTECH = Artix7
else
ifeq ("$(TECHNOLOGY)","Spartan6")
NETLISTTECH = Spartan3
else
ifeq ("$(TECHNOLOGY)","Virtex6")
NETLISTTECH = Virtex6
else
ifeq ("$(TECHNOLOGY)","Virtex2p")
NETLISTTECH = Virtex2
else
ifeq ("$(TECHNOLOGY)","Spartan3A")
NETLISTTECH = Spartan3
else
ifeq ("$(TECHNOLOGY)","Spartan3E")
NETLISTTECH = Spartan3
else
ifeq ("$(TECHNOLOGY)","Spartan-3A-DSP")
NETLISTTECH = Spartan3
else
NETLISTTECH = $(TECHNOLOGY)
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif

#########   Xilinx ISE targets   ############

XSTVHDL = elaborate -ifmt vhdl -work_lib
XSTVLOG = elaborate -ifmt verilog -work_lib
XSTLIBSKIPX = $(ASICLIBS) $(BRMLIBS) $(ACTELLIBS) $(ALTERALIBS) \
	$(LATTICELIBS) $(COREPCILIB) $(SIMLIBS)
XSTLIBSKIP = $(XSTLIBSKIPX:%=%|) dware
XSTDIRSKIPX = $(ASICLIBS) $(ACTELLIBS) $(ALTERALIBS) $(LATTICELIBS)
XSTDIRSKIP = $(XSTDIRSKIPX:%=%|) dware
#XSTSKIPX = $(XSTLIBSKIPX:%=*_%.vhd |)
XSTSKIP = $(XSTSKIPX) b1553* | pci_components* | pcicore* | snpsmul.vhd

ifeq ("$(ISETECH)","")
ISETECH=$(TECHNOLOGY)
endif

ifeq ("$(ISE11TECH)","")
ISE11TECH=$(ISETECH)
endif

# Xilinx FT-FPGA addon package targets, note: may modify COMPXLIBTECH
ifneq ("$(GRLIB)","")
-include $(GRLIB)/bin/xtmr/Makefile
endif

## Xilinx ISE project properties that can be overrideen
# Pack I/O Registers/Latches into IOBs
ifeq ("$(GRLIB_XIL_PN_Pack_Reg_Latches_into_IOBs)","")
GRLIB_XIL_PN_Pack_Reg_Latches_into_IOBs=For Inputs and Outputs
endif
# Simulator
ifeq ("$(GRLIB_XIL_PN_Simulator)","")
ifeq ("$(GRLIB_SIMULATOR)","ModelSim")
GRLIB_XIL_PN_Simulator=Modelsim-SE VHDL
else
ifeq ("$(GRLIB_SIMULATOR)","ModelSim-SE")
GRLIB_XIL_PN_Simulator=Modelsim-SE VHDL
else
ifeq ("$(GRLIB_SIMULATOR)","ModelSim-PE")
GRLIB_XIL_PN_Simulator=ModelSim-PE VHDL
else
GRLIB_XIL_PN_Simulator=ISim \(VHDL/Verilog\)
endif
endif
endif
endif

## End of Xilinx ISE project properties

NUCF = $(UCF:%=-uc % )

ise: $(TOP).ngc
	ngdbuild  $(TOP).ngc -aul $(NUCF) -p $(DEVICE) -sd $(GRLIB)/netlists/xilinx/$(NETLISTTECH)
	map -pr b -w -ol $(EFFORT) -p $(DEVICE) $(TOP) $(ISEMAPOPT)
	par -ol $(EFFORT) -w $(TOP) $(TOP).ncd
	trce -v 5 $(TOP).ncd $(TOP).pcf
	bitgen $(TOP) -d -m -w -f $(BITGEN)

ise-synp: $(TOP)_synplify.prj synplify/$(TOP).edf
	ngdbuild  synplify/$(TOP).edf -aul $(NUCF) -p $(DEVICE) -sd $(GRLIB)/netlists/xilinx/$(NETLISTTECH)
	map -pr b -w -ol $(EFFORT) -p $(DEVICE) $(TOP) $(ISEMAPOPT)
	par -ol $(EFFORT) -w $(TOP) $(TOP).ncd
	trce -v 5 $(TOP).ncd $(TOP).pcf
	bitgen $(TOP) -d -m -w -f $(BITGEN)

ise-prec: $(TOP).psp precision/$(TOP).edf
	ngdbuild   precision/$(TOP).edf -aul $(NUCF) -p $(DEVICE) -sd $(GRLIB)/netlists/xilinx/$(NETLISTTECH)
	map -pr b -w -ol $(EFFORT) -p $(DEVICE) $(TOP) $(ISEMAPOPT)
	par -ol $(EFFORT) -w $(TOP) $(TOP).ncd
	trce -v 5 $(TOP).ncd $(TOP).pcf
	bitgen $(TOP) -d -m -w -f $(BITGEN)

ise-launch8 xst-launch: $(TOP).npl $(TOP)_ise.tcl
	ise $(TOP).npl>& ise.err&

ise-launch10 ise-launch9: $(TOP).ise
	ise $(TOP).ise

ise-launch11 : $(TOP).xise
	ise $(TOP).xise

ise-launch :
	@isever=`promgen | grep Rele | awk '{print $$2}'`; \
	case $$isever in \
	8*) \
		make ise-launch8 ;;\
	9*) \
		make ise-launch9 ;;\
	10*) \
		make ise-launch10 ;;\
	*) \
		make ise-launch11 ;;\
	esac



ise-launch-synp: $(TOP).npl $(TOP)_synplify.prj synplify/$(TOP).edf $(TOP)_synplify.prj
	ise $(TOP)_synplify.npl>& ise.err&

$(TOP).xst: compile.xst $(TOP)_files.prj
	@rm -f $(TOP).xst
	@$(GRLIB)/bin/xstrun $(TOP) $(TOP).vhd  $(DEVICE) >> $(TOP).xst
	@echo -ofn $(TOP) $(XSTOPT) -define {XSTDUMMY $(SYNPVLOGDEFS)} -sd $(GRLIB)/netlists/xilinx/$(NETLISTTECH) >> $(TOP).xst

ise-xstmod :
	$(GRLIB)/bin/xstmod $(CORE) $(CORE).vhd $(DEVICE) vhdl  > tmp.xst
	xst -ifn tmp.xst

ise-map xst-map ise-xst xst: $(TOP).ngc

$(TOP).ngc: $(TOP).xst $(VHDLSYNFILES) $(VERILOGSYNFILES) compile.xst
	-rm -rf xst
	@-mkdir xst xst/projnav.tmp
	xst -ifn $(TOP).xst

$(TOP).ngd:
	@if test -r "$(TOP).ngc"; then \
	  ngdbuild $(TOP).ngc -aul $(NUCF) -p $(DEVICE) -sd $(GRLIB)/netlists/xilinx/$(NETLISTTECH) ; \
	fi; \
	if test -r "synplify/$(TOP).edf"; then \
	  ngdbuild  synplify/$(TOP).edf -aul $(NUCF) -p $(DEVICE) -sd $(GRLIB)/netlists/xilinx/$(NETLISTTECH) ; \
	fi; \
	if test -r "precision/$(TOP).edf"; then \
	  ngdbuild   precision/$(TOP).edf -aul $(NUCF) -p $(DEVICE) -sd $(GRLIB)/netlists/xilinx/$(NETLISTTECH) ; \
	fi;

$(TOP).ise: $(TOP)_ise.tcl
	@echo "Creating $(TOP).ise using xtclsh - this can take up to 20 minutes."
	xtclsh $(TOP)_ise.tcl

ise-prom:
ifeq ("$(PROMGENPAR)","")
	@echo "no prom programming support for this board"
	@exit 1
else
	promgen $(PROMGENPAR)
	cp $(TOP).bit $(BOARD).bit
	cp $(TOP).msk $(BOARD).msk
endif

ise-cp-ref:
	cp bitfiles/*.* .

ise-prog-prom: ise-prom
	impact -batch $(GRLIB)/boards/$(BOARD)/prom.cmd

ise-prog-prom-usb: ise-prom
	impact -batch $(GRLIB)/boards/$(BOARD)/prom-usb.cmd

ise-prog-prom-ref: ise-cp-ref ise-prom
	impact -batch $(GRLIB)/boards/$(BOARD)/prom.cmd

ise-prog-prom-ref-usb: ise-cp-ref ise-prom
	impact -batch $(GRLIB)/boards/$(BOARD)/prom-usb.cmd

ise-prog-fpga:
	cp $(TOP).bit $(BOARD).bit
	cp $(TOP).msk $(BOARD).msk
	impact -batch $(GRLIB)/boards/$(BOARD)/fpga.cmd

ise-prog-fpga-usb:
	cp $(TOP).bit $(BOARD).bit
	cp $(TOP).msk $(BOARD).msk
	impact -batch $(GRLIB)/boards/$(BOARD)/fpga-usb.cmd


ise-prog-fpga-ref: ise-cp-ref
	cp $(TOP).bit $(BOARD).bit
	cp $(TOP).msk $(BOARD).msk
	impact -batch $(GRLIB)/boards/$(BOARD)/fpga.cmd

ise-prog-fpga-ref-usb: ise-cp-ref
	cp $(TOP).bit $(BOARD).bit
	cp $(TOP).msk $(BOARD).msk
	impact -batch $(GRLIB)/boards/$(BOARD)/fpga-usb.cmd

ise-netgen-syn: $(TOP).ngd
	netgen -rpw 100 -tpw 100 -ar Structure -tm $(TOP) \
	-w -dir netgen/translate -ofmt vhdl -sim $(TOP).ngd $(TOP)_translate.vhd

ise-netgen-par:
	netgen -s 1 -pcf $(TOP).pcf -rpw 100 -tpw 0 -ar Structure -tm $(TOP) \
	-insert_pp_buffers true -w -dir netgen/par -ofmt vhdl -sim $(TOP).ncd $(TOP)_timesim.vhd

ise-clean xst-clean:
	-rm -rf xst *.srp xstmods *.twr *.pad _impact* coregen.log \
	tmp.xst *.ngc __projnav* *.stx *.lso *.dhp automake.log \
	$(TOP)*_vhdl.prj  *.bit *.bgn *.bld \
	*.cmd_log *.ll *.mrp *.msk *.ncd *.ngd *.syr *.xpi *.csv \
	*pad.txt *.ngm *.lst *.drc *.par *.pcf *.ngo *.mcs *.prm \
	*.sig *.rba *.rbb *.rbd *.rbt *.msd _ngo _impact* stdout.log \
	ngd2vhdl.log _xmsgs tmp.txt $(TOP)*.unroutes $(TOP)*_usage.xml *.cfi \
	$(TOP)*.ise* $(TOP)*.npl* xlnx_auto_0* *.xrpt *.ptwx $(TOP)*_xdb \
	$(TOP)*_summary.html $(TOP)*.restore $(TOP).ntrc_log $(TOP)*.twx \
	$(TOP)*_map.map $(TOP)*.ngr $(TOP)*.xise $(TOP)*.gise \
	device_usage_statistics.html* __*.lock \
	*.xwbt *webtalk* par_usage_statistics.html fuse.log fuse.xmsgs \
	fuseRelaunch.cmd iseconfig isim isim.cmd isim.log testbench_beh.prj \
	version_isim_beh.wdb xilinxsim.ini .ngc2edfcache netgen

UNISIM = $(XILINX)/vhdl/src/unisims
UNISIMFILES = unisim_VPKG.vhd unisim_VCOMP.vhd unisim_VITAL.vhd \
	unisim_virtex5_SMODEL.vhd
UNISIMSECIPFILES = MCB.vhd GTXE1.vhd \
	GTP_DUAL.vhd GTPA1_DUAL.vhd GT11.vhd \
	GT11CLK.vhd GT11CLK_MGT.vhd GT11_CUSTOM.vhd \
	GT11_DUAL.vhd GTX_DUAL.vhd GTHE1_QUAD.vhd \
	PCIE_2_0.vhd PCIE_A1.vhd
UNISIMSECIPFILESSKIP = $(UNISIMSECIPFILES:%=|%)

# Workaround for secureip files being part of unisim and secureip techlib
# being unavailable
ifneq (,$(findstring unisim,$(TECHLIBS)))
ifeq (,$(filter secureip secureip_ver,$(TECHLIBS)))
# Skip unisim secureip files if secureip is missing from techlibs.
# Bad things will happen if there are file name collisions with
# other libraries..
XFILESKIP+= $(UNISIMSECIPFILESSKIP)
endif
endif

GRUNISIM = $(GRLIB)/lib/tech/unisim/ise
SIMPRIM = $(XILINX)/vhdl/src/simprims
UNIMACRO = $(XILINX)/vhdl/src/unimacro
UNISIMS_VER = $(XILINX)/verilog/src/unisims
GRUNISIMS_VER = $(GRLIB)/lib/tech/unisims_ver/ise
XILINXCORELIB_VER =  $(XILINX)/verilog/src/
GRXILINXCORELIB_VER = $(GRLIB)/lib/tech/xilinxcorelib_ver/ise


install-unimacro:
	@echo UNIMACRO source path: $(UNIMACRO); \
	if test -r $(UNIMACRO); then \
	  cp $(UNIMACRO)/*.vhd $(GRLIB)/lib/tech/unimacro/ise; \
	  for i in $(UNIMACRO)/*.vhd ; do basename $$i >> $(GRLIB)/lib/tech/unimacro/ise/vhdlsyn.txt; done; \
        fi

remove-unimacro:
	@-rm $(GRLIB)/lib/tech/unimacro/ise/*.vhd; echo "" > $(GRLIB)/lib/tech/unimacro/ise/vhdlsyn.xt

install-unisim:
ifeq ("$(GRLIB_SIMULATOR)","Xilinx")
	@echo "GRLIB_SIMULATOR is Xilinx. Unisim installation not required, aborted."
else
	@echo UNISIM source path: $(UNISIM); \
	for i in $(UNISIMFILES); do \
	  if test -r $(UNISIM)/$$i; then \
	    cp  $(UNISIM)/$$i  $(GRUNISIM);\
	    echo  installing $$i ;\
	  else \
	    if [ "unisim_VITAL.vhd" = $$i ]; then \
	      if test -r $(UNISIM)/primitive/vhdl_analyze_order; then \
		echo "creating unisim_VITAL.vhd from primitives" ; \
		echo "" >  $(GRUNISIM)/unisim_VITAL.vhd; \
		for j in `cat $(UNISIM)/primitive/vhdl_analyze_order`; do \
		  cat $(UNISIM)/primitive/$$j >> $(GRUNISIM)/unisim_VITAL.vhd; \
		done ; \
	      fi ; \
	    fi ; \
	  fi ; \
	done
endif

install-xilinxcorelib_ver:
ifeq ("$(GRLIB_SIMULATOR)","Xilinx")
	@echo "GRLIB_SIMULATOR is Xilinx. Library installation not required, aborted."
else
	@if [ -d $(GRXILINXCORELIB_VER) ]; then \
	echo "xilinxcorelib_ver library already installed"; else \
	echo installing xilinxcorelib_ver in $(GRXILINXCORELIB_VER) ; \
	mkdir -p $(GRXILINXCORELIB_VER) ; \
	for i in $(XILINXCORELIB_VER)/*.v; do \
	  cp $$i $(GRXILINXCORELIB_VER) ; \
	  echo `basename $$i`  >>  $(GRXILINXCORELIB_VER)/vlogsim.txt ; \
	done; fi
endif

install-unisim_ver: install-xilinxcorelib_ver
ifeq ("$(GRLIB_SIMULATOR)","Xilinx")
	@echo "GRLIB_SIMULATOR is Xilinx. Unisim installation not required, aborted."
else
	@if [ -f $(GRUNISIMS_VER)/noexist ]; then \
	  echo "unisims_ver library already installed"; else \
	  echo installing unisims_ver in $(GRUNISIMS_VER) ; \
	  mkdir -p $(GRUNISIMS_VER) ; \
	  for i in $(UNISIMS_VER)/*.v; do \
	    cat $$i  >> $(GRUNISIMS_VER)/unisims_ver.v ; \
#	    cp $$i $(GRUNISIMS_VER) ; \
#	    echo `basename $$i`  >>  $(GRUNISIMS_VER)/vlogsim.txt ; \
	  done ; \
	  echo unisims_ver.v > $(GRUNISIMS_VER)/vlogsim.txt ; \
	fi
endif

# Undocumented target, functionality was previously part of install-unisim target.
patch-unisim:
	if (test -r $(GRUNISIM)/unisim_VITAL.vhd); then \
	  cat $(GRUNISIM)/unisim_VITAL.vhd | sed -e s/'SIM_COLLISION_CHECK : string := "ALL"'/'SIM_COLLISION_CHECK : string := "GENERATE_X_ONLY"'/ \
	   > $(GRUNISIM)/unisim_vitalx.vhd;\
	   cp $(GRUNISIM)/unisim_vitalx.vhd $(GRUNISIM)/unisim_VITAL.vhd;\
	   rm $(GRUNISIM)/unisim_vitalx.vhd;\
	  echo  patching unisim_VITAL.vhd ;\
	fi

ifeq ("$(GRLIB_SIMULATOR)","ALDEC")
XILINX_SECUREIP_PATH = aldec
else
ifeq ("$(GRLIB_SIMULATOR)","ALDEC_RWS")
XILINX_SECUREIP_PATH = aldec
else
XILINX_SECUREIP_PATH = mti
endif
endif

install-secureip: install-unisim
ifeq ("$(GRLIB_SIMULATOR)","Xilinx")
	@echo "GRLIB_SIMULATOR is Xilinx. SecureIP installation not required, aborted."
else
	@echo UNISIM source path: $(UNISIM); \
	for i in $(UNISIMSECIPFILES); do \
	  cp  $(UNISIM)/secureip/$$i  $(GRUNISIM);\
	  echo  installing $$i ;\
	done
	@if (test -r $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/mcb_$(XILINX_SECUREIP_PATH)); then \
	  echo  installing $(XILINX)/secureip ;\
	  cp  $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/mcb_$(XILINX_SECUREIP_PATH)/*.vp  $(GRLIB)/lib/tech/secureip/ise;\
	fi ; \
	if (test -r $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/pcie_2_0_$(XILINX_SECUREIP_PATH)); then \
	  cp  $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/pcie_2_0_$(XILINX_SECUREIP_PATH)/*.vp  $(GRLIB)/lib/tech/secureip/ise; \
	fi ; \
	if (test -r $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtxe1_$(XILINX_SECUREIP_PATH)); then \
	  cp  $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtxe1_$(XILINX_SECUREIP_PATH)/*.vp  $(GRLIB)/lib/tech/secureip/ise; \
	fi ; \
	if (test -r $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtpa1_dual_$(XILINX_SECUREIP_PATH)); then \
	  cp  $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtpa1_dual_$(XILINX_SECUREIP_PATH)/*.vp  $(GRLIB)/lib/tech/secureip/ise; \
	fi ; \
	if (test -r $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtp_dual_fast_$(XILINX_SECUREIP_PATH)); then \
	  cp  $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtp_dual_fast_$(XILINX_SECUREIP_PATH)/*.vp  $(GRLIB)/lib/tech/secureip/ise; \
	fi ; \
	if (test -r $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtx_dual_fast_$(XILINX_SECUREIP_PATH)); then \
	  cp  $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtx_dual_fast_$(XILINX_SECUREIP_PATH)/*.vp  $(GRLIB)/lib/tech/secureip/ise; \
	fi ; \
	if (test -r $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/pcie_a1_$(XILINX_SECUREIP_PATH)); then \
	  cp  $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/pcie_a1_$(XILINX_SECUREIP_PATH)/*.vp  $(GRLIB)/lib/tech/secureip/ise; \
	fi
endif

install-secureip_ver: install-unisim_ver
ifeq ("$(GRLIB_SIMULATOR)","Xilinx")
	@echo "GRLIB_SIMULATOR is Xilinx. SecureIP installation not required, aborted."
else
	@echo UNISIM source path: $(UNISIM); \
	for i in $(UNISIMSECIPFILES); do \
	  cp  $(UNISIM)/secureip/$$i  $(GRUNISIM);\
	  echo  installing $$i ;\
	done
	@if (test -r $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/mcb_$(XILINX_SECUREIP_PATH)); then \
	  echo  installing $(XILINX)/secureip ;\
	  cp  $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/mcb_$(XILINX_SECUREIP_PATH)/*.vp  $(GRLIB)/lib/tech/secureip_ver/ise;\
	fi ; \
	if (test -r $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/pcie_2_0_$(XILINX_SECUREIP_PATH)); then \
	  cp  $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/pcie_2_0_$(XILINX_SECUREIP_PATH)/*.vp  $(GRLIB)/lib/tech/secureip_ver/ise; \
	fi ; \
	if (test -r $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtxe1_$(XILINX_SECUREIP_PATH)); then \
	  cp  $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtxe1_$(XILINX_SECUREIP_PATH)/*.vp  $(GRLIB)/lib/tech/secureip_ver/ise; \
	fi ; \
	if (test -r $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtpa1_dual_$(XILINX_SECUREIP_PATH)); then \
	  cp  $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtpa1_dual_$(XILINX_SECUREIP_PATH)/*.vp  $(GRLIB)/lib/tech/secureip_ver/ise; \
	fi ; \
	if (test -r $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtp_dual_fast_$(XILINX_SECUREIP_PATH)); then \
	  cp  $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtp_dual_fast_$(XILINX_SECUREIP_PATH)/*.vp  $(GRLIB)/lib/tech/secureip_ver/ise; \
	fi ; \
	if (test -r $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtx_dual_fast_$(XILINX_SECUREIP_PATH)); then \
	  cp  $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/gtx_dual_fast_$(XILINX_SECUREIP_PATH)/*.vp  $(GRLIB)/lib/tech/secureip_ver/ise; \
	fi ; \
	if (test -r $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/pcie_a1_$(XILINX_SECUREIP_PATH)); then \
	  cp  $(XILINX)/secureip/$(XILINX_SECUREIP_PATH)/pcie_a1_$(XILINX_SECUREIP_PATH)/*.vp  $(GRLIB)/lib/tech/secureip_ver/ise; \
	fi
endif

remove-secureip uninstall-secureip remove-unisim uninstall-unisim:
	@-rm $(GRLIB)/lib/tech/secureip/ise/*.vp $(GRLIB)/lib/tech/secureip_ver/ise/*.vp 
	@-rm -r $(GRLIB)/lib/tech/unisims_ver/ise $(GRLIB)/lib/tech/xilinxcorelib_ver/ise
	@-rm $(GRLIB)/lib/tech/unisim/ise/*.vhd

# Simulator compxlib
ifeq ("$(GRLIB_XIL_compxlib_Simulator)","")
# Set default to ModelSim for GRLIB_XIL_compxlib_Simulator
GRLIB_XIL_compxlib_Simulator=mti_se
ifeq ("$(GRLIB_SIMULATOR)","ModelSim")
GRLIB_XIL_compxlib_Simulator=mti_se
endif
ifeq ("$(GRLIB_SIMULATOR)","ModelSim-PE")
GRLIB_XIL_compxlib_Simulator=mti_pe
endif
ifeq ("$(GRLIB_SIMULATOR)","ModelSim-SE")
GRLIB_XIL_compxlib_Simulator=mti_se
endif
ifeq ("$(GRLIB_SIMULATOR)","ALDEC")
GRLIB_XIL_compxlib_Simulator=riviera
endif
ifeq ("$(GRLIB_SIMULATOR)","ALDEC_RWS")
GRLIB_XIL_compxlib_Simulator=riviera
endif
ifeq ("$(GRLIB_SIMULATOR)","Questa")
GRLIB_XIL_compxlib_Simulator=questasim
endif
endif

# Simulator vivado 
ifeq ("$(GRLIB_XIL_simlib_Simulator)","")
# Set default to ModelSim for GRLIB_XIL_simlib_Simulator
export GRLIB_XIL_simlib_Simulator=modelsim
ifeq ("$(GRLIB_SIMULATOR)","ModelSim")
export GRLIB_XIL_simlib_Simulator=modelsim
endif
ifeq ("$(GRLIB_SIMULATOR)","ModelSim-PE")
export GRLIB_XIL_simlib_Simulator=modelsim
endif
ifeq ("$(GRLIB_SIMULATOR)","ModelSim-SE")
export GRLIB_XIL_simlib_Simulator=modelsim
endif
ifeq ("$(GRLIB_SIMULATOR)","ALDEC")
export GRLIB_XIL_simlib_Simulator=riviera
endif
ifeq ("$(GRLIB_SIMULATOR)","ALDEC_RWS")
export GRLIB_XIL_simlib_Simulator=riviera
endif
ifeq ("$(GRLIB_SIMULATOR)","Questa")
export GRLIB_XIL_simlib_Simulator=questa
endif
endif

ifeq ("$(COMPXLIBTECH)","")
COMPXLIBTECH=$(ISETECH)
endif


# install-simprim, compile-simprim/xilinxcorelib/unisim/xilinx-simlibs are tailored for ModelSim/Questa
# (target dir is ./modelsim)
install-simprim:
	@echo "install-simprim is not supported. compile-simprim can be used to compile simprim for ModelSim"

compile-simprim:
	compxlib -s $(GRLIB_XIL_compxlib_Simulator) -l vhdl -arch $(COMPXLIBTECH) -lib simprim -w -dir ./modelsim

compile-xilinxcorelib:
	compxlib -s $(GRLIB_XIL_compxlib_Simulator) -l vhdl -arch $(COMPXLIBTECH) -lib xilinxcorelib -w -dir ./modelsim

compile-unisim:
	compxlib -s $(GRLIB_XIL_compxlib_Simulator) -l vhdl -arch $(COMPXLIBTECH) -lib unisim -w -dir ./modelsim

compile-xilinx-simlibs:
	compxlib -s $(GRLIB_XIL_compxlib_Simulator) -l vhdl -arch $(COMPXLIBTECH) -lib unisim -lib simprim -lib xilinxcorelib -w -dir ./modelsim

# Needs to depend on modelsim.ini so that the file is not overwritten by subsequent commands
# Selects family all since GRLIB techmap layer has Virtex-5-specific primitives (for example)
compile_xilinx_7series_lib: modelsim.ini
ifneq ("$(GRLIB_SIMULATOR)","Xilinx")
	-@mkdir -p ./xilinx_lib
	@if [ -d ./xilinx_lib/unisims_ver ]; then \
	echo "Xilinx library already compiled"; else \
	echo "compile_simlib -directory ./xilinx_lib/ -family all -language all -library all -simulator $(GRLIB_XIL_simlib_Simulator)" > ./xilinx_lib/$(TOP)_simlib.tcl ; \
	vivado -mode batch -source ./xilinx_lib/$(TOP)_simlib.tcl ; \
	fi;
endif

map_xilinx_7series_lib: compile_xilinx_7series_lib
ifneq ("$(GRLIB_SIMULATOR)","Xilinx")
ifneq ("$(GRLIB_SIMULATOR)","ALDEC_RWS")
	@if [ -d ./xilinx_lib/unisims_ver ]; then \
	vmap secureip_ver ./xilinx_lib/secureip ; \
	vmap secureip ./xilinx_lib/secureip ; \
	vmap axi_bfm ./xilinx_lib/secureip ; \
	vmap unisims_ver ./xilinx_lib/unisims_ver ; \
	vmap unisim ./xilinx_lib/unisim ; \
	vmap unimacro_ver ./xilinx_lib/unimacro_ver ; \
	vmap unimacro ./xilinx_lib/unimacro ; \
	vmap simprim_ver ./xilinx_lib/simprims_ver ; \
	vmap simprim ./xilinx_lib/simprims ; \
	vmap unifast_ver ./xilinx_lib/unifast_ver ; \
	vmap unifast ./xilinx_lib/unifast_ver ; else \
	echo "Xilinx Library not found. Please make sure you have installed the correct version of the Xilinx Library" ; exit 1 ; \
	fi;
else
	vsimsa -c -do $(GRLIB)/bin/aldec/riviera_ws_map_xilinx_libs.do
endif
else
	echo "GRLIB_SIMULATOR is Xilinx, skipping map of libraries"; exit 1
endif

clean-xilinx-lib:
	-rm -rf xilinx_lib compxlib.* .cxl.*.version

ip_7series_generate: vivado/$(TOP)_vivado.tcl $(VHDLSYNFILES) $(VERILOGSYNFILES) 
ifeq ($(CONFIG_MIG_7SERIES),y)
	@if [ -d ./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip ]; then \
	echo "Xilinx IPs already generated!"; else \
	vivado -mode batch -source ./vivado/$(TOP)_vivado.tcl ; \
	fi;
endif

mig_7series: ip_7series_generate compile_xilinx_7series_lib map_xilinx_7series_lib
ifneq ("$(GRLIB_SIMULATOR)","Xilinx")
ifeq ($(CONFIG_MIG_7SERIES),y)
ifneq ("$(GRLIB_SIMULATOR)","ALDEC_RWS")
	if [ -f ./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/mig.v ]; then \
	vlog -work gaisler \
	./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/mig.v \
	./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/mig_mig_sim.v \
	./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/clocking/*.v \
	./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/controller/*.v \
	./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/ecc/*.v \
	./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/ip_top/*.v \
	./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/phy/*.v \
	./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/ui/*.v ;\
	vlog -work work $(XILINX_VIVADO)/data/verilog/src/glbl.v ;\
	fi;
	if [ -f ./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/axi/*axi_mc.v ]; then \
	vlog -work gaisler ./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/axi/*.v ;\
	fi;
else
# The design.file.property command below is a hack so that the Verilog MIG IP, in (VHDL)
# library gaisler, will find components from unisim. Otherwise errors will be given during
# riviera elaboration. No documentation has been found about this. The command is intended
# to have the same effects as adding libs using:
# <right click> -> properties -> Enries -> Libraries
	@echo "workspace.open riviera_ws/riviera_ws.rwsp; workspace.design.setactive gaisler"  > riviera_ws_add_mig_7series.do
	@for f in ./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/mig.v \
		./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/mig_mig_sim.v \
		./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/clocking/*.v \
		./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/controller/*.v \
		./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/ecc/*.v \
		./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/ip_top/*.v \
		./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/phy/*.v \
		./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/mig/mig/user_design/rtl/ui/*.v ; do \
		echo "design.file.add .$$f" >> riviera_ws_add_mig_7series.do ; \
		echo "design.file.property " `basename $$f` "compilation/verilog/verilog-libraries \"secureip_ver;secureip;axi_bfm;unisims_ver;unisim;unimacro_ver;unimacro;simprim_ver;simprim;unifast_ver;unifast\"" >> riviera_ws_add_mig_7series.do; \
	done;
	@echo "workspace.design.setactive work; design.file.add $(XILINX_VIVADO)/data/verilog/src/glbl.v ; quit"  >> riviera_ws_add_mig_7series.do
	@vsimsa -quiet -do riviera_ws_add_mig_7series.do
endif
endif
endif

sgmii_7series: ip_7series_generate compile_xilinx_7series_lib map_xilinx_7series_lib
ifneq ("$(GRLIB_SIMULATOR)","Xilinx")
ifeq ($(CONFIG_GRETH_ENABLE),y)
ifneq ("$(GRLIB_SIMULATOR)","ALDEC_RWS")
	if [ -f./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/sgmii/synth/sgmii.v ]; then \
	vlib modelsim/gig_ethernet_pcs_pma ;\
	vmap -modelsimini ./modelsim.ini gig_ethernet_pcs_pma ./modelsim/gig_ethernet_pcs_pma ;\
	vcom -work gig_ethernet_pcs_pma ./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/sgmii/hdl/gig_ethernet_pcs_pma*.vhd  ;\
	vlog -work work \
	./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/sgmii/synth/*.v \
	./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/sgmii/synth/*/*.v ;\
	fi;
else
	@echo "workspace.open riviera_ws/riviera_ws.rwsp"  > riviera_ws_add_sgmii_7series.do
	@echo "workspace.design.create gig_ethernet_pcs_pma_v14_3 ."  >> riviera_ws_add_sgmii_7series.do
	@echo "workspace.design.setactive gig_ethernet_pcs_pma_v14_3"  >> riviera_ws_add_sgmii_7series.do
	@echo "amap secureip_ver ../xilinx_lib/secureip"  >> riviera_ws_add_sgmii_7series.do
	@echo "amap secureip ../xilinx_lib/secureip"  >> riviera_ws_add_sgmii_7series.do
	@echo "amap axi_bfm ../xilinx_lib/secureip"  >> riviera_ws_add_sgmii_7series.do
	@echo "amap unisims_ver ../xilinx_lib/unisims_ver"  >> riviera_ws_add_sgmii_7series.do
	@echo "amap unisim ../xilinx_lib/unisim"  >> riviera_ws_add_sgmii_7series.do
	@echo "amap unimacro_ver ../xilinx_lib/unimacro_ver"  >> riviera_ws_add_sgmii_7series.do
	@echo "amap unimacro ../xilinx_lib/unimacro"  >> riviera_ws_add_sgmii_7series.do
	@echo "amap simprim_ver ../xilinx_lib/simprims_ver"  >> riviera_ws_add_sgmii_7series.do
	@echo "amap simprim ../xilinx_lib/simprims"  >> riviera_ws_add_sgmii_7series.do
	@echo "amap unifast_ver ../xilinx_lib/unifast_ver"  >> riviera_ws_add_sgmii_7series.do
	@echo "amap unifast ../xilinx_lib/unifast_ver"  >> riviera_ws_add_sgmii_7series.do
	@echo "design.file.add ../vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/sgmii/gig_ethernet_pcs_pma_v14_3/hdl/gig_ethernet_pcs_pma_v14_3_rfs.vhd"  >> riviera_ws_add_sgmii_7series.do
	@echo "workspace.design.setactive work"  >> riviera_ws_add_sgmii_7series.do

	@for f in ./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/sgmii/synth/*.v \
		./vivado/$(DESIGN)/$(DESIGN).srcs/sources_1/ip/sgmii/synth/*/*.v ; do \
		echo "design.file.add .$$f" >> riviera_ws_add_mig_7series.do ; \
		echo "design.file.property " `basename $$f` "compilation/verilog/verilog-libraries \"secureip_ver;secureip;axi_bfm;unisims_ver;unisim;unimacro_ver;unimacro;simprim_ver;simprim;unifast_ver;unifast\"" >> riviera_ws_add_mig_7series.do; \
	done;
	@echo "quit"  >> riviera_ws_add_sgmii_7series.do
	@vsimsa -quiet -do riviera_ws_add_sgmii_7series.do
endif
endif
endif

.PHONY: compile_xilinx_7series_lib map_xilinx_7series_lib mig_7series_generate mig_7series install-simprim compile-simprim compile-xilinxcorelib compile-unisim compile-xilinx-simlibs

#########    Xilinx PlanAhead targets   ############

ifeq ("$(PLANAHEAD_SYNTH_FLOW)","")
PLANAHEAD_SYNTH_FLOW="XST 14"
endif
ifeq ("$(PLANAHEAD_SYNTH_STRATEGY)","")
PLANAHEAD_SYNTH_STRATEGY="TimingWithIOBPacking"
#PLANAHEAD_SYNTH_STRATEGY="XST Defaults"
endif
ifeq ("$(PLANAHEAD_IMPL_STRATEGY)","")
PLANAHEAD_IMPL_STRATEGY="ParHighEffort"
endif

## Xilinx planAhead project properties that can be overrideen
ifeq ("$(GRLIB_XIL_PlanAhead_Simulator)","")
ifeq ("$(GRLIB_SIMULATOR)","ModelSim")
GRLIB_XIL_PlanAhead_Simulator=ModelSim
else
GRLIB_XIL_PlanAhead_Simulator=ISim
endif
endif

#PLANAHEAD_SIMSET=sim_$(DESIGN)
PLANAHEAD_SIMSET=sim_1

planahead-launch: planahead/$(TOP)_planAhead.tcl $(VHDLSYNFILES) $(VERILOGSYNFILES)
	planAhead -mode gui -source ./planahead/$(TOP)_planAhead.tcl
	@if test -r ./planahead/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).bit; then \
	  cp ./planahead/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).bit . ; \
	  cp ./planahead/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).msk . ; \
	fi;

planahead: planahead/$(TOP)_planAhead.tcl $(VHDLSYNFILES) $(VERILOGSYNFILES)
	planAhead -mode batch -source ./planahead/$(TOP)_planAhead.tcl ./planahead/$(TOP)_planAhead_run.tcl ./planahead/$(TOP)_planAhead_end.tcl
	@if test -r ./planahead/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).bit; then \
	  cp ./planahead/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).bit . ; \
	  cp ./planahead/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).msk . ; \
	fi;

planahead-clean:
	-rm -rf ./planahead planAhead.log planAhead*.jou planAhead*.*.log

#########    Xilinx Vivado targets   ############

VIVADOVHDL = read_vhdl -library
VIVADOVLOG = read_verilog -library

VIVADOLIBSKIPX = $(ASICLIBS) $(BRMLIBS) $(ACTELLIBS) $(ALTERALIBS) \
	$(LATTICELIBS) $(COREPCILIB) $(SIMLIBS)
VIVADOLIBSKIP = $(VIVADOLIBSKIPX:%=%|) dware | grdware
VIVADODIRSKIPX = $(ASICLIBS) $(ACTELLIBS) $(ALTERALIBS) $(LATTICELIBS)
VIVADODIRSKIP = $(VIVADODIRSKIPX:%=%|) dware | grdware
VIVADOSKIP = $(VIVADOSKIPX) b1553* | pci_components* | pcicore* | snpsmul.vhd | clkgen_virtex.vhd | \
	memory_virtex.vhd | simple_simprim.vhd | unisim_VCOMP.vhd | unisim_VITAL.vhd | unisim_VPKG.vhd

ifeq ("$(VIVADO_SYNTH_FLOW)","")
VIVADO_SYNTH_FLOW=Vivado Synthesis 2012
endif
ifeq ("$(VIVADO_SYNTH_STRATEGY)","")
VIVADO_SYNTH_STRATEGY=Vivado Synthesis Defaults
endif
ifeq ("$(VIVADO_IMPL_STRATEGY)","")
VIVADO_IMPL_STRATEGY=Vivado Implementation Defaults
endif

## Xilinx Vivado project properties that can be overrideen
ifeq ("$(GRLIB_XIL_Vivado_Simulator)","")
GRLIB_XIL_Vivado_Simulator=XSim
ifeq ("$(GRLIB_SIMULATOR)","ModelSim")
GRLIB_XIL_Vivado_Simulator=ModelSim
endif
ifeq ("$(GRLIB_SIMULATOR)","ModelSim-PE")
GRLIB_XIL_Vivado_Simulator=ModelSim
endif
ifeq ("$(GRLIB_SIMULATOR)","ModelSim-SE")
GRLIB_XIL_Vivado_Simulator=ModelSim
endif
ifeq ("$(GRLIB_SIMULATOR)","Questa")
GRLIB_XIL_Vivado_Simulator=Questa
endif
ifeq ("$(GRLIB_SIMULATOR)","ALDEC")
GRLIB_XIL_Vivado_Simulator=Riviera
endif
ifeq ("$(GRLIB_SIMULATOR)","ALDEC_RWS")
GRLIB_XIL_Vivado_Simulator=Riviera
endif
endif

#VIVADO_SIMSET=sim_$(DESIGN)
VIVADO_SIMSET=sim_1

vivado-launch: vivado/$(TOP)_vivado.tcl $(VHDLSYNFILES) $(VERILOGSYNFILES)
	vivado -mode gui -source ./vivado/$(TOP)_vivado.tcl
	@if test -r ./vivado/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).bit; then \
	  cp ./vivado/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).bit . ; \
	  cp ./vivado/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).msk . ; \
	fi;

vivado: vivado/$(TOP)_vivado.tcl $(VHDLSYNFILES) $(VERILOGSYNFILES)
	vivado -mode batch -source ./vivado/$(TOP)_vivado.tcl ./vivado/$(TOP)_vivado_run.tcl | tee $(TOP)_vivado.log
	@if test -r ./vivado/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).bit; then \
	  cp ./vivado/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).bit . ; \
	  cp ./vivado/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).msk . ; \
	fi;

vivado-clean:
	-rm -rf ./vivado *vivado.log vivado*.jou vivado*.backup.log vivado*.str .Xil .cxl.*.version compile_simlib.log compile_simlib.log.bak xmd.ini

vivado-prog-fpga:
	@echo "fpga -f ./vivado/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).bit" > ./xmd.ini
	@echo "exit" >> ./xmd.ini
	xmd

vivado-prog-fpga-ref:
	@echo "fpga -f ./bitfiles/$(TOP).bit" > ./xmd.ini
	@echo "exit" >> ./xmd.ini
	xmd

#########   Altera targets   ############

install-altera:
ifeq ("$(QUARTUS_ROOTDIR)","")
	@echo "QUARTUS_ROOTDIR is not set. Altera library installation failed"
else
	@if test -r $(QUARTUS_ROOTDIR)/eda/sim_lib/altera_primitives.vhd; then \
	  echo installing tech/altera ;\
	  cp $(QUARTUS_ROOTDIR)/eda/sim_lib/altera_primitives*.vhd  $(GRLIB)/lib/tech/altera/simprims ;\
	else echo skipping tech/altera; fi ; \
	if test -r $(QUARTUS_ROOTDIR)/eda/sim_lib/altera_mf_components.vhd; then \
	  echo installing tech/altera_mf ;\
	  cp $(QUARTUS_ROOTDIR)/eda/sim_lib/altera_mf*.vhd  $(GRLIB)/lib/tech/altera_mf/simprims ;\
	  cat $(GRLIB)/bin/altera/altera_mf.vhd >> $(GRLIB)/lib/tech/altera_mf/simprims/altera_mf.vhd ;\
	else echo skipping tech/altera_mf; fi ; \
	if test -r $(QUARTUS_ROOTDIR)/eda/sim_lib/cycloneiii_atoms.vhd; then \
	  echo installing tech/cycloneiii ;\
	  cp $(QUARTUS_ROOTDIR)/eda/sim_lib/cycloneiii_*.vhd  $(GRLIB)/lib/tech/cycloneiii/simprims ;\
	else echo skipping tech/cycloneiii - not supported by Quartus II version; fi ; \
	if test -r $(QUARTUS_ROOTDIR)/eda/sim_lib/stratixii_atoms.vhd; then \
	  echo installing tech/stratixii ;\
	  cp $(QUARTUS_ROOTDIR)/eda/sim_lib/stratixii_*.vhd  $(GRLIB)/lib/tech/stratixii/simprims ;\
	else echo skipping tech/stratixii - not supported by Quartus II version; fi ; \
	if test -r $(QUARTUS_ROOTDIR)/eda/sim_lib/stratixiii_atoms.vhd; then \
	  echo installing tech/stratixii ;\
	  cp $(QUARTUS_ROOTDIR)/eda/sim_lib/stratixiii_*.vhd  $(GRLIB)/lib/tech/stratixiii/simprims ;\
	else echo skipping tech/stratixiii - not supported by Quartus II version; fi ; \
	echo Altera library installation completed.
endif

remove-altera:
	-@rm $(GRLIB)/lib/tech/altera/simprims/altera_primitives*.vhd \
	$(GRLIB)/lib/tech/altera_mf/simprims/altera_mf*.vhd \
	$(GRLIB)/lib/tech/cycloneiii/simprims/cycloneiii_*.vhd \
	$(GRLIB)/lib/tech/stratixii/simprims/stratixii_*.vhd \
	$(GRLIB)/lib/tech/stratixiii/simprims/stratixiii_*.vhd
	@echo Altera libraries removed from GRLIB

#########   Altera Quartus targets   ############

#ifeq ("$(QUARTUS_ROOTDIR)","")
QUARTUS_CDB = quartus_cdb $(QUARTUSOPT)
QUARTUS_MAP = quartus_map $(QUARTUSOPT)
QUARTUS_FIT = quartus_fit $(QUARTUSOPT)
QUARTUS_ASM = quartus_asm $(QUARTUSOPT)
QUARTUS_STA = quartus_sta $(QUARTUSOPT)
QUARTUS_PGM = quartus_pgm $(QUARTUSOPT)
QUARTUS_SH = quartus_sh $(QUARTUSOPT)
#else
#QUARTUS_MAP = $(QUARTUS_ROOTDIR)/bin/quartus_map
#QUARTUS_FIT = $(QUARTUS_ROOTDIR)/bin/quartus_fit
#QUARTUS_ASM = $(QUARTUS_ROOTDIR)/bin/quartus_asm
#QUARTUS_STA = $(QUARTUS_ROOTDIR)/bin/quartus_tan
#endif
ALTCABLE ?= USB-Blaster
QLIBSKIPX = $(SIMLIBS) $(ASICLIBS) $(BRMLIBS) $(ACTELLIBS) $(XILINXLIBS) \
	$(LATTICELIBS) $(COREPCILIB)
QUARTUSLIBSKIP = $(QLIBSKIPX:%=%|) dware
QDIRSKIPX = $(ASICLIBS) $(ACTELLIBS) $(XILINXLIBS) $(LATTICELIBS)
QDIRSKIP = $(QDIRSKIPX:%=%|) dware | satcan | leon2ft
QUARTUSSKIP = b1553* | pci_components* | pcicore* | snpsmul.vhd

quartus-vqm:
	-@case $(TECHNOLOGY) in \
	CYCLONEII) \
		cp  $(GRLIB)/netlists/altera/cyclone2/*.vqm . ;;\
	CYCLONEIII) \
		cp  $(GRLIB)/netlists/altera/cyclone3/*.vqm . ;;\
	CYCLONEIV) \
		cp  $(GRLIB)/netlists/altera/cyclone3/*.vqm . ;;\
	CYCLONEIV-E) \
		cp  $(GRLIB)/netlists/altera/cyclone3/*.vqm . ;;\
	CYCLONEV) \
		cp  $(GRLIB)/netlists/altera/cyclone5/*.vqm . ;;\
	STRATIXV) \
		cp  $(GRLIB)/netlists/altera/stratix5/*.vqm . ;;\
	STRATIXIV) \
		cp  $(GRLIB)/netlists/altera/stratix4/*.vqm . ;;\
	STRATIXIII) \
		cp  $(GRLIB)/netlists/altera/stratix3/*.vqm . ;;\
	STRATIXII) \
		cp  $(GRLIB)/netlists/altera/stratix2/*.vqm . ;;\
	esac

quartus: quartus-vqm
	make quartus-map quartus-route

quartus-synp:  $(TOP)_synplify.prj synplify/$(TOP).edf quartus-vqm
	@-cp synplify/*.hex .
	$(QUARTUS_MAP) --import_settings_files=on  --export_settings_files=off $(TOP)_synplify -c $(TOP)_synplify
	    $(if $(strip $(QSF_NEXT)),$(QUARTUS_SH) -t $(QSF_NEXT) quartus_map $(TOP)_synplify $(TOP)_synplify,)
	$(QUARTUS_CDB) --merge $(TOP)_synplify
	$(QUARTUS_FIT) --import_settings_files=off --export_settings_files=off $(TOP)_synplify -c $(TOP)_synplify
	    $(if $(strip $(QSF_NEXT)),$(QUARTUS_SH) -t $(QSF_NEXT) quartus_fit $(TOP)_synplify $(TOP)_synplify,)
	$(QUARTUS_ASM) --import_settings_files=off --export_settings_files=off $(TOP)_synplify -c $(TOP)_synplify
	    $(if $(strip $(QSF_NEXT)),$(QUARTUS_SH) -t $(QSF_NEXT) quartus_asm $(TOP)_synplify $(TOP)_synplify,)
	$(QUARTUS_STA) $(TOP)_synplify

quartus-launch: $(TOP)_quartus.qsf quartus-vqm
	quartus  $(TOP)_quartus.qpf

quartus-launch-synp:  $(TOP)_synplify.prj synplify/$(TOP).edf quartus-vqm
	quartus $(TOP)_synplify.qpf

quartus-map: $(TOP)_quartus.qsf quartus-vqm
	$(QUARTUS_MAP) --import_settings_files=on  --export_settings_files=off $(TOP)_quartus -c $(TOP)_quartus
	    $(if $(strip $(QSF_NEXT)),$(QUARTUS_SH) -t $(QSF_NEXT) quartus_map     $(TOP)_quartus $(TOP)_quartus,)

quartus-route: $(TOP)_quartus.qsf
	$(QUARTUS_CDB) --merge $(TOP)_quartus
	$(QUARTUS_FIT) --import_settings_files=off --export_settings_files=off $(TOP)_quartus -c $(TOP)_quartus
	    $(if $(strip $(QSF_NEXT)),$(QUARTUS_SH) -t $(QSF_NEXT) quartus_fit $(TOP)_quartus $(TOP)_quartus,)
	$(QUARTUS_ASM) --import_settings_files=off --export_settings_files=off $(TOP)_quartus -c $(TOP)_quartus
	    $(if $(strip $(QSF_NEXT)),$(QUARTUS_SH) -t $(QSF_NEXT) quartus_asm $(TOP)_quartus $(TOP)_quartus,)
	$(QUARTUS_STA) $(TOP)_quartus

quartus-prog-fpga:
	$(QUARTUS_PGM) -c $(ALTCABLE) -m JTAG -o p\;$(TOP)_quartus.sof

quartus-prog-fpga-ref:
	cp bitfiles/$(TOP).sof $(TOP)_ref.sof
	$(QUARTUS_PGM) -c $(ALTCABLE) -m JTAG -o p\;$(TOP)_ref.sof

quartus-srec:
	$(QUARTUS_PGM)

quartus-clean:
	-rm -rf db *.syr *.qws automake.log dumpdata.txt \
	*.rpt *.done *.eqn *.pof *.summary *.ttf *.pin *.sof \
	*.jam *.jbc cmp_state.ini simulation undo_redo.txt *.vqm *.qdf \
	*.csf *.psf *.quartus *.smsg .undefinedlib .jaguarc .unorderedFilePath \
	incremental_db PLLJ_PLLSPE_INFO.txt *.jdi $(TOP)_quartus.sld

########   Synplify targets   ########################

SYNPVHDL = add_file -vhdl -lib
SYNPVLOG = add_file -verilog
SYNPLIBSKIP = $(ASICLIBS)
XSYNPLIBSKIP = $(SYNPLIBSKIP:%=%|) dummy
XSYNPDIRSKIP = $(SYNPLIBSKIP:%=%|) dummy

SYNPSKIP = snpsmul.vhd

SYNPLIFY = synplify_pro


synplify synplify-map: $(TOP)_synplify.prj synplify/$(TOP).edf

synplify-launch: $(TOP)_synplify.prj
	$(SYNPLIFY) $(TOP)_synplify.prj && \
	if test -r synplify//$(TOP).edn; then \
	  echo "GRLIB: Detected synplify/$(TOP).edn, copying to synplify/$(TOP).edf"; \
	  cp synplify/$(TOP).edn synplify/$(TOP).edf; \
	fi &
	-@mkdir synplify>& tmp.err; touch synplify/dummy.mif
	-@mv synplify/*.mif .

synplify/$(TOP).edf: $(VHDLSYNFILES) $(VERILOGSYNFILES)
	$(SYNPLIFY) -batch $(TOP)_synplify.prj
	@touch synplify/dummy.mif
	-@mv synplify/*.mif .
	@if test -r synplify/$(TOP).edn; then \
	  echo "GRLIB: Detected synplify/$(TOP).edn, copying to synplify/$(TOP).edf"; \
	  cp synplify/$(TOP).edn synplify/$(TOP).edf; \
	fi;

$(TOP)_synplify.prj: compile.synp
	@echo source compile.synp > $(TOP)_synplify.prj
	@for i in $(VERILOGOPTSYNFILES) $(VERILOGSYNFILES); do \
	    if test -r $$i; then \
		echo add_file "-verilog -lib work" $$i >> $(TOP)_synplify.prj; \
	    fi; \
	done
	@for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES); do \
	    if test -r $$i; then \
		echo add_file "-vhdl -lib work" $$i >> $(TOP)_synplify.prj; \
	    fi; \
	done
	@if test -r $(GRLIB)/netlists/xilinx/$(NETLISTTECH)/edifsyn.txt; then \
	  for q in `cat $(GRLIB)/netlists/xilinx/$(NETLISTTECH)/edifsyn.txt`; do \
	    if test -r $(GRLIB)/netlists/xilinx/$(NETLISTTECH)/$$q; then \
	      echo add_file -edif $(GRLIB)/netlists/xilinx/$(NETLISTTECH)/$$q >> $(TOP)_synplify.prj ; \
	    fi; \
	  done; \
	fi
	@for i in $(SDCFILE); do echo add_file "-constraint " $$i >> $(TOP)_synplify.prj; done
	@for i in $(FDCFILE); do echo add_file "-fpga_constraint " $$i >> $(TOP)_synplify.prj; done
	@cat $(GRLIB)/bin/synplify.prj | sed -e s/TOP/$(TOP)/ \
	-e s/TECHNOLOGY/$(TECHNOLOGY)/ \
	-e s/PART/$(PART)/ -e s/SPEED/$(SPEED)/ -e s/SYNFREQ/$(SYNFREQ)/ >> $(TOP)_synplify.prj
ifneq ("$(PACKAGE)","")
	@echo set_option -package $(PACKAGE) >> $(TOP)_synplify.prj
endif
ifneq ("$(SYNPVLOGDEFS)","")
	@echo set_option -hdl_define -set \"$(SYNPVLOGDEFS)\" >> $(TOP)_synplify.prj
endif
ifneq ("$(SYNPVLOGINC)","")
	@echo set_option -include_path \"$(SYNPVLOGINC)\" >> $(TOP)_synplify.prj
endif
ifneq ("$(SYNPVLOGSTD)","")
	@echo set_option -vlog_std \"$(SYNPVLOGSTD)\" >> $(TOP)_synplify.prj
endif
	@echo $(SYNPOPT) >> $(TOP)_synplify.prj
	@echo impl -active \"synplify\" >> $(TOP)_synplify.prj

synplify-clean:
	-rm -rf synplify *.prd stdout.log *.mif syntmp.* synplify_* \
	$(TOP).map $(TOP)_summary.xml synlog.tcl

########   Precision targets   ########################

PRECLIBSKIPX = $(SIMLIBS) $(ASICLIBS)
PRECLIBSKIP =  $(PRECLIBSKIPX:%=%|) dware
PRECDIRSKIP =  $(PRECLIBSKIPX:%=%|) dware
PRECSKIP = dummy


PRECISION=precision

precision precision-map: $(TOP)_precision.tcl $(TOP).psp precision/$(TOP).edf

$(TOP).psp: $(TOP)_precision.tcl
	$(PRECISION) -shell $(PRECISIONOPT) -file $(TOP)_precision.tcl

precision-launch: $(TOP).psp
	$(PRECISION) $(PRECISIONOPT) -project $(TOP).psp

precision/$(TOP).edf: $(TOP)_precision.tcl  $(VHDLSYNFILES) $(VERILOGSYNFILES)
	$(PRECISION) -shell $(PRECISIONOPT) -file $(TOP)_precrun.tcl

precision-clean:
	-rm -rf *.psp stdout.log prec.log  $(TOP)_prec* precision* $(TOP)_temp*

######### DARE targets ###############

ifneq ("$(GRLIB)","")
-include $(GRLIB)/bin/Makefile.dare
endif

remove-dare:
	-@rm -r $(GRLIB)/lib/tech/dare/components/*.v
	@echo "" > $(GRLIB)/lib/tech/dare/components/vlogsim.txt

######### Microsemi targets ###############
PROASIC3LIBS = proasic3 proasic3e proasic3l
XLIBEROLIBSKIP = $(ASICLIBS) $(LATTICELIBS) \
	$(ALTERALIBS) $(XILINXLIBS) $(PROASIC3LIBS) fusion smartfusion2 axcelerator rtg4
LIBEROLIBSKIP = $(XLIBEROLIBSKIP:%=%|) dummy
LIBERODIRSKIPX = $(ASICLIBS) $(XILINXLIBS) $(ALTERALIBS) $(LATTICELIBS)
LIBERODIRSKIP = $(LIBERODIRSKIPX:%=%|) dummy
LIBEROSKIP = dummy

ifeq ("$(TECHNOLOGY)","RTG4")
LIBEROPRECOMPLIBDIR=rtg4
else
LIBEROPRECOMPLIBDIR=smartfusion2
endif

LIBERO = libero

# DESIGNER_LAYOUT_OPT can be overridden i template design Makefile
ifeq ("$(DESIGNER_LAYOUT_OPT)","")
ifeq ("$(TECHNOLOGY)","Axcelerator")
DESIGNER_LAYOUT_OPT=-effort_level 5 -timing_driven -incremental \"OFF\"
else
DESIGNER_LAYOUT_OPT=-timing_driven -incremental \"OFF\"
endif
endif

ifeq ("$(DESIGNER_TECHNOLOGY)","")
DESIGNER_TECHNOLOGY=$(TECHNOLOGY)
endif

ifeq ("$(DESIGNER_PART)","")
DESIGNER_PART=$(PART)
endif



ifneq ("$(GRLIB)","")
-include $(GRLIB)/bin/Makefile.microsemi
endif

actel-clean:
	-rm -rf *.adb report*.log ./actel hdl constraint \
	actgen constraint designer package phy_synthesis simulation \
	smartgen stimulus synthesis viewdraw libero x $(TOP)_libero.prj \
	libero_sim_files libero_syn_files coreconsole \
	libero.do component *.pdb *.pdb.depends *.stp \
	*.sdb *_layout.log *.dtf from.ufc from.mem  \
	 $(TOP)_libero.prjx tooldata $(TOP)_libero.tcl $(TOP)_libero/

remove-microsemi: remove-microsemi-precomp
	-@for i in fusion proasic3 proasic3e proasic3l axcelerator smartfusion2 rtg4; do \
	  rm $(GRLIB)/lib/tech/$$i/components/$$i.v* ;  \
	done

remove-microsemi-precomp:
	-@rm -r $(GRLIB)/lib/tech/smartfusion2/precomp_libraries/smartfusion2
	-@rm -r $(GRLIB)/lib/tech/rtg4/precomp_libraries/rtg4

############  Synopsys              ########################

install-gtech:
	@echo GTECH source path: $(SNPS_HOME)/packages/gtech/src; \
	if test -r $(SNPS_HOME)/packages/gtech/src; then \
	  cp $(SNPS_HOME)/packages/gtech/src/*.vhd $(GRLIB)/lib/tech/gtech/simprims; \
        fi

remove-gtech:
	@-rm $(GRLIB)/lib/tech/gtech/simprims/*.vhd


############  Synopsys DC targets   ########################

DCVHDL = analyze -f VHDL -library
DCVLOG = analyze -f VERILOG -library
FMVHDL = read_vhdl -r -libname
FMVLOG = read_verilog -r -libname
ifeq ("$(DCSCRIPT)","")
DCSCRIPT=$(TOP)_dc.tcl
endif
ifeq ("$(FMSCRIPT)","")
FMSCRIPT=$(TOP)_fm.tcl
endif
DCLIBSKIP = $(FPGALIBS) corePCIF
DCDIRSKIP =  $(FPGALIBS) corePCIF pci/pcif
#DCDIRSKIP =  corePCIF pcif
XDCLIBSKIP = $(DCLIBSKIP:%=% | ) dummy
XDCDIRSKIP = $(DCDIRSKIP:%=% | ) dummy
DCSKIP = $(DCLIBSKIP:%=*_%.vhd | ) dummy

dc-launch: $(TOP)_dc.tcl
	@-mkdir -p synopsys
	design_compiler&

dc: $(TOP)_dc.tcl
	@-mkdir -p synopsys
	dc_shell-xg-t $(DCOPT) -f $(DCSCRIPT) | tee $(DCSCRIPT).log

fm: $(TOP)_dc.tcl
	@-mkdir -p synopsys
	fm_shell $(FMOPT) -f $(FMSCRIPT) | tee $(FMSCRIPT).log

$(TOP)_dc.tcl: compile.dc
	@cp $(GRLIB)/bin/top.dc $(TOP)_dc.tcl
	@for i in $(VERILOGOPTSYNFILES) $(VERILOGSYNFILES); do \
	 if test -r $$i; then \
	    echo $(DCVLOG) work $$i >> $(TOP)_dc.tcl; \
	    echo $(FMVLOG) work $$i >> fmref.tcl; \
	 fi; \
	done
	@for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES); do \
	 if test -r $$i; then \
	    echo $(DCVHDL) work $$i >> $(TOP)_dc.tcl; \
	    echo $(FMVHDL) work $$i >> fmref.tcl; \
	 fi; \
	done
	@echo elaborate $(TOP) >> $(TOP)_dc.tcl

dc-clean:
	-rm -rf synopsys view_command.log command.log dumpdata.txt filenames.log \
	dc.log dwsvf* alib* $(TOP)_dc.tcl fmref.tcl fm_shell_command.log \
	formality*.log *.svf $(DCSCRIPT).log $(DCSCRIPT).log.swp FM_WORK $(FMSCRIPT).log formality_svf *.mr *.pvl \
	ARCH ENTI PACK *.log.swp

############  Cadence RTL Compiler   ########################

RTLCVHDL = read_hdl -vhdl -lib
RTLCVLOG = read_hdl
RCSCRIPT=$(TOP).rc

NCVHDL = ncvhdl -nowarn DLCPTH -NOVITALCHECK -linedebug -v93 -nocopyright -work
NCVLOG = ncvlog -nowarn DLCPTH -nocopyright -linedebug $(NCVLOGOPT) -work

rc: $(TOP).rc
	-mkdir rtlc
	rc -files $(RCSCRIPT)

$(TOP).rc: compile.rc
	@cp $(GRLIB)/bin/top.rc $(TOP).rc
	@for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES); do \
	 if test -r $$i; then \
	    echo "read_hdl -vhdl -lib work" $$i >> $(TOP).rc; \
	 fi; \
	done
#	@for i in $(VERILOGOPTSYNFILES) $(VERILOGSYNFILES); do echo "read_hdl " $$i >> $(TOP).rc; done
	@echo elaborate $(TOP) >> $(TOP).rc

rc-clean:
	-rm -rf rtlc rc.log rc.cmd

#########    Generic simulation target ###############

ifeq ("$(GRLIB_SIMULATOR)", "ALDEC")
SIM=riviera
else
SIM=vsim
endif

sim:
	make $(SIM)

sim-run:
	make $(SIM)-run

sim-launch:
	make $(SIM)-launch


########## Generation of compile scripts ###############
prereqtools:= $(shell (export GRLIB=$(GRLIB) TOP=$(TOP) && tclsh $(GRLIB)/bin/scriptgen/dependencies.tcl))

targettools:= $(shell (export GRLIB=$(GRLIB) TOP=$(TOP) && tclsh $(GRLIB)/bin/scriptgen/targets.tcl))

empty:=
s:= $(empty) $(empty)
u:= |

scripts: $(prereqtools) 

$(targettools): scriptgendone

VARIABLE_LIST := $(shell cat $(GRLIB)/bin/scriptgen/scriptgen_variables.txt)

scriptgen_variable_values.tcl:
	@rm -f scriptgen_variable_values.tcl
	@touch scriptgen_variable_values.tcl
	@$(foreach v,$(VARIABLE_LIST), echo set $(v) {$(subst $(u),$(s),$($(v)))} >> scriptgen_variable_values.tcl ;)

scriptgendone: scriptgen_variable_values.tcl
	@printf "$(shell export GRLIB=$(GRLIB) OS=$(OS) && tclsh $(GRLIB)/bin/scriptgen/main.tcl)"



######## Common cleaning   ####################

clean: $(CLEAN) vsim-clean ise-clean ncsim-clean ghdl-clean synplify-clean quartus-clean \
	actel-clean dc-clean rc-clean isp-clean precision-clean vsimsa-clean avhdl-clean \
	vivado-clean planahead-clean riviera-clean fpro-clean vcs-clean
	-rm -rf verilog.txt tkparse.exe main.tk ahbrom outdata ahbrom.bin

scripts-clean:
	-rm -rf compile\.* libs.txt $(TOP)_quartus.qsf $(TOP)_synplify.qsf *.qpf ghdl.path \
	compile\.* libs.do make\.* *.xst $(TOP)*_files.prj cds.lib *.npl $(TOP)_ise.tcl \
	.config.old hdl.var $(TOP)_dc.tcl  $(TOP).rc  \
	$(TOP)_synplify.prj $(SIMTOP).mpf \
	$(TOP)_designer.tcl $(TOP)_designer_act.tcl \
	modelsim.ini modelsim.ini.bak \
	alibs.do avhdl.tcl riviera_ws_create.do $(EXTRACLEAN) \
	make.ghdl simulation vivado scriptgendone scriptgen_variable_values.tcl

scriptgen-clean:
	-rm -rf scriptgenwork

distclean: $(CLEAN) clean scripts-clean clean-xilinx-lib scriptgen-clean

libclean: remove-altera remove-unisim remove-microsemi remove-dare

none-clean:

######## xconfig targets   ####################

ifneq ($(CURLIB), $(GRLIB))
  include $(GRLIB)/bin/Makefile.config
endif

TKCONFIG= $(GRLIB)/bin/tkconfig

tkparse.o: $(TKCONFIG)/tkparse.c
	$(CC) -g -c $<

tkcond.o: $(TKCONFIG)/tkcond.c
	$(CC) -g -c $<

tkgen.o: $(TKCONFIG)/tkgen.c
	$(CC) -g -c $<


tkparse.exe: tkparse.o tkcond.o tkgen.o
	$(CC) -g tkparse.o tkcond.o tkgen.o -o tkparse.exe

lconfig.tk: config.in $(CONFDEP) $(HELPDEP)
	make main.tk
	cat $(TKCONFIG)/header.tk main.tk $(TKCONFIG)/tail.tk > lconfig.tk
	chmod a+x lconfig.tk

main.tk : config.in tkparse.exe $(CONFDEP) $(HELPDEP)
	./tkparse.exe config.in $(GRLIB) $(EXTRALIBS) > main.tk

$(GRLIB)/bin/Makefile.config:
	make -C $(GRLIB) -f bin/Makefile cfgdep

xconfig: lconfig.tk $(GRLIB)/bin/Makefile.config
	@if test -r "/usr/bin/wish84.exe"; then /usr/bin/wish84.exe -f lconfig.tk; \
	else \
	  if test -r "/mingw/bin/wish84.exe"; then \
	    if !(test -r "/mingw/bin/echo.bat"); then \
	      cp $(GRLIB)/bin/echo.bat /mingw/bin/echo.bat; \
	    fi; \
	    if !(test -r "/mingw/bin/wish"); then \
	      cp $(GRLIB)/bin/wish /mingw/bin/wish; \
	    fi; \
	  fi; \
	  unset LD_LIBRARY_PATH ; \
	  wish -f lconfig.tk; \
	fi; \
	if test $$? = "2" ; then                   \
	   cpp -P -DGRLIB_PATH=$(GRLIB) config.vhd.in > config.vhd; \
	   echo config.vhd created; \
	fi

xdep:
	cpp -P -DGRLIB_PATH=$(GRLIB) config.vhd.in > config.vhd

boardconfig:
	cp $(GRLIB)/boards/$(BOARD)/config .config
	cp $(GRLIB)/boards/$(BOARD)/config.h config.h
	make xdep

oldconfig: lconfig.tk $(GRLIB)/bin/Makefile.config
	@if test -r "/usr/bin/wish84.exe"; then /usr/bin/wish84.exe -f lconfig.tk -regen; \
	else \
	  if test -r "/mingw/bin/wish84.exe"; then \
	    if !(test -r "/mingw/bin/echo.bat"); then \
	      cp $(GRLIB)/bin/echo.bat /mingw/bin/echo.bat; \
	    fi; \
	    if !(test -r "/mingw/bin/wish"); then \
	      cp $(GRLIB)/bin/wish /mingw/bin/wish; \
	    fi; \
	  fi; \
	  unset LD_LIBRARY_PATH ; \
	  wish -f lconfig.tk -regen; \
	fi; \
	if test $$? = "2" ; then                   \
	   cpp -P -DGRLIB_PATH=$(GRLIB) config.vhd.in > config.vhd; \
	   echo config.vhd recreated from .config; \
	fi

.PHONY: xst precision synplify scripts bitfiles planahead planahead-launch vivado vivado-launch



############ Maintenance - do not remove!   ##################

cfgdep:
	@printf "CONFDEP = "  > bin/Makefile.config
	@for i in `find lib -name '*.in' -print | grep -v vhd | xargs`; do \
	  echo -n '$$(GRLIB)'/$$i >> bin/Makefile.config ; \
	  printf " \\"  >> bin/Makefile.config ; \
	  printf "\n"  >> bin/Makefile.config ; \
	done;
	@printf "  \n" >> bin/Makefile.config
	@printf "HELPDEP = "  >> bin/Makefile.config
	@for i in `find lib -name '*.in.help' -print | xargs`; do \
	  echo -n '$$(GRLIB)'/$$i >> bin/Makefile.config ; \
	  printf " \\"  >> bin/Makefile.config ; \
	  printf "\n"  >> bin/Makefile.config ; \
	done;
	@printf "  \n" >> bin/Makefile.config


ifneq ("$(GRLIB)","")
-include $(GRLIB)/bin/Makefile.dist
-include $(GRLIB)/bin/Makefile.test
endif
