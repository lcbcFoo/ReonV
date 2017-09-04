
LEON3 Template design for TerASIC Altera DE2 board
------------------------------------------------------

0. Introduction
---------------

The leon3 design can be synthesized with quartus or synplify,
and can reach 50 - 70 MHz depending on configuration and synthesis
options. Use 'make quartus' or 'make quartus-synp' to run the
complete flow. To program the FPGA in batch mode, use 
'make quartus-prog-fpga' or 'make quartus-prog-fpga-ref (reference config).
On linux, you might need to start jtagd as root to get the proper
port permissions. LEON3 reset is mapped on KEY0.

1. SDRAM interface

The SDRAM works fine with the MCTRL controller, providing 8 Mbyte memory.

2. FLASH

The FLASH is also interfaced with MCTRL, in 8-bit mode. Programming
works fine with GRMON.

grlib> fla

 AMD-style 8-bit flash

 Manuf.    AMD                 
 Device    MX29LV128MB       

 1 x 8 Mbyte = 8 Mbyte total @ 0x00000000

 CFI info
 flash family  : 2
 flash size    : 64 Mbit
 erase regions : 2
 erase blocks  : 135
 write buffer  : 32 bytes
 lock-down     : yes
 region  0     : 8 blocks of 8 Kbytes
 region  1     : 127 blocks of 64 Kbytes

3. UART

The single RS232 port can be use as console when switch SW0 is
off, or as debug link for GRMON when SW0 is on.

