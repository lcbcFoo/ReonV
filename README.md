# ReonV
This is the ReonV project repository. ReonV is a modified version of the [Leon3](http://www.gaisler.com/index.php/products/processors/leon3), a synthesisable VHDL model of a 32-bit processor originally compliant with the SPARC V8 architecture, now changed to implement the RISC-V RV32I ISA.

---
## Table of Contents
* [The ReonV](#reonv)
  * [What is ReonV?](#what-reonv)
  * [Why creating a new RISC-V project?](#why-reonv)
* [Repository Map](#repo-map)
* [Installation](#install)
  * [RISC-V toolchain](#rv-toolchain)
  * [ReonV](#install-reonv)
  * [GRMON2](#install-grmon)
* [Running an Example](#running)

---
## <a name="reonv"></a> The ReonV
### <a name="what-reonv"></a> What is ReonV?
Simply speaking, ReonV is a RV32I version of the [Leon3](http://www.gaisler.com/index.php/products/processors/leon3) processor which is provided as part of the [GRLIB IP Library](http://www.gaisler.com/index.php/products/ipcores/soclibrary) on GPL license by [Cobham Gaisler AB](http://www.gaisler.com/).
ReonV changed the Leon3 7-stage integer pipeline from SPARC to RISC-V, mantaining all other IP cores and resources provided by GRLIB IP Library untouched. With this, we aimed to provide all the support to synthesis and peripherals Leon3 has to a RISC-V processor.
### <a name="why-reonv"></a> Why creating a new RISC-V project?
While there are good examples of advanced RISC-V projects, most of them built an entirely new processor and so had to build from the ground all the support to synthesis and peripherals to run it and also deal with compatibility problems when expanding the project to other environments. ReonV took another path. We used a very well documented, GPL licensed and tested IP Library, the GRLIB, made for the SPARC based Leon3 processor and changed its ISA to RISC-V, resulting in a RISC-V processor with support to many peripherals, different synthesis, simulation tools and FPGAs.
Also, we wanted to show to the hardware developers community that it is possible to reuse hardware and that doing so makes development easier. 

---
## <a name="repo-map"></a> Repository Map
The directories `bin`, `boards` and `software` where simply copied from GRLIB and contain scripts, templates and small programs used by GRLIB. The directory `doc` constains the documentation from GRLIB (may be updated with ReonV specific documentation on future). Directory `designs` contains all scripts and configuration designs for each specific FPGA board supported by Leon3 (and by ReonV). Directory `lib` constains the source code of the processor and of all peripherals or IP cores provided by GRLIB, the 7-stage integer pipeline changed to RISC-V is at `lib/gaisler/leon3v3/iu3.vhd`. Lastly, `riscv` contains scripts and configuration files to run a test example on ReonV (check [Running an Example](#running) section). 

---
## <a name="install"></a> Installation
### <a name="install-reonv"></a> ReonV
As already explained, ReonV is a modified version of the Leon3 processor, which is part of GRLIB, that means you can clone this repository and follow the detailed instructions provided in the GRLIB User Manual (it can be found at `doc/grlib.pdf` or [here](http://www.gaisler.com/products/grlib/grlib.pdf)) depending on the tools you want to use for synthesis or simulation or even on which FPGA you are going to run.
### <a name="rv-toolchain"></a> RISC-V Toolchain
It is needed to compile a program targeting RISC-V architecture, its repository can be found [here](https://github.com/riscv/riscv-gnu-toolchain). Follow the instructions provided there and make sure to compile it for RV32I only! You can make this by replacing the line `./configure --prefix=/the/path/you/chose` explained on their README to `./configure --with-arch=rv32i --with-abi=ilp32 --prefix=/the/path/you/chose`.
### <a name="install-grmon"></a> GRMON2
GRMON2 is the Leon3 debugging tool provided by [Cobham Gaisler AB](http://www.gaisler.com/). It communicates with the Debugging Unit of the processor and allows to easily execute programs and debug the processor. GRMON has evaluation and professional versions, you can find the download links and its manual [here](http://www.gaisler.com/index.php/downloads/debug-tools).

---
## <a name="running"></a> Running an Example
Follow instructions of the README on `riscv` directory.
