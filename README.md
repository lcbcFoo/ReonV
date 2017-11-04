# ReonV
This is the ReonV project repository. ReonV is a modified version of the [Leon3](http://www.gaisler.com/index.php/products/processors/leon3), a synthesisable VHDL model of a 32-bit processor originally compliant with the SPARC V8 architecture, now changed to implement the RISC-V RV32I ISA.
## Table of Contents
* [The ReonV](#reonv)
  * [What is ReonV?](#what-reonv)
  * [Why creating a new RISC-V project?](#why-reonv)
* [Installation](#install)
  * [RISC-V toolchain](#rv-toolchain)
  * [ReonV](#intall-reonv)

## <a name="reonv"></a> The ReonV
### <a name="what-reonv"></a> What is ReonV?
Simply speaking, ReonV is a RV32I version of the [Leon3](http://www.gaisler.com/index.php/products/processors/leon3) processor which is provided as part of the [GRLIB IP Library](http://www.gaisler.com/index.php/products/ipcores/soclibrary) on GPL license by Cobham plc.
ReonV changed the Leon3 7-stage integer pipeline from SPARC to RISC-V, mantaining all other IP cores and resources provided by GRLIB IP Library (which is a lot) untouched. With this, we aimed to provide all the support to synthesis and peripherals Leon3 has to a RISC-V processor.
### <a name="why-reonv"></a> Why creating a new RISC-V project?
While there are good examples of advanced RISC-V projects, most of them built an entirely new processor and so had to build from the ground all the support to synthesis and peripherals to run it and also deal with compatibility problems when expanding the project to other environments. ReonV took another path. We used a very well documented, GPL licensed and tested IP Library, the GRLIB, made for the SPARC based Leon3 processor and changed its ISA to RISC-V, resulting in a RISC-V processor with support to many peripherals, different synthesis, simulation tools and FPGAs.
Also, we wanted to show to the hardware developers community that it is possible to reuse hardware and that doing so makes development easier. 
## <a name="install"></a> Installation
### <a name="rv-toolchain"></a> RISC-V Toolchain
Needed to compile a program targeting RISC-V architecture, its repository can be found [here](https://github.com/riscv/riscv-gnu-toolchain)
### <a name="install ReonV"></a> ReonV
As already explained, ReonV is a modified version of the Leon3 processor, which is part of GRLIB, that means you can clone this repository and follow the detailed instructions provided in the GRLIB User Manual (it can be found at doc/grlib.pdf or [here](http://www.gaisler.com/products/grlib/grlib.pdf)) depending on the tools you want to use for synthesis or simulation or even on which FPGA you are goind to run.

