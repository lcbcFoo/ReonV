/**
 * @file      064.div.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:21 -0300
 * @brief     It is a simple main function that uses unsigned short int division.
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
  
  unsigned short int a,b,c;
  
  a=0xFFFF;
  b=0x0001;
  c=a/b;
  /* Before c must be 65535 */ c=0;
  
  a=0x000F;
  b=0x0003;
  c=a/b;
  /* Before c must be 5 */ c=0;

  a=0xAAAA;
  b=0x5555;
  c=a/b;
  /* Before c must be 2 */ c=0;
  
  a=0x7FFF;
  b=0xFFFF;
  c=a/b;
  /* Before c must be 0 */ c=0;

  a=0x0000;
  b=0x8000;
  c=a/b;
  /* Before c must be 0 */ c=0;

  a=0x0030;
  b=0x0005;
  c=a/b;
  /* Before c must be 9 */ c=0;

  a=0xFFFF;
  b=0xFFFF;
  c=a/b;
  /* Before c must be 1 */ c=0;

  a=0xFFFE;
  b=0x0010;
  c=a/b;
  /* Before c must be 4095 */ c=0;

  a=0x0020;
  b=0xFFFE;
  c=a/b;
  /* Before c must be 0 */ c=0;

  a=0x0000;
  b=0xFFFF;
  c=a/b;
  /* Before c must be 0 */ c=0;

  a=0x78;
  c=a/5;
  c=c/4;
  c=c/3;
  c=c/2;
  /* Before c must be 1 */ c=0;
  
  a=0x10;
  c=a/0xFFFF;
  /* Before c must be 0 */ c=0;

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
