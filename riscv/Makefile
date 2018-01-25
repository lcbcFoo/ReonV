######################################################################
#
# Author: Lucas Castro
# Last modification: jan/2018
#
# 	Makefile for running programs on ReonV
#
######################################################################
#
# Update the following variables to your environment and board used

# Cross compiler (Must be RV32I only)
CROSS=../../rv32i/rv32i-gnu/bin/riscv32-unknown-elf-

# Design you are targeting
DESIGN=leon3-digilent-nexys4ddr

# Leon3 designs might use a prom.srec to load boot code.
# This is the binary to .srec converter this makefile will look for. 
# In need check this one under GPL: http://www.s-record.com/
BIN2SREC=../../srec/bin2srec

CC=gcc
AS=as
OBJCOPY=objcopy
CFLAGS=-nostdlib
OBJCPFLAGS=-O binary -j .text
LD_SCRIPT=ld_script

#####################################################################
#
#  Targets for Makefile
#
#####################################################################
# Compiled binary linked with reonv_crt0
%.out : %.c reonv_crt0.o
	${CROSS}${CC} -static -T${LD_SCRIPT} $< -o $@

# Targets for .S. 
# .o is for linking programs (i.e. crt0.S)
# .hex is for other assembly programs 
%.hex : %.S
	${CROSS}$(AS) $< -o $@

%.o : %.S
	${CROSS}${CC} -c $< -o $@

# Target raw binary to avoid grmon2 errors saying this is not SPARC '-'
%.bin : %.out 
	${CROSS}$(OBJCOPY) $(OBJCPFLAGS)  $< $@

%.bin : %.hex
	${CROSS}$(OBJCOPY) $(OBJCPFLAGS)  $< $@

# Adapted PROM generation based on original leon3 script (found at ../bin)
ahbrom.vhd : ahbrom boot_code.bin
	./ahbrom boot_code.bin ahbrom.vhd

bootcode : ahbrom.vhd
	cp ahbrom.vhd ../designs/${DESIGN}/ahbrom.vhd -f	
	@echo "Generated ahbrom.vhd and placed at ../../designs/${DESIGN}"

ahbrom : ../bin/ahbrom.c 
	gcc ../bin/ahbrom.c -o ahbrom

clean:
	rm -rf ahbrom* *.hex *.inv *.bin *.o *.log *.jou *.str
