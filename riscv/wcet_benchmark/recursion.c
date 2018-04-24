/* $Id: recursion.c,v 1.2 2005/04/04 11:34:58 csg Exp $ */



/* Generate an example of recursive code, to see  *

 * how it can be modeled in the scope graph.      */

 #ifdef TEST
 #include "../mini_printf.h"
 #include "../posix_c.h"
 #else
 #include <stdio.h>
 #endif

/* self-recursion  */

int fib(int i)

{

  if(i==1)

    return 1;

  if(i==2)

    return 1;

  return fib(i-1) + fib(i-2);

}


extern volatile int In;



void main(void)

{

  int In = fib(25);

  #ifdef TEST
    if(In == 75025){
      int i = 1;
      memcpy(out_mem, &i, sizeof(int));
      return;
    }
    int i = 0;
    memcpy(out_mem, &i, sizeof(int));
  #endif

}
