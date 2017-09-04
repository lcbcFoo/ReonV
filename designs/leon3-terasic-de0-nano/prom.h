#define MCFG1 0x10380033
#define MCFG2 0xe6A06e60
//#define MCFG2 0xe6A00e60
#define MCFG3 0x000ff000
#define ASDCFG 0xfff00100
//below 4 identical to LMR and setting
//#define DSDCFG 0x88980184 //8 burst cas 2 (used when generic pageburst set to 2)
//#define DSDCFG 0x889a0184 //pageburst cas 2 (used when generic pageburst set to 2)
//#define DSDCFG 0x8c980184 //8 burst cas3 (used when generic pageburst set to 2)
//#define DSDCFG 0x8c9a0184 //pageburst cas 3 (used when generic pageburst set to 2)
//below 4 probed by grmon
//#define DSDCFG 0x88800184 //8 burst cas 2 (used when generic pageburst set to 2)
//#define DSDCFG 0x8c800184 //8 burst cas 3 (used when generic pageburst set to 2)
//#define DSDCFG 0x88820184 //pageburst cas 2 (only used when pageburst generic set to 2)
//#define DSDCFG 0x8c820184 //pageburst cas 3 (only used when pageburst generic set to 2)
//#define DSDCFG 0xe4806e60 //bsize 001, csize 00, cas delay 3
#define DSDCFG 0xe0806e60 //bsize 001, csize 00, cas delay 2
//#define DSDCFG 0xe5806e60 /config for old ba satting bsize 011, csize 00
//#define DSDCFG 0xe6A06e60 / orginal
#define L2MCTRLIO 0x80000000
#define IRQCTRL   0x80000200
#define RAMSTART  0x40000000
#define RAMSIZE   0x00400000
//#define RAMSIZE   0x00200000 //original config 2 meg
#define STACKSIZE 0x00002000
