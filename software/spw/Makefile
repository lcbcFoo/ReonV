CC=sparc-elf-gcc
CCOPT=-msoft-float -g

all: dual sep single router

dual: rmapapi.h spwapi.h spwapi.c rmapapi.c spw_test_dual.c
	$(CC) $(CCOPT) -o spw_test_dual spw_test_dual.c spwapi.c rmapapi.c

sep: rmapapi.h spwapi.h spwapi.c rmapapi.c spw_test_dual_sep.c
	$(CC) $(CCOPT) -DINITIATOR=0 -DSPW_ADDR=0x80000a00 -DSPW_FREQ=200000 -DAHBFREQ=40000 -DSPW_CLKDIV=1 -o spw_test_dual_targ spw_test_dual_sep.c spwapi.c rmapapi.c
	$(CC) $(CCOPT) -DINITIATOR=1 -DSPW_ADDR=0x80000c00 -DSPW_FREQ=80000 -DAHBFREQ=25000 -DSPW_CLKDIV=0 -o spw_test_dual_init spw_test_dual_sep.c spwapi.c rmapapi.c

single: rmapapi.h spwapi.h spwapi.c rmapapi.c spwtest.c
	$(CC) $(CCOPT) -o spw_test spwtest.c spwapi.c rmapapi.c

router: rmapapi.h spwapi.h spwapi.c rmapapi.c router_test.c
	$(CC) $(CCOPT) -o router_test router_test.c spwapi.c rmapapi.c

router_dual: rmapapi.h spwapi.h spwapi.c rmapapi.c router_test_dual.c
	$(CC) $(CCOPT) -o router_test_dual router_test_dual.c spwapi.c rmapapi.c

router_test_18x: rmapapi.h spwapi.h spwapi.c rmapapi.c router_test_18x.c
	$(CC) $(CCOPT) -o router_test_18x router_test_18x.c spwapi.c rmapapi.c

router_test_ngmp: rmapapi.h spwapi.h spwapi.c rmapapi.c router_test_ngmp.c
	$(CC) $(CCOPT) -qambapp -Wl,-msparcleon0 -o router_test_ngmp router_test_ngmp.c spwapi.c rmapapi.c

router_dual_single: rmapapi.h spwapi.h spwapi.c rmapapi.c router_test_dual_single_link.c
	$(CC) $(CCOPT) -o router_test_dual_single router_test_dual_single_link.c spwapi.c rmapapi.c

router_dual_single_rasta: rmapapi.h spwapi.h spwapi.c rmapapi.c router_test_dual_single_link.c
	$(CC) $(CCOPT) -o router_test_dual_single_rasta router_test_dual_single_link_rasta.c spwapi.c rmapapi.c

router_single-loopback: router_test_single-loopback.c rmapapi.h spwapi.h spwapi.c rmapapi.c
	$(CC) $(CCOPT) -o $@ $< spwapi.c rmapapi.c

clean:
	-rm -rf router_test spw_test spw_test_dual_init spw_test_dual_targ spw_test_dual

