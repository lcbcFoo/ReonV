/**
 * @file      065.div.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function that uses signed int division.
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
  
  a=0xFFFFFFFF;
  b=0x00000001;
  c=a/b;
  /* Before c must be -1 */ c=0;
  
  a=0x0000000F;
  b=0x00000003;
  c=a/b;
  /* Before c must be 5 */ c=0;

  a=0xAAAAAAAA;
  b=0x55555555;
  c=a/b;
  /* Before c must be -1 */ c=0;
  
  a=0x7FFFFFFF;
  b=0xFFFFFFFF;
  c=a/b;
  /* Before c must be -2147483647 */ c=0;

  a=0x00000000;
  b=0x80000000;
  c=a/b;
  /* Before c must be 0 */ c=0;

  a=0x00000030;
  b=0x00000005;
  c=a/b;
  /* Before c must be 9 */ c=0;

  a=0xFFFFFFFF;
  b=0xFFFFFFFF;
  c=a/b;
  /* Before c must be 1 */ c=0;

  a=0xFFFFFFFE;
  b=0x00000010;
  c=a/b;
  /* Before c must be 0 */ c=0;

  a=0x00000020;
  b=0xFFFFFFFE;
  c=a/b;
  /* Before c must be -16 */ c=0;

  a=0x00000000;
  b=0xFFFFFFFF;
  c=a/b;
  /* Before c must be 0 */ c=0;

  a=0x00000078;
  c=a/5;
  c=c/4;
  c=c/3;
  c=c/2;
  /* Before c must be 1 */ c=0;
  
  a=0x10000000;
  c=a/(-1);
  /* Before c must be -268435456 */ c=0;

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
