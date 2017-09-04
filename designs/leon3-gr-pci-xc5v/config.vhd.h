-- Technology and synthesis options
  constant CFG_FABTECH 	: integer := CONFIG_SYN_TECH;
  constant CFG_MEMTECH  : integer := CFG_RAM_TECH;
  constant CFG_PADTECH 	: integer := CFG_PAD_TECH;
  constant CFG_TRANSTECH	: integer := CFG_TRANS_TECH;
  constant CFG_NOASYNC 	: integer := CONFIG_SYN_NO_ASYNC;
  constant CFG_SCAN 	: integer := CONFIG_SYN_SCAN;

-- Clock generator
  constant CFG_CLKTECH 	: integer := CFG_CLK_TECH;
  constant CFG_CLKMUL   : integer := CONFIG_CLK_MUL;
  constant CFG_CLKDIV   : integer := CONFIG_CLK_DIV;
  constant CFG_OCLKDIV  : integer := CONFIG_OCLK_DIV;
  constant CFG_OCLKBDIV : integer := CONFIG_OCLKB_DIV;
  constant CFG_OCLKCDIV : integer := CONFIG_OCLKC_DIV;
  constant CFG_PCIDLL   : integer := CONFIG_PCI_CLKDLL;
  constant CFG_PCISYSCLK: integer := CONFIG_PCI_SYSCLK;
  constant CFG_CLK_NOFB : integer := CONFIG_CLK_NOFB;

-- LEON processor core
  constant CFG_LEON  	: integer := CONFIG_LEON;
  constant CFG_NCPU 	: integer := CONFIG_PROC_NUM;
  constant CFG_NWIN 	: integer := CONFIG_IU_NWINDOWS;
  constant CFG_V8   	: integer := CFG_IU_V8 + 4*CFG_IU_MUL_STRUCT;
  constant CFG_MAC  	: integer := CONFIG_IU_MUL_MAC;
  constant CFG_SVT  	: integer := CONFIG_IU_SVT;
  constant CFG_RSTADDR 	: integer := 16#CONFIG_IU_RSTADDR#;
  constant CFG_LDDEL	: integer := CONFIG_IU_LDELAY;
  constant CFG_NWP  	: integer := CONFIG_IU_WATCHPOINTS;
  constant CFG_PWD 	: integer := CONFIG_PWD*2;
  constant CFG_FPU 	: integer := CONFIG_FPU + 16*CONFIG_FPU_NETLIST + 32*CONFIG_FPU_GRFPU_SHARED;
  constant CFG_GRFPUSH  : integer := CONFIG_FPU_GRFPU_SHARED;
  constant CFG_ICEN  	: integer := CONFIG_ICACHE_ENABLE;
  constant CFG_ISETS	: integer := CFG_IU_ISETS;
  constant CFG_ISETSZ	: integer := CFG_ICACHE_SZ;
  constant CFG_ILINE 	: integer := CFG_ILINE_SZ;
  constant CFG_IREPL 	: integer := CFG_ICACHE_ALGORND;
  constant CFG_ILOCK 	: integer := CONFIG_ICACHE_LOCK;
  constant CFG_ILRAMEN	: integer := CONFIG_ICACHE_LRAM;
  constant CFG_ILRAMADDR: integer := 16#CONFIG_ICACHE_LRSTART#;
  constant CFG_ILRAMSZ	: integer := CFG_ILRAM_SIZE;
  constant CFG_DCEN  	: integer := CONFIG_DCACHE_ENABLE;
  constant CFG_DSETS	: integer := CFG_IU_DSETS;
  constant CFG_DSETSZ	: integer := CFG_DCACHE_SZ;
  constant CFG_DLINE 	: integer := CFG_DLINE_SZ;
  constant CFG_DREPL 	: integer := CFG_DCACHE_ALGORND;
  constant CFG_DLOCK 	: integer := CONFIG_DCACHE_LOCK;
  constant CFG_DSNOOP	: integer := CONFIG_DCACHE_SNOOP*2 + 4*CONFIG_DCACHE_SNOOP_SEPTAG;
  constant CFG_DFIXED	: integer := 16#CONFIG_CACHE_FIXED#;
  constant CFG_BWMASK  	: integer := 16#CONFIG_BWMASK#;
  constant CFG_CACHEBW 	: integer := OFG_CBUSW;
  constant CFG_DLRAMEN	: integer := CONFIG_DCACHE_LRAM;
  constant CFG_DLRAMADDR: integer := 16#CONFIG_DCACHE_LRSTART#;
  constant CFG_DLRAMSZ	: integer := CFG_DLRAM_SIZE;
  constant CFG_MMUEN    : integer := CONFIG_MMUEN;
  constant CFG_ITLBNUM  : integer := CONFIG_ITLBNUM;
  constant CFG_DTLBNUM  : integer := CONFIG_DTLBNUM;
  constant CFG_TLB_TYPE : integer := CONFIG_TLB_TYPE + CFG_MMU_FASTWB*2;
  constant CFG_TLB_REP  : integer := CONFIG_TLB_REP;
  constant CFG_MMU_PAGE : integer := CONFIG_MMU_PAGE;
  constant CFG_DSU   	: integer := CONFIG_DSU_ENABLE;
  constant CFG_ITBSZ 	: integer := CFG_DSU_ITB + 64*CONFIG_DSU_ITRACE_2P;
  constant CFG_ATBSZ 	: integer := CFG_DSU_ATB;
  constant CFG_AHBPF    : integer := CFG_DSU_AHBPF;
  constant CFG_AHBWP    : integer := CFG_DSU_AHBWP;
  constant CFG_LEONFT_EN   : integer := CONFIG_IUFT_EN + (CONFIG_CACHE_FT_EN)*8;
  constant CFG_LEON_NETLIST : integer := CONFIG_LEON_NETLIST;	
  constant CFG_DISAS    : integer := CONFIG_IU_DISAS + CONFIG_IU_DISAS_NET;
  constant CFG_PCLOW    : integer := CFG_DEBUG_PC32;
  constant CFG_STAT_ENABLE   : integer := CONFIG_STAT_ENABLE;
  constant CFG_STAT_CNT      : integer := CONFIG_STAT_CNT;
  constant CFG_STAT_NMAX     : integer := CONFIG_STAT_NMAX;
  constant CFG_STAT_DSUEN    : integer := CONFIG_STAT_DSUEN;
  constant CFG_NP_ASI   : integer := CONFIG_NP_ASI;
  constant CFG_WRPSR   : integer := CONFIG_WRPSR;
  constant CFG_ALTWIN   : integer := CONFIG_ALTWIN;
  constant CFG_REX      : integer := CONFIG_REX;

-- L2 Cache
  constant CFG_L2_EN    : integer := CONFIG_L2_ENABLE;
  constant CFG_L2_SIZE	: integer := CFG_L2_SZ;
  constant CFG_L2_WAYS	: integer := CFG_L2_ASSO;
  constant CFG_L2_HPROT	: integer := CONFIG_L2_HPROT;
  constant CFG_L2_PEN  	: integer := CONFIG_L2_PEN;
  constant CFG_L2_WT   	: integer := CONFIG_L2_WT;
  constant CFG_L2_RAN  	: integer := CONFIG_L2_RAN;
  constant CFG_L2_SHARE	: integer := CONFIG_L2_SHARE;
  constant CFG_L2_LSZ  	: integer := CFG_L2_LINE;
  constant CFG_L2_MAP  	: integer := 16#CONFIG_L2_MAP#;
  constant CFG_L2_MTRR 	: integer := CONFIG_L2_MTRR;
  constant CFG_L2_EDAC	: integer := CONFIG_L2_EDAC;
  constant CFG_L2_AXI	  : integer := CONFIG_L2_AXI;

-- AMBA settings
  constant CFG_DEFMST  	  : integer := CONFIG_AHB_DEFMST;
  constant CFG_RROBIN  	  : integer := CONFIG_AHB_RROBIN;
  constant CFG_SPLIT   	  : integer := CONFIG_AHB_SPLIT;
  constant CFG_FPNPEN  	  : integer := CONFIG_AHB_FPNPEN;
  constant CFG_AHBIO   	  : integer := 16#CONFIG_AHB_IOADDR#;
  constant CFG_APBADDR 	  : integer := 16#CONFIG_APB_HADDR#;
  constant CFG_AHB_MON 	  : integer := CONFIG_AHB_MON;
  constant CFG_AHB_MONERR : integer := CONFIG_AHB_MONERR;
  constant CFG_AHB_MONWAR : integer := CONFIG_AHB_MONWAR;
  constant CFG_AHB_DTRACE : integer := CONFIG_AHB_DTRACE;

-- DSU UART
  constant CFG_AHB_UART	: integer := CONFIG_DSU_UART;

-- JTAG based DSU interface
  constant CFG_AHB_JTAG	: integer := CONFIG_DSU_JTAG;

-- USB DSU
  constant CFG_GRUSB_DCL        : integer := CONFIG_GRUSB_DCL;
  constant CFG_GRUSB_DCL_UIFACE : integer := CONFIG_GRUSB_DCL_UIFACE;
  constant CFG_GRUSB_DCL_DW     : integer := CONFIG_GRUSB_DCL_DW;

-- Ethernet DSU
  constant CFG_DSU_ETH	: integer := CONFIG_DSU_ETH + CONFIG_DSU_ETH_PROG + CONFIG_DSU_ETH_DIS;
  constant CFG_ETH_BUF 	: integer := CFG_DSU_ETHB;
  constant CFG_ETH_IPM 	: integer := 16#CONFIG_DSU_IPMSB#;
  constant CFG_ETH_IPL 	: integer := 16#CONFIG_DSU_IPLSB#;
  constant CFG_ETH_ENM 	: integer := 16#CONFIG_DSU_ETHMSB#;
  constant CFG_ETH_ENL 	: integer := 16#CONFIG_DSU_ETHLSB#;

-- PROM/SRAM controller
  constant CFG_SRCTRL           : integer := CONFIG_SRCTRL;
  constant CFG_SRCTRL_PROMWS    : integer := CONFIG_SRCTRL_PROMWS;
  constant CFG_SRCTRL_RAMWS     : integer := CONFIG_SRCTRL_RAMWS;
  constant CFG_SRCTRL_IOWS      : integer := CONFIG_SRCTRL_IOWS;
  constant CFG_SRCTRL_RMW       : integer := CONFIG_SRCTRL_RMW;
  constant CFG_SRCTRL_8BIT      : integer := CONFIG_SRCTRL_8BIT;

  constant CFG_SRCTRL_SRBANKS   : integer := CFG_SR_CTRL_SRBANKS;
  constant CFG_SRCTRL_BANKSZ    : integer := CFG_SR_CTRL_BANKSZ;
  constant CFG_SRCTRL_ROMASEL   : integer := CONFIG_SRCTRL_ROMASEL;

-- SDRAM controller
  constant CFG_SDCTRL  	: integer := CONFIG_SDCTRL;
  constant CFG_SDCTRL_INVCLK  	: integer := CONFIG_SDCTRL_INVCLK;
  constant CFG_SDCTRL_SD64    	: integer := CONFIG_SDCTRL_BUS64;
  constant CFG_SDCTRL_PAGE    	: integer := CONFIG_SDCTRL_PAGE + CONFIG_SDCTRL_PROGPAGE;

-- LEON2 memory controller
  constant CFG_MCTRL_LEON2    : integer := CONFIG_MCTRL_LEON2;
  constant CFG_MCTRL_RAM8BIT  : integer := CONFIG_MCTRL_8BIT;
  constant CFG_MCTRL_RAM16BIT : integer := CONFIG_MCTRL_16BIT;
  constant CFG_MCTRL_5CS      : integer := CONFIG_MCTRL_5CS;
  constant CFG_MCTRL_SDEN     : integer := CONFIG_MCTRL_SDRAM;
  constant CFG_MCTRL_SEPBUS   : integer := CONFIG_MCTRL_SDRAM_SEPBUS;
  constant CFG_MCTRL_INVCLK   : integer := CONFIG_MCTRL_SDRAM_INVCLK;
  constant CFG_MCTRL_SD64     : integer := CONFIG_MCTRL_SDRAM_BUS64;
  constant CFG_MCTRL_PAGE     : integer := CONFIG_MCTRL_PAGE + CONFIG_MCTRL_PROGPAGE;

-- FTMCTRL memory controller
  constant CFG_MCTRLFT		: integer := CONFIG_MCTRLFT;
  constant CFG_MCTRLFT_RAM8BIT  : integer := CONFIG_MCTRLFT_8BIT;
  constant CFG_MCTRLFT_RAM16BIT : integer := CONFIG_MCTRLFT_16BIT;
  constant CFG_MCTRLFT_5CS      : integer := CONFIG_MCTRLFT_5CS;
  constant CFG_MCTRLFT_SDEN    	: integer := CONFIG_MCTRLFT_SDRAM;
  constant CFG_MCTRLFT_SEPBUS  	: integer := CONFIG_MCTRLFT_SDRAM_SEPBUS;
  constant CFG_MCTRLFT_INVCLK  	: integer := CONFIG_MCTRLFT_SDRAM_INVCLK;
  constant CFG_MCTRLFT_SD64     : integer := CONFIG_MCTRLFT_SDRAM_BUS64;
  constant CFG_MCTRLFT_EDAC    	: integer := CONFIG_MCTRLFT_EDAC + CONFIG_MCTRLFT_EDACPIPE + CONFIG_MCTRLFT_RSEDAC;
  constant CFG_MCTRLFT_PAGE    	: integer := CONFIG_MCTRLFT_PAGE + CONFIG_MCTRLFT_PROGPAGE;
  constant CFG_MCTRLFT_ROMASEL 	: integer := CFG_M_CTRLFT_ROMASEL;
  constant CFG_MCTRLFT_WFB 	: integer := CONFIG_MCTRLFT_WFB;
  constant CFG_MCTRLFT_NET 	: integer := CONFIG_MCTRLFT_NETLIST;

-- AHB status register
  constant CFG_AHBSTAT 	: integer := CONFIG_AHBSTAT_ENABLE;
  constant CFG_AHBSTATN	: integer := CONFIG_AHBSTAT_NFTSLV;

-- AHB RAM
  constant CFG_AHBRAMEN	: integer := CONFIG_AHBRAM_ENABLE;
  constant CFG_AHBRSZ	: integer := CFG_AHBRAMSZ;
  constant CFG_AHBRADDR	: integer := 16#CONFIG_AHBRAM_START#;
  constant CFG_AHBRPIPE : integer := CONFIG_AHBRAM_PIPE;

-- Gaisler Ethernet core
  constant CFG_GRETH   	    : integer := CONFIG_GRETH_ENABLE;
  constant CFG_GRETH1G	    : integer := CONFIG_GRETH_GIGA;
  constant CFG_ETH_FIFO     : integer := CFG_GRETH_FIFO;
#ifdef CONFIG_GRETH_SGMII_PRESENT
  constant CFG_GRETH_SGMII  : integer := CONFIG_GRETH_SGMII_MODE;
#endif
#ifdef CONFIG_LEON3FT_PRESENT
  constant CFG_GRETH_FT     : integer := CONFIG_GRETH_FT;
  constant CFG_GRETH_EDCLFT : integer := CONFIG_GRETH_EDCLFT;
#endif
-- CAN 2.0 interface
  constant CFG_CAN      : integer := CONFIG_CAN_ENABLE;
  constant CFG_CAN_NUM  : integer := CONFIG_CAN_NUM;
  constant CFG_CANIO    : integer := 16#CONFIG_CANIO#;
  constant CFG_CANIRQ   : integer := CONFIG_CANIRQ;
  constant CFG_CANSEPIRQ: integer := CONFIG_CANSEPIRQ;
  constant CFG_CAN_SYNCRST : integer := CONFIG_CAN_SYNCRST;
  constant CFG_CANFT    : integer := CONFIG_CAN_FT;

-- Spacewire interface
  constant CFG_SPW_EN      : integer := CONFIG_SPW_ENABLE;
  constant CFG_SPW_NUM     : integer := CONFIG_SPW_NUM;
  constant CFG_SPW_AHBFIFO : integer := CONFIG_SPW_AHBFIFO;
  constant CFG_SPW_RXFIFO  : integer := CONFIG_SPW_RXFIFO;
  constant CFG_SPW_RMAP    : integer := CONFIG_SPW_RMAP;
  constant CFG_SPW_RMAPBUF : integer := CONFIG_SPW_RMAPBUF;
  constant CFG_SPW_RMAPCRC : integer := CONFIG_SPW_RMAPCRC;
  constant CFG_SPW_NETLIST : integer := CONFIG_SPW_NETLIST;
  constant CFG_SPW_FT      : integer := CONFIG_SPW_FT;
  constant CFG_SPW_GRSPW   : integer := CONFIG_SPW_GRSPW;
  constant CFG_SPW_RXUNAL  : integer := CONFIG_SPW_RXUNAL;
  constant CFG_SPW_DMACHAN : integer := CONFIG_SPW_DMACHAN;
  constant CFG_SPW_PORTS   : integer := CONFIG_SPW_PORTS;
  constant CFG_SPW_INPUT   : integer := CONFIG_SPW_INPUT;
  constant CFG_SPW_OUTPUT  : integer := CONFIG_SPW_OUTPUT;
  constant CFG_SPW_RTSAME  : integer := CONFIG_SPW_RTSAME;

-- GRPCI2 interface
  constant CFG_GRPCI2_MASTER    : integer := CFG_GRPCI2_MASTEREN;
  constant CFG_GRPCI2_TARGET    : integer := CFG_GRPCI2_TARGETEN;
  constant CFG_GRPCI2_DMA       : integer := CFG_GRPCI2_DMAEN;
  constant CFG_GRPCI2_VID       : integer := 16#CONFIG_GRPCI2_VENDORID#;
  constant CFG_GRPCI2_DID       : integer := 16#CONFIG_GRPCI2_DEVICEID#;
  constant CFG_GRPCI2_CLASS     : integer := 16#CONFIG_GRPCI2_CLASS#;
  constant CFG_GRPCI2_RID       : integer := 16#CONFIG_GRPCI2_REVID#;
  constant CFG_GRPCI2_CAP       : integer := 16#CONFIG_GRPCI2_CAPPOINT#;
  constant CFG_GRPCI2_NCAP      : integer := 16#CONFIG_GRPCI2_NEXTCAPPOINT#;
  constant CFG_GRPCI2_BAR0      : integer := CONFIG_GRPCI2_BAR0;
  constant CFG_GRPCI2_BAR1      : integer := CONFIG_GRPCI2_BAR1;
  constant CFG_GRPCI2_BAR2      : integer := CONFIG_GRPCI2_BAR2;
  constant CFG_GRPCI2_BAR3      : integer := CONFIG_GRPCI2_BAR3;
  constant CFG_GRPCI2_BAR4      : integer := CONFIG_GRPCI2_BAR4;
  constant CFG_GRPCI2_BAR5      : integer := CONFIG_GRPCI2_BAR5;
  constant CFG_GRPCI2_FDEPTH    : integer := CFG_GRPCI2_FIFO;
  constant CFG_GRPCI2_FCOUNT    : integer := CFG_GRPCI2_FIFOCNT;
  constant CFG_GRPCI2_ENDIAN    : integer := CFG_GRPCI2_LENDIAN;
  constant CFG_GRPCI2_DEVINT    : integer := CFG_GRPCI2_DINT;
  constant CFG_GRPCI2_DEVINTMSK : integer := 16#CONFIG_GRPCI2_DINTMASK#;
  constant CFG_GRPCI2_HOSTINT   : integer := CFG_GRPCI2_HINT;
  constant CFG_GRPCI2_HOSTINTMSK: integer := 16#CONFIG_GRPCI2_HINTMASK#;
  constant CFG_GRPCI2_TRACE     : integer := CFG_GRPCI2_TRACEDEPTH;
  constant CFG_GRPCI2_TRACEAPB  : integer := CONFIG_GRPCI2_TRACEAPB;
  constant CFG_GRPCI2_BYPASS    : integer := CFG_GRPCI2_INBYPASS;
  constant CFG_GRPCI2_EXTCFG    : integer := CONFIG_GRPCI2_EXTCFG;

-- PCI arbiter
  constant CFG_PCI_ARB  : integer := CONFIG_PCI_ARBITER;
  constant CFG_PCI_ARBAPB : integer := CONFIG_PCI_ARBITER_APB;
  constant CFG_PCI_ARB_NGNT : integer := CONFIG_PCI_ARBITER_NREQ;

-- USB Host Controller
  constant CFG_GRUSBHC          : integer := CONFIG_GRUSBHC_ENABLE;
  constant CFG_GRUSBHC_NPORTS   : integer := CONFIG_GRUSBHC_NPORTS;
  constant CFG_GRUSBHC_EHC      : integer := CONFIG_GRUSBHC_EHC;
  constant CFG_GRUSBHC_UHC      : integer := CONFIG_GRUSBHC_UHC;
  constant CFG_GRUSBHC_NCC      : integer := CONFIG_GRUSBHC_NCC;
  constant CFG_GRUSBHC_NPCC     : integer := CONFIG_GRUSBHC_NPCC;
  constant CFG_GRUSBHC_PRR      : integer := CONFIG_GRUSBHC_PRR;
  constant CFG_GRUSBHC_PR1      : integer := CONFIG_GRUSBHC_PORTROUTE1;
  constant CFG_GRUSBHC_PR2      : integer := CONFIG_GRUSBHC_PORTROUTE2;
  constant CFG_GRUSBHC_ENDIAN   : integer := CONFIG_GRUSBHC_ENDIAN;
  constant CFG_GRUSBHC_BEREGS   : integer := CONFIG_GRUSBHC_BEREGS;
  constant CFG_GRUSBHC_BEDESC   : integer := CONFIG_GRUSBHC_BEDESC;
  constant CFG_GRUSBHC_BLO      : integer := CONFIG_GRUSBHC_BLO;
  constant CFG_GRUSBHC_BWRD     : integer := CONFIG_GRUSBHC_BWRD;
  constant CFG_GRUSBHC_UTM      : integer := CONFIG_GRUSBHC_UTMTYPE;
  constant CFG_GRUSBHC_VBUSCONF : integer := CONFIG_GRUSBHC_VBUSCONF;

-- GR USB 2.0 Device Controller
  constant CFG_GRUSBDC        : integer := CONFIG_GRUSBDC_ENABLE;
  constant CFG_GRUSBDC_AIFACE : integer := CONFIG_GRUSBDC_AIFACE;
  constant CFG_GRUSBDC_UIFACE : integer := CONFIG_GRUSBDC_UIFACE;
  constant CFG_GRUSBDC_DW     : integer := CONFIG_GRUSBDC_DW;
  constant CFG_GRUSBDC_NEPI   : integer := CONFIG_GRUSBDC_NEPI;
  constant CFG_GRUSBDC_NEPO   : integer := CONFIG_GRUSBDC_NEPO;
  constant CFG_GRUSBDC_I0     : integer := CONFIG_GRUSBDC_I0;
  constant CFG_GRUSBDC_I1     : integer := CONFIG_GRUSBDC_I1;
  constant CFG_GRUSBDC_I2     : integer := CONFIG_GRUSBDC_I2;
  constant CFG_GRUSBDC_I3     : integer := CONFIG_GRUSBDC_I3;
  constant CFG_GRUSBDC_I4     : integer := CONFIG_GRUSBDC_I4;
  constant CFG_GRUSBDC_I5     : integer := CONFIG_GRUSBDC_I5;
  constant CFG_GRUSBDC_I6     : integer := CONFIG_GRUSBDC_I6;
  constant CFG_GRUSBDC_I7     : integer := CONFIG_GRUSBDC_I7;
  constant CFG_GRUSBDC_I8     : integer := CONFIG_GRUSBDC_I8;
  constant CFG_GRUSBDC_I9     : integer := CONFIG_GRUSBDC_I9;
  constant CFG_GRUSBDC_I10    : integer := CONFIG_GRUSBDC_I10;
  constant CFG_GRUSBDC_I11    : integer := CONFIG_GRUSBDC_I11;
  constant CFG_GRUSBDC_I12    : integer := CONFIG_GRUSBDC_I12;
  constant CFG_GRUSBDC_I13    : integer := CONFIG_GRUSBDC_I13;
  constant CFG_GRUSBDC_I14    : integer := CONFIG_GRUSBDC_I14;
  constant CFG_GRUSBDC_I15    : integer := CONFIG_GRUSBDC_I15;
  constant CFG_GRUSBDC_O0     : integer := CONFIG_GRUSBDC_O0;
  constant CFG_GRUSBDC_O1     : integer := CONFIG_GRUSBDC_O1;
  constant CFG_GRUSBDC_O2     : integer := CONFIG_GRUSBDC_O2;
  constant CFG_GRUSBDC_O3     : integer := CONFIG_GRUSBDC_O3;
  constant CFG_GRUSBDC_O4     : integer := CONFIG_GRUSBDC_O4;
  constant CFG_GRUSBDC_O5     : integer := CONFIG_GRUSBDC_O5;
  constant CFG_GRUSBDC_O6     : integer := CONFIG_GRUSBDC_O6;
  constant CFG_GRUSBDC_O7     : integer := CONFIG_GRUSBDC_O7;
  constant CFG_GRUSBDC_O8     : integer := CONFIG_GRUSBDC_O8;
  constant CFG_GRUSBDC_O9     : integer := CONFIG_GRUSBDC_O9;
  constant CFG_GRUSBDC_O10    : integer := CONFIG_GRUSBDC_O10;
  constant CFG_GRUSBDC_O11    : integer := CONFIG_GRUSBDC_O11;
  constant CFG_GRUSBDC_O12    : integer := CONFIG_GRUSBDC_O12;
  constant CFG_GRUSBDC_O13    : integer := CONFIG_GRUSBDC_O13;
  constant CFG_GRUSBDC_O14    : integer := CONFIG_GRUSBDC_O14;
  constant CFG_GRUSBDC_O15    : integer := CONFIG_GRUSBDC_O15;

-- UART 1
  constant CFG_UART1_ENABLE : integer := CONFIG_UART1_ENABLE;
  constant CFG_UART1_FIFO   : integer := CFG_UA1_FIFO;

-- UART 2
  constant CFG_UART2_ENABLE : integer := CONFIG_UART2_ENABLE;
  constant CFG_UART2_FIFO   : integer := CFG_UA2_FIFO;

-- LEON3 interrupt controller
  constant CFG_IRQ3_ENABLE  : integer := CONFIG_IRQ3_ENABLE;
  constant CFG_IRQ3_NSEC    : integer := CONFIG_IRQ3_NSEC;

-- Modular timer
  constant CFG_GPT_ENABLE   : integer := CONFIG_GPT_ENABLE;
  constant CFG_GPT_NTIM     : integer := CONFIG_GPT_NTIM;
  constant CFG_GPT_SW       : integer := CONFIG_GPT_SW;
  constant CFG_GPT_TW       : integer := CONFIG_GPT_TW;
  constant CFG_GPT_IRQ      : integer := CONFIG_GPT_IRQ;
  constant CFG_GPT_SEPIRQ   : integer := CONFIG_GPT_SEPIRQ;
  constant CFG_GPT_WDOGEN   : integer := CONFIG_GPT_WDOGEN;
  constant CFG_GPT_WDOG     : integer := 16#CONFIG_GPT_WDOG#;

-- GPIO port
  constant CFG_GRGPIO_ENABLE : integer := CONFIG_GRGPIO_ENABLE;
  constant CFG_GRGPIO_IMASK  : integer := 16#CONFIG_GRGPIO_IMASK#;
  constant CFG_GRGPIO_WIDTH  : integer := CONFIG_GRGPIO_WIDTH;

-- MIL-STD-1553 controllers

  constant CFG_GR1553B_ENABLE     : integer := CONFIG_GR1553B_ENABLE;
  constant CFG_GR1553B_RTEN       : integer := CONFIG_GR1553B_RTEN;
  constant CFG_GR1553B_BCEN       : integer := CONFIG_GR1553B_BCEN;
  constant CFG_GR1553B_BMEN       : integer := CONFIG_GR1553B_BMEN;

-- GRLIB debugging
  constant CFG_DUART    : integer := CONFIG_DEBUG_UART;

