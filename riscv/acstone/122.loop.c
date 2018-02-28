/**
 * @file      122.loop.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:21 -0300
 * @brief     It is a simple main function that uses for loops.
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
  
  unsigned long long int cont;

  unsigned char a;
  signed char b;
  unsigned short int c;
  signed short int d;
  unsigned int e;
  signed int f;
  unsigned long long int g;
  signed long long int h;
  
  cont=0;
  
  for(a=0;a<5;a++)
    cont++;
  /* Before a must be 5 and cont 5 */ a=0;
  
  for(b=0;b<5;b++)
    cont++;
  /* Before b must be 5 and cont 10 */ b=0;

  for(c=0;c<5;c++)
    cont++;
  /* Before c must be 5 and cont 15 */ c=0;

  for(d=0;d<5;d++)
    cont++;
  /* Before d must be 5 and cont 20 */ d=0;

  for(e=0;e<5;e++)
    cont++;
  /* Before e must be 5 and cont 25 */ e=0;

  for(f=0;f<5;f++)
    cont++;
  /* Before f must be 5 and cont 30 */ f=0;

  for(g=0;g<5;g++)
    cont++;
  /* Before g must be 5 and cont 35 */ g=0;

  for(h=0;h<5;h++)
    cont++;
  /* Before h must be 5 and cont 40 */ h=0;

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
