/**
 * @file      068.div.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:21 -0300
 * @brief     It is a simple main function that uses unsigned long long int division.
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
  
  signed long int a,b,c;
  
  a=0xFFFFFULL;
  b=0x00001ULL;
  c=a%-2;
  /* Before c must be -1 */ c=0;
  
  a=0xFFFFFULL;
  b=0x00003ULL;
  c=a%b;
  /* Before c must be 0 */ c=0;

  a=0xFFFFFULL;
  b=0x55555ULL;
  c=a%b;
  /* Before c must be -1 */ c=0;
  
  a=0xFFFFFULL;
  b=0xFFFFFULL;
  c=a%b;
  /* Before c must be 0 */ c=0;

  a=0xFFFFFULL;
  b=0x01000ULL;
  c=a%b;
  /* Before c must be 0 */ c=0;

  a=0xFFFFFULL;
  b=0x00005ULL;
  c=a%b;
  /* Before c must be 3 */ c=0;

  a=0xFFFFFULL;
  b=0xFFAFFULL;
  c=a%b;
  /* Before c must be 0 */ c=0;

  a=0xFFFFFULL;
  b=0x00010ULL;
  c=a%b;
  /* Before c must be -2 */ c=0;

  a=0xFFFFFULL;
  b=0xFFBBEULL;
  c=a%b;
  /* Before c must be 0 */ c=0;

  a=0xFFFFFULL;
  b=0xFCCCFULL;
  c=a%b;
  /* Before c must be 0 */ c=0;

  a=0x78;
  c=a%56;
  /* Before c must be 8 */ c=c%9;
  /* Before c must be 8 */ c=c%5;
  /* Before c must be 3 */ c=c%1;
  /* Before c must be 0 */ c=0;
  
  a=0xFFFFFULL;
  c=a%0xFFFFFULL;
  /* Before c must be 1152921504606846976 */ c=0;

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
