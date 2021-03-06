# Running an example on nexys4 ddr board

This is an example of how you can run an simple program on ReonV. We will use Nexys4ddr, however to use another board you will follow similar steps, 
changing a few commands to the ones your board requires.

---
## Overview
* ReonV currently implements RV32I without privileged instructions, so it is important to use a compiler to this ISA (follow instructions on the main README). 
* We will use GRMON2 to load, run and debug the program, since the processor DSU was not changed and it communicates with GRMON. However, GRMON2 was not designed for RISC-V and we have to take some workarounds to run a RISC-V program using it (more information on issue [GRMON2 and RISCV](https://github.com/lcbcFoo/ReonV/issues/5))
* The design directory for this board is `designs/leon3-digilent-nexys4ddr`. If you are running on other board, you must use its own design directory.

## Compiling the program
Currently, we have a simple `crt0.S` to initialize stack and other registers. Also, we have some minimal posix functions needed for benchmarks implemented on `posix.c`. These file are linked to the main.c program by the linker script, allowing us to use some commom functions from glibc. However, we do not have complete support for glibc at this moment. The linker script also sets the beginning of `.text` to position 0x40001000 (a workaround needed to run via GRMON2). To compile a program `main.c` on the `riscv` directory, update the `Makefile` with your cross-compiler and design directory then run:   
```
make main.out
```

---
## Synthesizing and loading design to FPGA
To synthesize ReonV you must change to your board design directory, in this example it is `designs/leon3-digilent-nexys4ddr`. There is a README in each design directory, follow the instructions there to synthesize and load the design to FPGA. In this example, they are:
```
make sim
make vivado
make vivado-prog-fpga  # with the FPGA connected to the computer 
```

---
## Using GRMON2
You can follow the instructions of how to communicate with the FPGA using GRMON2 on its [manual](http://www.gaisler.com/doc/grmon2.pdf). On this example, we need to run:
```
grmon -digilent -u
# On GRMON2, we have to run this command as written on nexys4ddr readme
ddr2delay scan
# Close GRMON2
q
# Reopen GRMON2
grmon -digilent -u
# Now we are ready to run the example
```

## Running the program
GRMON2 has many features, but some are still restricted because of our RISC-V ISA. To load and run our program use:
```
bload ../../riscv/main.out 0x40000000   # Load on memory position 0x40000000
ep 0x40001000                           # Set entry point to position 0x40001000
run
```
Our sample program allocates 2 integer arrays on heap, calculates the first 20 fibonacci numbers and places them on array 1, writes this array into output section of memory with `write`, then reads the results written there using `lseek` and `read` into array2, comparing both arrays in sequence. Then it makes some printf tests and finishes.
After the `run` command, you can check registers with `reg` and `reg w7` (explanation at [GRMON2 and RISCV](https://github.com/lcbcFoo/ReonV/issues/5)). Then check the results with `disassemble 0x44000000` and verify heap with `disassemble 0x43000000`. Below is the entire described process to run our example on GRMON2 with #commentaries added.
```
grmon2> bload ../../riscv/main.out        # Load program 

  40000000 Binary data  11.2kB /  11.2kB   [===============>] 100%  
  Total size: 11.23kB (505.32kbit/s)                              
  Entry point 0x40000000                                                                       
  Image /home/foo/IC/riscv-leon/repo/riscv/main.out loaded 
  
grmon2> ep 0x40001000                     # Set entry point                                                                 

  Cpu 0 entry point: 0x40001000  
  
grmon2> run                               # Run

  # There will be many prints from main.c here 

Testing fib calculator, array dealing, write, read and lseek functions

  # ...
  
Finished main!

  
  Stopped (tt = 0x00, )                                                                   
  0x400010b8: 73001000  call  0x0C0050B8    # This represents an ebreak instruction which stops execution
  
grmon2> reg         # The first 3 colluns represents registers 8-31 (8 is OUTS 0, 16 is LOCALS 0, 24 is INS 0)

         INS        LOCALS     OUTS       GLOBALS
     0:  00000000   00000000   43FFFFF0   00000000
     1:  00000000   00000000   00000000   00000000
     2:  00000000   00000000   00000000   00000000
     3:  00000000   00000000   00000016   00000000
     4:  00000000   00000000   00000016   00000000
     5:  00000000   00000000   43000016   00000000
     6:  00000000   00000000   43000016   00000000
     7:  00000000   00000000   00000000   00000000
  
   psr: F35000E0   wim: 00000002   tbr: 40001000   y: 00000000
  
   pc:   40001A90  call  0x0C005A90            
   npc:  40001A94  call  0xFC001A94 
   
grmon2> reg w7      # The LOCALS colluns shows our registers 0-7 (LOCALS 0 is our 0)

         INS        LOCALS     OUTS       GLOBALS
     0:  43FFFFF0   00000000   00000000   00000000
     1:  00000000   400010A4   00000000   00000000
     2:  00000000   43FFFFD0   00000000   00000000
     3:  00000016   40003C49   00000000   00000000
     4:  00000016   00000000   00000000   00000000
     5:  43000016   400011A8   00000000   00000000
     6:  43000016   400020A4   00000000   00000000
     7:  00000000   00000000   00000000   00000000      

grmon2> disassemble 0x44000000                           # Disassemble our output section
                                                         # The translation made by GRMON2 is based on SPARC, ignore it
       0x44000000: 01000000  nop                 
       0x44000004: 01000000  nop                 
       0x44000008: 02000000  unimp               
       0x4400000c: 03000000  sethi  %hi(0x0), %g1
       0x44000010: 05000000  sethi  %hi(0x0), %g2
       0x44000014: 08000000  unimp               
       0x44000018: 0d000000  sethi  %hi(0x0), %g6
       0x4400001c: 15000000  sethi  %hi(0x0), %o2
       0x44000020: 22000000  unimp               
       0x44000024: 37000000  sethi  %hi(0x0), %i3
       0x44000028: 59000000  call  0xA8000028    
       0x4400002c: 90000000  add  0, %o0         
       0x44000030: e9000000  ld  [0], %f20       
       0x44000034: 79010000  call  0x28040034    
       0x44000038: 62020000  call  0xCC080038             # Note, this number is 0x0262!
       0x4400003c: db030000  ld  [%o4], %f13              # Note, this number is 0x03db!
```
## Important information (READ IT)
* As described in the [GRMON2 and RISCV](https://github.com/lcbcFoo/ReonV/issues/5) issue, GRMON2 assumes processor is using big endian, therefore it shows bytes of a word backwards, for example:
Number 974169 in RISC-V convention is `0x 00 0E DD 59`, GRMON2 shows it as `0x 59 DD 0E 00`
This is only a visual inconvenience that must be kept in mind when reading values from memory while using GRMON2.
* Console is implemented by sending data via UART (memory position `0x80000100`). Mini-printf (https://github.com/mludvig/mini-printf) is being used to format strings to be printed. 
* You can also check the results of your program with the simple `write`, `read` and `lseek` functions implemented at `posix.c`. They use memory section `0x44000000 - 0x450000000` as an output section, allowing you to `dump` this region with GRMON2 and compare result with another environment if you wish. 
* The default value for stack is `0x43FFFFF0` and `0x43000000` for the heap.
* Some commands of GRMON2 are `reg` and `reg w7` to see registers, set a breakpoint with `bp <address>`, run step by step with `step`, disassemble memory with `disassemble <memory address>` and a lot of others commands described on GRMON2´s [manual](http://www.gaisler.com/doc/grmon2.pdf).

