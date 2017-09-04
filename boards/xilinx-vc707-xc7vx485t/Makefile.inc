# FPGA and Dev Board used in Design
TECHNOLOGY=Virtex7
PART=XC7VX485T
PACKAGE=ffg1761
PROTOBOARD=xilinx.com:vc707:part0:1.3
SPEED=2
PROMGENPAR=-u 0 $(TOP).bit -p mcs -data_width 16 -w -o $(BOARD)

# Set Vivado Synthesis Flow and Strategy used for build
# Choose 'XST 14' or 'Vivado Synthesis 2012'
#VIVADO_SYNTH_FLOW="Vivado Synthesis 2012"

# For 'Vivado Synthesis 2012' flow set:
#    1. 'Vivado Synthesis Defaults'
# For 'XST 14'flow set:
#    1. 'TimingWithIOBPacking'
#    2. 'TimingWithoutIOBPacking'
#    3. 'AreaReduction'
#    4. 'PowerOptimization'
#    5. 'XST Defaults'
#VIVADO_SYNTH_STRATEGY="Vivado Synthesis Defaults"

# Set Vivado Implementation strategy
#   1. 'HighEffort'
#   2. 'HighEffortPhySynth'
#   3. 'Vivado Implemnation Defaults'
#   4. 'LowEffort'
#   5. 'QuickEffort'
#VIVADO_IMPL_STRATEGY="HighEffortPhySynth"
