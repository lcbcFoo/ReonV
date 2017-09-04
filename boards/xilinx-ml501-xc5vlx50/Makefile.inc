TECHNOLOGY=Virtex5
PART=xc5vlx50
PACKAGE=ff676
SPEED=-1
SYNFREQ=110
PROMGENPAR=-x xcf32p -u 0 $(TOP).bit -p mcs -w -o xilinx-ml501-xc5vlx50

MANUFACTURER=Xilinx
MGCPART=5vlx50$(PACKAGE)
MGCTECHNOLOGY=VIRTEX-5
MGCPACKAGE=$(PACKAGE)

# Set PlanAhead Synthesis Flow and Strategy used for build
PLANAHEAD_SYNTH_FLOW="XST 14"
PLANAHEAD_SYNTH_STRATEGY="TimingWithIOBPacking"

# Set PlanAhead Implementation strategy
PLANAHEAD_IMPL_STRATEGY="MapLogicOptParHighExtra"
