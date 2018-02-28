/**
 * @file      132.call.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function that uses indirect calls functions.
 *
 * @attention Copyright (C) 2002-2006 --- The ArchC Team
 * 
 * This program is free software; you can redistribute it and/or modify 
 * it under the terms of the GNU General Public License as published by 
 * the Free Software Foundation; either version 2 of the License, or 
 * (at your option) any later version. 
 * 
 * This program is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 * GNU General Public License for more details. 
 * 
 * You should have received a copy of the GNU General Public License 
 * along with this program; if not, write to the Free Software 
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

/* Declarations */
signed char funcA(signed char input);
signed char funcB(signed char input);
signed char funcC(signed char input);
signed char funcD(signed char input);
signed char funcE(signed char input);
signed char funcF(signed char input);
signed char funcG(signed char input);
signed char funcH(signed char input);

/* The file begin.h is included if compiler flag -DBEGINCODE is used */
#ifdef BEGINCODE
#include "begin.h"
#endif

int main() {
  
  signed char tmp=0;
  tmp=funcA(-1);
  /* Before tmp must be -1 */ tmp=0;  
  
  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif

unsigned long long int count=0;

signed char funcA(signed char input) {
  signed int a=-2;
  funcB(input);
  count++;
  a++;
  /* Before a must be -1 */ return input;
} 



signed char funcB(signed char input) {
  unsigned int b=0;
  funcC(input);
  count++;
  b++;
  /* Before b must be 1 */ return input;
}



signed char funcC(signed char input) {
  signed short int c=-1;
  funcD(input);
  count++;
  c++;
  /* Before c must be 0 */ return input;
} 



signed char funcD(signed char input) {
  unsigned short int d=9;
  funcE(input);
  count++;
  d++;
  /* Before d must be 10 */ return input;
}



signed char funcE(signed char input) {
  signed int e=-1;
  funcF(input);
  count++;
  e++;
  /* Before e must be 0 */ return input;
} 



signed char funcF(signed char input) {
  unsigned int f=14;
  funcG(input);
  count++;
  f++;
  /* Before f must be 15 */ return input;
}



signed char funcG(signed char input) {
  signed long long int g=-2;
  funcH(input);
  count++;
  g++;
  /* Before g must be -1 */ return input;
} 



signed char funcH(signed char input) {
  unsigned long long int h=1;
  count++;
  h++;

  /* Before h must be 2 */ return input;
}

