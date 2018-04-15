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
/*  FILE: bs.c                                                           */
/*  SOURCE : Public Domain Code                                          */
/*                                                                       */
/*  DESCRIPTION :                                                        */
/*                                                                       */
/*     Binary search for the array of 15 integer elements.               */
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


struct DATA {
  int  key;
  int  value;
}  ;

#ifdef DEBUG
	int cnt1;
#endif

int binary_search(struct DATA data[],int x);

void main()
{

    struct DATA data[30] = {
             {1, 100},
    	     {5,200},
    	     {6, 300},
    	     {7, 700},
    	     {8, 900},
    	     {9, 250},
    	     {10, 400},
    	     {11, 600},
    	     {12, 800},
    	     {13, 1500},
    	     {14, 1200},
    	     {15, 110},
    	     {16, 140},
    	     {17, 133},
    	     {18, 10},
             {19, 1040},
             {20,2040},
             {21, 350},
             {22, 7410},
             {23, 90043},
             {24, 25340},
             {25, 4310},
             {26, 60970},
             {27, 8780},
             {28, 6500},
             {29, 210},
             {30, 1761},
             {31, 14123},
             {32, 15433},
             {33, 164} };
	int res = binary_search(data, 29);

#ifdef TEST
    if(res == 210){
        int ok = 1;
        memcpy(out_mem, &ok, sizeof(int));
        return;
    }
    int ok = 0;
    memcpy(out_mem, &ok, sizeof(int));
#endif
}

int binary_search(struct DATA data[], int x)
{
  int fvalue, mid, up, low ;

  low = 0;
  up = 29;
  fvalue = -1 /* all data are positive */ ;
  while (low <= up) {
    mid = (low + up) >> 1;
    if ( data[mid].key == x ) {  /*  found  */
      up = low - 1;
      fvalue = data[mid].value;
    }
    else  /* not found */
      if ( data[mid].key > x ) 	{
	up = mid - 1;
      }
      else   {
          low = mid + 1;
      }

  }
  return fvalue;
}
