/**
 * @file      031.add.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function that uses signed and unsigned char adds.
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
  
  signed char a,b,c;
  signed char d; 
  unsigned char ua,ub,uc;
  unsigned char ud;

  a=0x0A;
  b=0x14;
  c=a+b;
  /* Before c must be 30 */ c=0;

  a=0xEC;
  b=0xE2;
  c=a+b;
  /* Before c must be -50 */ c=0;

  a=0xFE;
  b=0x02;
  c=a+b;
  /* Before c must be 0 */ c=0;

  a=0x0A;
  b=0xFB;
  c=a+b;
  /* Before c must be 5 */ c=0;

  a=0x05;
  b=0xF6;
  c=a+b;
  /* Before c must be -5 */ c=0;

  a=0x0F;
  b=0xF0;
  c=a+b;
  /* Before c must be -1 */ c=0;

  a=0xAA;
  b=0x55;
  c=a+b;
  /* Before c must be -1 */ c=0;

  d=0;
  d+=1;
  d+=2;
  d+=3;
  d+=4;
  d+=5;
  /* Before d must be 15 */ d=0;


  ua=0x0A;
  ub=0x14;
  uc=ua+ub;
  /* Before uc must be 30 */ uc=0;

  ua=0xEC;
  ub=0xE2;
  uc=ua+ub;
  /* Before uc must be 206 */ uc=0;

  ua=0xFE;
  ub=0x02;
  uc=ua+ub;
  /* Before uc must be 0 */ uc=0;

  ua=0x0A;
  ub=0xFB;
  uc=ua+ub;
  /* Before uc must be 5 */ uc=0;

  ua=0x05;
  ub=0xF6;
  uc=ua+ub;
  /* Before uc must be 251 */ uc=0;

  ua=0x0F;
  ub=0xF0;
  uc=ua+ub;
  /* Before uc must be 255 */ uc=0;

  ua=0xAA;
  ub=0x55;
  uc=ua+ub;
  /* Before uc must be 255 */ uc=0;

  ud=0;
  ud+=1;
  ud+=2;
  ud+=3;
  ud+=4;
  ud+=5;
  /* Before ud must be 15 */ ud=0;

  d=15;
  d+=0xFF;
  d+=0xFE;
  d+=0xFD;
  d+=0xFC;
  d+=0xFB;
  /* Before d must be 0 */ d=0;

  ud=15;
  ud+=0xFF;
  ud+=0xFE;
  ud+=0xFD;
  ud+=0xFC;
  ud+=0xFB;
  /* Before ud must be 0 */ ud=0;

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
