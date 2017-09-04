TECHNOLOGY=Virtex5
PACKAGE=ff1136
SPEED=-1
SYNFREQ=250

ifeq ("$(CONFIG_BOARD_ML505)","y")
PART=xc5vlx50t
MGCPART=5vlx50t$(PACKAGE)
endif

ifeq ("$(CONFIG_BOARD_ML506)","y")
PART=xc5vsx50t
MGCPART=5vsx50t$(PACKAGE)
endif

ifeq ("$(CONFIG_BOARD_ML507)","y")
PART=xc5vfx70t
MGCPART=5vfx70t$(PACKAGE)
endif

ifeq ("$(CONFIG_BOARD_ML509)","y")
PART=xc5vlx110t
MGCPART=5vlx110t$(PACKAGE)
endif

MANUFACTURER=Xilinx
PROMGENPAR=-x xcf32p xcf32p -u 0 $(TOP).bit -p mcs -w -o xilinx-ml50x
MGCTECHNOLOGY=VIRTEX-5
MGCPACKAGE=$(PACKAGE)

# Set PlanAhead Synthesis Flow and Strategy used for build
PLANAHEAD_SYNTH_FLOW="XST 14"
PLANAHEAD_SYNTH_STRATEGY="TimingWithIOBPacking"

# Set PlanAhead Implementation strategy
PLANAHEAD_IMPL_STRATEGY="MapLogicOptParHighExtra"
