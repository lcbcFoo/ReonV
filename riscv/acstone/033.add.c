/**
 * @file      033.add.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function that uses signed and unsigned int adds.
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
  
  signed int a,b,c;
  signed int d; 
  unsigned int ua,ub,uc;
  unsigned int ud;

  a=0x0000FFFF;
  b=0xFFFF0000;
  c=a+b;
  /* Before c must be -1 */ c=0;

  a=0xFFFFFFEC;
  b=0xFFFFFFE2;
  c=a+b;
  /* Before c must be -50 */ c=0;

  a=0xFFFFFFFE;
  b=0x00000002;
  c=a+b;
  /* Before c must be 0 */ c=0;

  a=0x0000000A;
  b=0xFFFFFFFB;
  c=a+b;
  /* Before c must be 5 */ c=0;

  a=0x00000005;
  b=0xFFFFFFF6;
  c=a+b;
  /* Before c must be -5 */ c=0;

  a=0x0F0F0F0F;
  b=0xF0F0F0F0;
  c=a+b;
  /* Before c must be -1 */ c=0;

  a=0xAAAAAAAA;
  b=0x55555555;
  c=a+b;
  /* Before c must be -1 */ c=0;

  d=0;
  d+=1;
  d+=2;
  d+=3;
  d+=4;
  d+=5;
  /* Before d must be 15 */ d=0;


  ua=0x0000FFFF;
  ub=0xFFFF0000;
  uc=ua+ub;
  /* Before uc must be 4294967295 */ uc=0;

  ua=0xFFFFFFEC;
  ub=0xFFFFFFE2;
  uc=ua+ub;
  /* Before uc must be 4294967246 */ uc=0;

  ua=0xFFFFFFFE;
  ub=0x00000002;
  uc=ua+ub;
  /* Before uc must be 0 */ uc=0;

  ua=0x0000000A;
  ub=0xFFFFFFFB;
  uc=ua+ub;
  /* Before uc must be 5 */ uc=0;

  ua=0x00000005;
  ub=0xFFFFFFF6;
  uc=ua+ub;
  /* Before uc must be 4294967291 */ uc=0;

  ua=0x0F0F0F0F;
  ub=0xF0F0F0F0;
  uc=ua+ub;
  /* Before uc must be 4294967295 */ uc=0;

  ua=0xAAAAAAAA;
  ub=0x55555555;
  uc=ua+ub;
  /* Before uc must be 4294967295 */ uc=0;

  ud=0;
  ud+=1;
  ud+=2;
  ud+=3;
  ud+=4;
  ud+=5;
  /* Before ud must be 15 */ ud=0;

  d=15;
  d+=0xFFFFFFFF;
  d+=0xFFFFFFFE;
  d+=0xFFFFFFFD;
  d+=0xFFFFFFFC;
  d+=0xFFFFFFFB;
  /* Before d must be 0 */ d=0;

  ud=15;
  ud+=0xFFFFFFFF;
  ud+=0xFFFFFFFE;
  ud+=0xFFFFFFFD;
  ud+=0xFFFFFFFC;
  ud+=0xFFFFFFFB;
  /* Before ud must be 0 */ ud=0;

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
