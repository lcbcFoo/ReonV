/*
 * file: leon_tsc
 *
 * test for LEON3/4 time stamp counter (available in %asr22 and %asr23).
 *
 * If DSU interface is available from processor then this can be used
 * to test counter bits > 32. In this case, the dsu_addr argument should
 * be set to the base address of the DSU.
 *
 * Tests assumes that it is run in the first 2^32 clock cycles.
 *
 */

#include "testmod.h"

int leon_tsc(unsigned int dsu_addr)
{

	unsigned int tmp[4];
        volatile unsigned int *ptr = (unsigned int *)dsu_addr;
        char free_running = 0;

        asm volatile("mov %%asr22, %0"
                     : "=r"(tmp[0])
                     : 
                     );

        asm volatile("mov %%asr23, %0"
                     : "=r"(tmp[1])
                     : 
                     );

        asm volatile("mov %%asr22, %0"
                     : "=r"(tmp[2])
                     : 
                     );

        asm volatile("mov %%asr23, %0"
                     : "=r"(tmp[3])
                     : 
                     );


        /* Counter is running by default when there is a DSU present, that is not clock gated off */
        if (tmp[1] || tmp[3]) {
           free_running = 1;
        }

        if (tmp[0] != 0x80000000UL || tmp[2] != 0x80000000UL) {
           fail(2);
        }

        /* Enable counter */
        tmp[0] =  ~(1 << 31);
        asm volatile("mov %0, %%asr22; nop; nop; nop "
                     :
                     : "r"(tmp[0])
        );

        /* Read both counters */
        asm volatile("mov %%asr22, %0"
                     : "=r"(tmp[0])
                     : 
                     );

        asm volatile("mov %%asr23, %0"
                     : "=r"(tmp[1])
                     : 
                     );

        asm volatile("mov %%asr22, %0"
                     : "=r"(tmp[2])
                     : 
                     );

        asm volatile("mov %%asr23, %0"
                     : "=r"(tmp[3])
                     : 
                     );
        
        /* %asr22 should not change (less than 2^32 clock cycles should have passed) */
        if (tmp[0] != tmp[2]) {
           fail(3);
        }

        /* %asr23 should have incremented */
        if (tmp[1] == tmp[3]) {
           fail(4);
        }
        
        /* Disable counter */
        tmp[0] = (1 << 31);
        asm volatile("mov %0, %%asr22; nop; nop; nop "
                     :
                     : "r"(tmp[0])
        );

        /* Read both counters */
        asm volatile("mov %%asr22, %0"
                     : "=r"(tmp[0])
                     : 
                     );

        asm volatile("mov %%asr23, %0"
                     : "=r"(tmp[1])
                     : 
                     );

        asm volatile("mov %%asr22, %0"
                     : "=r"(tmp[2])
                     : 
                     );

        asm volatile("mov %%asr23, %0"
                     : "=r"(tmp[3])
                     : 
                     );

        /* %asr22 should not change */
        if (tmp[0] != tmp[2]) {
           fail(5);
        }

        /* %asr23 should not change, unless always running */
        if (!free_running && tmp[1] != tmp[3]) {
           fail(6);
        }


        if (dsu_addr)  {
           /* ptr[2] = DSU time tag counter */
           /* Test bits >= 32 of counter */
           if (!free_running && ptr[2] != tmp[1]) {
              fail(7);
           }

           ptr[2] = ~0;


           /* Allow some time for write to propagate */
           asm volatile("nop; nop; nop; nop; nop\n");

           asm volatile("mov %%asr23, %0"
                     : "=r"(tmp[1])
                     : 
                     );

           if (!free_running && ptr[2] != tmp[1]) {
              fail(8);
           }

           /* Enable counter */
           tmp[0] =  ~(1 << 31);
           asm volatile("mov %0, %%asr22; nop; nop; nop "
                        :
                        : "r"(tmp[0])
                        );
           /* Disable counter */
           tmp[0] = (1 << 31);
           asm volatile("mov %0, %%asr22; nop; nop; nop "
                        :
                        : "r"(tmp[0])
                        );
           
           
           asm volatile("mov %%asr22, %0"
                        : "=r"(tmp[0])
                        : 
                        );

           asm volatile("mov %%asr23, %0"
                        : "=r"(tmp[1])
                        : 
                        );

           
           /* both counters should have changed */
           if (tmp[0] == tmp[2]) {
              fail(9);
           }
           if (tmp[1] == tmp[3]) {
              fail(10);
           }


           /* Check that DSU register i/f value matches */
           if (!free_running && ptr[2] != tmp[1]) {
              fail(11);
           }
        }

        return 0;
}

int leon4_tsc(unsigned int dsu_addr)
{
   return leon_tsc(dsu_addr);
}
