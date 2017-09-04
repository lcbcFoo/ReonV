GRLIB=../..
TOP=leon3mp
BOARD=altera-c5ekit
ALTCABLE=USB-BlasterII
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=std
XSTOPT=
SYNPOPT="set_option -pipe 0; set_option -retiming 0; set_option -write_apr_constraint 0"
VHDLSYNFILES=config.vhd ahbrom.vhd clkgen_c5ekit.vhd lpddr2if.vhd ddr3if.vhd leon3mp.vhd
VHDLSIMFILES=memifsim.vhd pllsim.vhd testbench.vhd
SIMTOP=testbench
SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean
LDFLAGS=-qnoambapp

QSF_APPEND=qsf_append.txt
QSF_NEXT=quartus_hook.tcl

TECHLIBS = altera altera_mf
LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp hynix cypress
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan pci leon3ft ambatest can \
	usbhc usb spacewire spi grusbhc \
	slink ascs hcan leon4v0
FILESKIP = grcan.vhd clkgen_altera_mf.vhd

CLEAN=localclean

include $(GRLIB)/software/leon3/Makefile
include $(GRLIB)/bin/Makefile


##################  project specific targets ##########################


qwiz:
	@cp $(GRLIB)/boards/$(BOARD)/syspll1.vhd .
	@if [ ! -d ./syspll1/ ]; then \
		qmegawiz -silent syspll1.vhd ; \
	else \
		echo "syspll1 core already compiled"; \
	fi ;
	@cp $(GRLIB)/boards/$(BOARD)/lpddr2ctrl1.vhd .
	@if [ ! -d ./lpddr2ctrl1/ ]; then \
		qmegawiz -silent lpddr2ctrl1.vhd ; \
	else \
		echo "lpddr2ctrl1 core already compiled"; \
	fi ;
	@cp $(GRLIB)/boards/$(BOARD)/ddr3ctrl1.vhd .
	@if [ ! -d ./ddr3ctrl1/ ]; then \
		qmegawiz -silent ddr3ctrl1.vhd ; \
	else \
		echo "ddr3ctrl1 core already compiled"; \
	fi ;

localclean:
	@rm -rf syspll1 syspll1_sim syspll1.[bcpqsv]* syspll1_sim.f hc_output libraries
	@rm -rf lpddr2ctrl1 lpddr2ctrl1_sim lpddr2ctrl1_example_design lpddr2ctrl1.[bcpqsv]* lpddr2ctrl1_sim.f 
	@rm -rf ddr3ctrl1 ddr3ctrl1_sim ddr3ctrl1_example_design ddr3ctrl1.[bcpqsv]* ddr3ctrl1_sim.f 
