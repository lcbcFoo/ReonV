#include "gptimer.h"

main()

{
  int addr=0x80000300;
  struct gptimer *lr = (struct gptimer *) addr;

  report_start();
//gptimer_test(0x80000300, 8);

leon3_test(1, 0x80000200, 0);

//LEON3_BYPASS_STORE_PA(0x80000338, 0);
//LEON3_BYPASS_STORE_PA(0x80000334, 0xf);
//LEON3_BYPASS_STORE_PA(0x80000338, 0x4);
//LEON3_BYPASS_STORE_PA(0x80000338, 0x9);
lr->timer[2].control = 0;
lr->timer[2].reload = 0xf;
lr->timer[2].control = 0x4;
lr->timer[2].control = 0x9;

irqtest(0x80000200);
apbuart_test(0x80000100);

//  base_test();
//  svgactrl_test(0x80000600, 1, 0, 0x40200000, -1, 0, 0);
//  greth_test(0x80000e00);

/*
  spw_test(0x80100A00);
  spw_test(0x80100B00);
  spw_test(0x80100C00);
*/

//  grusbhc_test(0x80000d00, 0xfffa0000, 0, 0);
  /* Delay end of testing if GRUSB_DCL (with real timing) is to be tested.
     The core needs about 4 ms of simulation time to get into a running
           state. After that the amount of simulation time needed depends on how
     much data that is transfered. */
/*    for (i = 0; i < 140000; i++) */
/*      ; */

  report_end();
}
