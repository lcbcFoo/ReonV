/**
 * @file      034.add.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:21 -0300
 * @brief     It is a simple main function that uses signed and unsigned long long int adds.
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

/* The file begin.h is included if compiler flag -DBEGINCODE is used */
#ifdef BEGINCODE
#include "begin.h"
#endif

int main() {
  
  signed long long int a,b,c;
  signed long long int d; 
  unsigned long long int ua,ub,uc;
  unsigned long long int ud;

  a=0x00000000FFFFFFFFLL;
  b=0xFFFFFFFF00000000LL;
  c=a+b;
  /* Before c must be -1 */ c=0;

  a=0xFFFFFFFFFFFFFFECLL;
  b=0xFFFFFFFFFFFFFFE2LL;
  c=a+b;
  /* Before c must be -50 */ c=0;

  a=0xFFFFFFFFFFFFFFFELL;
  b=0x0000000000000002LL;
  c=a+b;
  /* Before c must be 0 */ c=0;

  a=0x000000000000000ALL;
  b=0xFFFFFFFFFFFFFFFBLL;
  c=a+b;
  /* Before c must be 5 */ c=0;

  a=0x0000000000000005LL;
  b=0xFFFFFFFFFFFFFFF6LL;
  c=a+b;
  /* Before c must be -5 */ c=0;

  a=0xF0F0F0F0F0F0F0F0LL;
  b=0x0F0F0F0F0F0F0F0FLL;
  c=a+b;
  /* Before c must be -1 */ c=0;

  a=0xAAAAAAAAAAAAAAAALL;
  b=0x5555555555555555LL;
  c=a+b;
  /* Before c must be -1 */ c=0;

  d=0;
  d+=1;
  d+=2;
  d+=3;
  d+=4;
  d+=5;
  /* Before d must be 15 */ d=0;


  ua=0x00000000FFFFFFFFULL;
  ub=0xFFFFFFFF00000000ULL;
  uc=ua+ub;
  /* Before uc must be 18446744073709551615 */ uc=0;

  ua=0xFFFFFFFFFFFFFFECULL;
  ub=0xFFFFFFFFFFFFFFE2ULL;
  uc=ua+ub;
  /* Before uc must be 18446744073709551566 */ uc=0;

  ua=0xFFFFFFFFFFFFFFFEULL;
  ub=0x0000000000000002ULL;
  uc=ua+ub;
  /* Before uc must be 0 */ uc=0;

  ua=0x000000000000000AULL;
  ub=0xFFFFFFFFFFFFFFFBULL;
  uc=ua+ub;
  /* Before uc must be 5 */ uc=0;

  ua=0x0000000000000005ULL;
  ub=0xFFFFFFFFFFFFFFF6ULL;
  uc=ua+ub;
  /* Before uc must be 18446744073709551611 */ uc=0;

  ua=0x0F0F0F0F0F0F0F0FULL;
  ub=0xF0F0F0F0F0F0F0F0ULL;
  uc=ua+ub;
  /* Before uc must be 18446744073709551615 */ uc=0;

  ua=0xAAAAAAAAAAAAAAAAULL;
  ub=0x5555555555555555ULL;
  uc=ua+ub;
  /* Before uc must be 18446744073709551615 */ uc=0;

  ud=0;
  ud+=1;
  ud+=2;
  ud+=3;
  ud+=4;
  ud+=5;
  /* Before ud must be 15 */ ud=0;

  d=15;
  d+=0xFFFFFFFFFFFFFFFFULL;
  d+=0xFFFFFFFFFFFFFFFEULL;
  d+=0xFFFFFFFFFFFFFFFDULL;
  d+=0xFFFFFFFFFFFFFFFCULL;
  d+=0xFFFFFFFFFFFFFFFBULL;
  /* Before d must be 0 */ d=0;

  ud=15;
  ud+=0xFFFFFFFFFFFFFFFFULL;
  ud+=0xFFFFFFFFFFFFFFFEULL;
  ud+=0xFFFFFFFFFFFFFFFDULL;
  ud+=0xFFFFFFFFFFFFFFFCULL;
  ud+=0xFFFFFFFFFFFFFFFBULL;
  /* Before ud must be 0 */ ud=0;

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
