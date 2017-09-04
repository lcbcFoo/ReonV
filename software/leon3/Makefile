VPATH=$(GRLIB)/software/leon3
XINC=-I$(GRLIB)/software/leon3 -I$(GRLIB)/software/l2c
XCC=sparc-elf-gcc $(XINC) $(BOPT)
XAS=sparc-elf-gcc -c -I. $(XINC) $(BOPT)
XAR=sparc-elf-ar
XCFLAGS=-O2 -g -msoft-float
ifeq ("$(LDFLAGS)","")
LDFLAGS=-qnoambapp
endif
XLDFLAGS=-L./ lib3tests.a $(LDFLAGS)

PROGS = report_device apbuart divtest multest regtest \
	cache gpio ramfill ramtest irqmp leon3_test gptimer \
	mulasm cacheasm spwtest mptest fpu grfpu_ops \
	base_test grfpu_test can_oc mmu mmu_asm pcitest greth atactrl \
	amba dsu3 greth_api grcan grdmac\
	spictrl i2cmst misc spimctrl svgactrl apbps2 \
	i2cslv i2c l2c \
	grusbdc rt_1553 brm_1553 pcif grtc grtm satcan memscrub_test \
	ftahbram ftlib ftsrctrl ftmctrl bch l2timers l2irqctrl leon2_test \
	grpwm grhcan brm grusbhc leon4_test base_test4 griommu l34stat ftddr2spa \
	router greth_throughput grpci2 gr1553b_test spwrouter \
	cgtest privtest privtest_asm mmudmap leon_tsc dpr_test mem_test grspwtdp \
	rextest rextest_asm awptest

FPROGS=$(shell for i in $(PROGS); do \
			if [ -r $(GRLIB)/software/leon3/$$i.c -o -r $(GRLIB)/software/leon3/$$i.S ]; then \
				echo $$i; \
			fi; \
		done; \
		if [ -r $(GRLIB)/software/greth/greth_api.c ]; then \
			echo greth_api; \
		fi; \
		if [ -r $(GRLIB)/software/l2c/l2capi.c ]; then \
			echo l2capi; \
		fi)
FPROGS+=$(EXTRA_PROGS)
VPATH+=$(GRLIB)/software/l2c

OFILES = $(FPROGS:%=%.o)

%.o: %.c
	$(XCC) $(XCFLAGS) -c  $<

%.o: %.S
	$(XCC) $(XCFLAGS) -c  $<

fpu.o: fpu.c
	$(XCC) -ffast-math -O3 -c  $<

l2c.o: l2c.c
	$(XCC) -O2 -g -Wall -c -mcpu=v8  $<

l2capi.o: l2capi.c
	$(XCC) -O2 -g -c -mcpu=v8  $<

multest.o: multest.c
	$(XCC) -O2 -c -mcpu=v8  $<

divtest.o: divtest.c
	$(XCC) -O2 -c -mcpu=v8  $<

greth_api.o : $(GRLIB)/software/greth/greth_api.c
	$(XCC) -g -msoft-float -c $(GRLIB)/software/greth/greth_api.c

cgtest.o : cgtest.c
	$(XCC) -c  $<

gptimer.o : gptimer.c gptimer.h gpio.h
	$(XCC) -c -g -O2 $<

grspwtdp.o : grspwtdp.c grspwtdp.h grspwtdp-regs.h
	$(XCC) -c -g -Wall -O2 $<

dpr_test.o: dpr_test.c
	$(XCC) -O0 -g -msoft-float -c  $<

#mptest.o: mptest.c
#	$(XCC) -msoft-float -O -c  $<
#


lib3tests.a: $(OFILES)
	$(XAR) -cr lib3tests.a $(OFILES)

soft: prom.srec ram.srec $(EXTRA_SOFT)

prom.o: prom.S prom.h
	$(XAS) $<
prom.exe: prom.o
	$(XCC) -nostdlib -Tlinkprom -N -L./ -nostartfiles -o prom.exe $<

prom.srec: prom.exe
	sparc-elf-objcopy -O srec $(EXTRA_PROM) prom.exe prom.srec

systest.exe: systest.c lib3tests.a
	$(XCC) $(XCFLAGS) systest.c $(XLDFLAGS) -o systest.exe

ram.srec: systest.exe
	sparc-elf-objcopy -O srec --gap-fill 0 systest.exe ram.srec

soft-clean:
	-rm -rf *.o *.exe *.a

mmusoft:
	make -f Makefile.img mmusoft

standalone.exe: systest.c standalone.c lib3tests.a
	$(XCC) $(XCFLAGS) systest.c $(VPATH)/standalone.c $(XLDFLAGS) -o standalone.exe
