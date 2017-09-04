# FPGA and Dev Board used in Design
TECHNOLOGY=Artix7
PART=xc7a200t
PACKAGE=fbg676
PROTOBOARD=xilinx.com:ac701:part0:1.0
SPEED=2
PROMGENPAR=-u 0 $(TOP).bit -p mcs -spi -w -o $(BOARD)

# For 'Vivado Synthesis' flow set:
VIVADO_SYNTH_STRATEGY="Vivado Synthesis Defaults"

# Set Vivado Implementation strategy
VIVADO_IMPL_STRATEGY="Vivado Implementation Defaults"
