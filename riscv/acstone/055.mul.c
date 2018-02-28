/**
 * @file      055.mul.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:21 -0300
 * @brief     It is a simple main function that uses signed int multiplication.
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

  signed int a,b;
  signed long long int c;
  
  a=0x00000002;
  b=0x00000004;
  c=(signed long long int)(a)*(signed long long int)(b);
  /* Before c must be 8 */ c=0;

  a=0xFFFFFFFF;
  b=0xFFFFFFFF;
  c=(signed long long int)(a)*(signed long long int)(b);
  /* Before c must be 1 */ c=0;
  
  a=0xFFFFFFFF;
  b=0x00000001;
  c=(signed long long int)(a)*(signed long long int)(b);
  /* Before c must be -1 */ c=0;
  
  a=0xFFFFFFFF;
  b=0x0000000A;
  c=(signed long long int)(a)*(signed long long int)(b);
  /* Before c must be -10 */ c=0;

  a=0xFFFFFFFE;
  b=0xFFFFFFFC;
  c=(signed long long int)(a)*(signed long long int)(b);
  /* Before c must be 8 */ c=0;

  a=0x0000000A;
  b=0x0000000B;
  c=(signed long long int)(a)*(signed long long int)(b);
  /* Before c must be 110 */ c=0;

  a=0xFFFFFFF6;
  b=0x0000000B;
  c=(signed long long int)(a)*(signed long long int)(b);
  /* Before c must be -110 */ c=0;

  a=0x0000F000;
  b=0x0000F001;
  c=(signed long long int)(a)*(signed long long int)(b);
  /* Before c must be 3774935040 */ c=0;

  a=0x55555555;
  b=0x33333333;
  c=(signed long long int)(a)*(signed long long int)(b);
  /* Before c must be 1229782937674641135 */ c=0;

  a=0x00005353;
  b=0x00008000;
  c=(signed long long int)(a)*(signed long long int)(b);
  /* Before c must be 698974208 */ c=0;

  a=0xFFFFF000;
  b=0xFFFFF001;
  c=(signed long long int)(a)*(signed long long int)(b);
  /* Before c must be 16773120 */ c=0;

  a=0x00005555;
  b=0x33330000;
  c=(signed long long int)(a)*(signed long long int)(b);
  /* Before c must be 18764425789440 */ c=0;

  a=0x53535353;
  b=0x80008000;
  c=(signed long long int)(a)*(signed long long int)(b);
  /* Before c must be -3002071363408527360 */ c=0;


  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
