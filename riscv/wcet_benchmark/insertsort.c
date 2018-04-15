/* $Id: insertsort.c,v 1.2 2005/04/04 11:34:58 csg Exp $ */

/*************************************************************************/
/*                                                                       */
/*   SNU-RT Benchmark Suite for Worst Case Timing Analysis               */
/*   =====================================================               */
/*                              Collected and Modified by S.-S. Lim      */
/*                                           sslim@archi.snu.ac.kr       */
/*                                         Real-Time Research Group      */
/*                                        Seoul National University      */
/*                                                                       */
/*                                                                       */
/*        < Features > - restrictions for our experimental environment   */
/*                                                                       */
/*          1. Completely structured.                                    */
/*               - There are no unconditional jumps.                     */
/*               - There are no exit from loop bodies.                   */
/*                 (There are no 'break' or 'return' in loop bodies)     */
/*          2. No 'switch' statements.                                   */
/*          3. No 'do..while' statements.                                */
/*          4. Expressions are restricted.                               */
/*               - There are no multiple expressions joined by 'or',     */
/*                'and' operations.                                      */
/*          5. No library calls.                                         */
/*               - All the functions needed are implemented in the       */
/*                 source file.                                          */
/*                                                                       */
/*                                                                       */
/*************************************************************************/
/*                                                                       */
/*  FILE: insertsort.c                                                   */
/*  SOURCE : Public Domain Code                                          */
/*                                                                       */
/*  DESCRIPTION :                                                        */
/*                                                                       */
/*     Insertion sort for 10 integer numbers.                            */
/*     The integer array a[] is initialized in main function.            */
/*                                                                       */
/*  REMARK :                                                             */
/*                                                                       */
/*  EXECUTION TIME :                                                     */
/*                                                                       */
/*                                                                       */
/*************************************************************************/


#ifdef TEST
    #include "../mini_printf.h"
    #include "../posix_c.h"
#else
    #include <stdio.h>
#endif


unsigned int a[11];

int main()
{
  int  i,j, temp;

  a[0] = 0;   /* assume all data is positive */
  a[1] = 11; a[2]=10;a[3]=9; a[4]=8; a[5]=7; a[6]=6; a[7]=5;
  a[8] =4; a[9]=3; a[10]=2;
  i = 2;
  while(i <= 10){

      j = i;

      while (a[j] < a[j-1])
      {
	temp = a[j];
	a[j] = a[j-1];
	a[j-1] = temp;
	j--;
      }
      i++;
    }

#ifdef TEST
    for(int i = 0; i < 11 - 1; i++){
        if(a[i] > a[i + 1]){
            j = 0;
            memcpy(out_mem, &j, sizeof(int));
            return 0;
        }
    }

    j = 1;
    memcpy(out_mem, &j, sizeof(int));
#endif

    return 0;
}
