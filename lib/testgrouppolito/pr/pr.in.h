#ifndef CONFIG_PARTIAL
#define CONFIG_PARTIAL 0
#endif

#ifndef CONFIG_CRC
#define CONFIG_CRC 0
#endif

#ifndef CONFIG_EDAC
#define CONFIG_EDAC 0
#endif

#ifndef CONFIG_BLOCK
#define CONFIG_BLOCK 100
#endif

#ifndef CONFIG_DCM_FIFO
#define CONFIG_DCM_FIFO 0
#endif

#ifndef CONFIG_FIFO_DEPTH
#define CONFIG_FIFO_DEPTH 9
#endif

#if defined CONFIG_DPR_FIFO64
#define CFG_DPRFIFO 6
#elif defined CONFIG_DPR_FIFO128
#define CFG_DPRFIFO 7
#elif defined CONFIG_DPR_FIFO256
#define CFG_DPRFIFO 8
#else
#define CFG_DPRFIFO 9
#endif


