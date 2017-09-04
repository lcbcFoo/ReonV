
#if defined CONFIG_FREQ60
#define CFG_SYS_FREQ_DIV 20
#elif defined CONFIG_FREQ75
#define CFG_SYS_FREQ_DIV 16
#elif defined CONFIG_FREQ80
#define CFG_SYS_FREQ_DIV 15
#elif defined CONFIG_FREQ100
#define CFG_SYS_FREQ_DIV 12
#else
#define CFG_SYS_FREQ_DIV 10
#endif
