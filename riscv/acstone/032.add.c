/**
 * @file      032.add.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:21 -0300
 * @brief     It is a simple main function that uses signed and unsigned short int adds.
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
  
  signed short int a,b,c;
  signed short int d; 
  unsigned short int ua,ub,uc;
  unsigned short int ud;

  a=0x00FF;
  b=0xFF00;
  c=a+b;
  /* Before c must be -1 */ c=0;

  a=0xFFEC;
  b=0xFFE2;
  c=a+b;
  /* Before c must be -50 */ c=0;

  a=0xFFFE;
  b=0x0002;
  c=a+b;
  /* Before c must be 0 */ c=0;

  a=0x000A;
  b=0xFFFB;
  c=a+b;
  /* Before c must be 5 */ c=0;

  a=0x0005;
  b=0xFFF6;
  c=a+b;
  /* Before c must be -5 */ c=0;

  a=0x0F0F;
  b=0xF0F0;
  c=a+b;
  /* Before c must be -1 */ c=0;

  a=0xAAAA;
  b=0x5555;
  c=a+b;
  /* Before c must be -1 */ c=0;

  d=0;
  d+=1;
  d+=2;
  d+=3;
  d+=4;
  d+=5;
  /* Before d must be 15 */ d=0;


  ua=0x00FF;
  ub=0xFF00;
  uc=ua+ub;
  /* Before uc must be 65535 */ uc=0;

  ua=0xFFEC;
  ub=0xFFE2;
  uc=ua+ub;
  /* Before uc must be 65486 */ uc=0;

  ua=0xFFFE;
  ub=0x0002;
  uc=ua+ub;
  /* Before uc must be 0 */ uc=0;

  ua=0x000A;
  ub=0xFFFB;
  uc=ua+ub;
  /* Before uc must be 5 */ uc=0;

  ua=0x0005;
  ub=0xFFF6;
  uc=ua+ub;
  /* Before uc must be 65531 */ uc=0;

  ua=0x0F0F;
  ub=0xF0F0;
  uc=ua+ub;
  /* Before uc must be 65535 */ uc=0;

  ua=0xAAAA;
  ub=0x5555;
  uc=ua+ub;
  /* Before uc must be 65535 */ uc=0;

  ud=0;
  ud+=1;
  ud+=2;
  ud+=3;
  ud+=4;
  ud+=5;
  /* Before ud must be 15 */ ud=0;

  d=15;
  d+=0xFFFF;
  d+=0xFFFE;
  d+=0xFFFD;
  d+=0xFFFC;
  d+=0xFFFB;
  /* Before d must be 0 */ d=0;

  ud=15;
  ud+=0xFFFF;
  ud+=0xFFFE;
  ud+=0xFFFD;
  ud+=0xFFFC;
  ud+=0xFFFB;
  /* Before ud must be 0 */ ud=0;

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
