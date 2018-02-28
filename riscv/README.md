# Running an example on nexys4 ddr board

This is an example of how you can run an simple program on ReonV. We will use Nexys4ddr, however to use another board you will follow similar steps, 
changing a few commands to the ones your board requires.

---
## Overview
* ReonV currentily implements RV32I without privilegied instructions, so it is important to use a compiler to this ISA (follow instructions on the main README). 
* We will use GRMON2 to load, run and debug the program, since the processor DSU was not changed and it communicates with GRMON. However, GRMON2 was not designed for RISC-V and we have to take some workarounds to run a RISC-V program using it (more information on issue [GRMON2 and RISCV](https://github.com/lcbcFoo/ReonV/issues/5)
* The scrips for running on nexys4ddr are at `designs/leon3-digilent-nexys4ddr`. If you are running on other board, you must use its own design directory.

## Compiling the program
Currently, we have a simple `crt0.S` to initialize stack and other registers. Also, we have some minimal posix functions needed for benchmarks implemented on `posix.c`. These file are linked to the main.c program by the linker script, allowing us to use some commom functions from glibc. However, we do not have complete support for glibc at this moment. The linker script also sets the beginning of `.text` to position 0x40001000 (a workaround needed to run via GRMON2). To compile a program `main.c` on the `riscv` directory run:   
```
make main.out
```

---
## Synthetizing and loading design to FPGA
To synthetize ReonV you must change to your board design directory, in this example it is `designs/leon3-digilent-nexys4ddr`. There is a README in each design directory, follow the instructions there to synthetize and load the design to FPGA. In this example, they are:
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
GRMON2 has many features, but some are still restricted because of our RISC-V ISA. To load and our program use:
```
bload ../../riscv/main.out 0x40000000   # Load on memory position 0x40000000
ep 0x40001000                           # Set entry point to position 0x40001000
run
```
You can `reset` the processor, see the registers with `reg`, set a breakpoint with `bp <address>`, run step by step with `step`, disassemble memory with `disassemble <memory address>` and a lot of others commands described on GRMON2´s [manual](http://www.gaisler.com/doc/grmon2.pdf).
