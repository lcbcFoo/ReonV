/* MDH WCET BENCHMARK SUITE */
/*
 * Changes: CS 2006/05/19: Changed loop bound from constant to variable.
 */

 #ifdef TEST
 #include "../mini_printf.h"
 #include "../posix_c.h"
 #else
 #include <stdio.h>
 #endif


int fac (int n)
{
  if (n == 0)
     return 1;
  else
     return (n * fac (n-1));
}

int main (void)
{
  int i;
  int s = 0;
  volatile int n;

  n = 10;
  for (i = 0;  i <= n; i++)
      s += fac (i);

#ifdef TEST
  if(s == 4037914){
      i = 1;
      memcpy(out_mem, &i, sizeof(int));
      return 0;
  }
  i = 0;
  memcpy(out_mem, &i, sizeof(int));
#endif
  return (s);
}
