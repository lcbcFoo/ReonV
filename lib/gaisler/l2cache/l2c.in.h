#ifndef CONFIG_L2_ENABLE
#define CONFIG_L2_ENABLE 0
#endif

#if defined CONFIG_L2_ASSO1
#define CFG_L2_ASSO 1
#elif defined CONFIG_L2_ASSO2
#define CFG_L2_ASSO 2
#elif defined CONFIG_L2_ASSO3
#define CFG_L2_ASSO 3
#elif defined CONFIG_L2_ASSO4
#define CFG_L2_ASSO 4
#else
#define CFG_L2_ASSO 1
#endif

#if defined CONFIG_L2_SZ1
#define CFG_L2_SZ 1
#elif defined CONFIG_L2_SZ2
#define CFG_L2_SZ 2
#elif defined CONFIG_L2_SZ4
#define CFG_L2_SZ 4
#elif defined CONFIG_L2_SZ8
#define CFG_L2_SZ 8
#elif defined CONFIG_L2_SZ16
#define CFG_L2_SZ 16
#elif defined CONFIG_L2_SZ32
#define CFG_L2_SZ 32
#elif defined CONFIG_L2_SZ64
#define CFG_L2_SZ 64
#elif defined CONFIG_L2_SZ128
#define CFG_L2_SZ 128
#elif defined CONFIG_L2_SZ256
#define CFG_L2_SZ 256
#elif defined CONFIG_L2_SZ512
#define CFG_L2_SZ 512
#else
#define CFG_L2_SZ 1
#endif

#if defined CONFIG_L2_LINE64
#define CFG_L2_LINE 64
#else
#define CFG_L2_LINE 32
#endif

#ifndef CONFIG_L2_HPROT
#define CONFIG_L2_HPROT 0
#endif

#ifndef CONFIG_L2_PEN
#define CONFIG_L2_PEN 0
#endif

#ifndef CONFIG_L2_WT
#define CONFIG_L2_WT 0
#endif

#ifndef CONFIG_L2_RAN
#define CONFIG_L2_RAN 0
#endif
#ifndef CONFIG_L2_MAP
#define CONFIG_L2_MAP 00F0
#endif

#ifndef CONFIG_L2_SHARE
#define CONFIG_L2_SHARE 0
#endif

#ifndef CONFIG_L2_MTRR
#define CONFIG_L2_MTRR 0
#endif

#ifndef CONFIG_L2_EDAC
#define CONFIG_L2_EDAC 0
#endif

#ifndef CONFIG_L2_AXI
#define CONFIG_L2_AXI 0
#endif
