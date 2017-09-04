GRLIB=../..
TOP=leon3mp
VHDLSYNFILES=config.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd ahbfile.vhd
SIMTOP=testbench
TECHLIBS = inferred

LIBSKIP = synplify spw eth opencores esa fmf spansion gsi cypress micron
DIRSKIP = i2c greth can memctrl l2cache/v2-pkg l2cache ambatest pci jtag spacewire usb ddr gr1553b spi leon4v0 hcan satcan

CLEAN=local-clean

#GHDL=/usr/bin/ghdl
include $(GRLIB)/bin/Makefile
GHDLMOPT+=-Wl,ahbfile_foreign.o -O2

##################  project specific targets ##########################

$(SIMTOP): ahbfile_foreign.o
ahbfile_foreign.o: ahbfile_foreign.c
	$(CC) -std=c99 -Wall -Wextra -pedantic -O2 -c $^ -o $@ -DAHBFILE_DEBUG=256

.PHONY: local-clean
local-clean:
	rm -f *.o

