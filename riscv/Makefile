################################################################################
#
# Author: Lucas Castro
# Last modification: march/2018
#
# 	Makefile for running programs on ReonV
#
################################################################################
#
# Update the following variables to your environment and board used

# Cross compiler (Must be RV32I only)
CROSS=../../rv32i-gcc/bin/riscv32-unknown-elf-

# Design you are targeting
DESIGN=leon3-digilent-nexys4ddr


CC=gcc
AS=as
OBJCOPY=objcopy
CFLAGS=-nostdlib
OBJCPFLAGS=-O binary -j .text -j .data
LD_SCRIPT=ld_script
WRAP=-Wl,-wrap,exit,-wrap,open,-wrap,close,-wrap,write,-wrap,read,-wrap,lseek,-wrap,sbrk

################################################################################
#
# 	Targets for compiling
#
# Compiled binary linked with reonv_crt0
%.out : %.c reonv_crt0.o posix.o
	${CROSS}${CC} -static -march=rv32i ${WRAP} -T${LD_SCRIPT} $< -o $@

# Targets for .S.
# .o is for linking programs (i.e. crt0.S)
# .hex is for other assembly programs
%.hex : %.S
	${CROSS}$(AS) $< -o $@

posix.o : posix.c
	${CROSS}${CC} -c $< -o $@ -nostdlib ${WRAP}

reonv_crt0.o : reonv_crt0.S
	${CROSS}${CC} -c $< -o $@ -nostdlib ${WRAP}

# Target raw binary to avoid grmon2 errors saying this is not SPARC '-'
%.bin : %.out
	${CROSS}$(OBJCOPY) $(OBJCPFLAGS)  $< $@

%.bin : %.hex
	${CROSS}$(OBJCOPY) $(OBJCPFLAGS)  $< $@

################################################################################
#
# 	Boot Code
#
# Adapted PROM generation based on original leon3 script (found at ../bin)
ahbrom.vhd : ahbrom boot_code.bin
	./ahbrom boot_code.bin ahbrom.vhd

bootcode : ahbrom.vhd
	cp ahbrom.vhd ../designs/${DESIGN}/ahbrom.vhd -f
	@echo "Generated ahbrom.vhd and placed at ../../designs/${DESIGN}"

ahbrom : ../bin/ahbrom.c
	gcc ../bin/ahbrom.c -o ahbrom

clean:
	rm -rf ahbrom* *.hex *.inv *.bin *.o *.log *.jou *.str acstone/*.out *.out *.read
