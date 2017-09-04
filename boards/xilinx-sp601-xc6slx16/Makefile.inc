# Since synplify seems to cause a synthsis error involving
# the DSP macro blocks the Spartan 3A technology 
# without DSP is used for synthesis
#
TECHNOLOGY=Spartan6
ISETECH="Spartan6"
PART=XC6SLX16
PACKAGE=csg324
SPEED=-2
SYNFREQ=220
PROMGENPAR= -c FF -s 8192 -u 0 $(TOP).bit -p mcs -spi -w -o xilinx-sp601-xc6slx16

MANUFACTURER=Xilinx
MGCPART=XC6SLX16$(PACKAGE)
MGCTECHNOLOGY=SPARTAN-6
MGCPACKAGE=$(PACKAGE)
