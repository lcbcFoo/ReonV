# Since synplify seems to cause a synthsis error involving
# the DSP macro blocks the Spartan 3A technology 
# without DSP is used for synthesis
#
TECHNOLOGY=Spartan-3A-DSP
ISETECH="Spartan-3A DSP"
PART=XC3SD1800A
PACKAGE=fg676
SPEED=-4
SYNFREQ=140
PROMGENPAR=-x xcf08p -u 0 $(TOP).bit -p mcs -w -o xilinx-spa3-dsp1800a

MANUFACTURER=Xilinx
MGCPART=XC3SD1800A$(PACKAGE)
MGCTECHNOLOGY=SPARTAN-3A-DSP
MGCPACKAGE=$(PACKAGE)
