/**
 * @file      073.bool.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:21 -0300
 * @brief     It is a simple main function that uses int boolean operators.
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

  unsigned int a,b,c,d,e,f,g,h,i,j;
  
  a=0xFFFFFFFF;
  b=0xFFFFFFFF;
  c=a|b;
  /* Before c must be 4294967295 */ c=0;
  d=a&b;
  /* Before d must be 4294967295 */ d=0;
  e=a^b;
  /* Before e must be 0 */ e=0;
  f=~(a|b);
  /* Before f must be 0 */ f=0;
  g=~(a&b);
  /* Before g must be 0 */ g=0;
  h=~(a^b);
  /* Before h must be 4294967295 */ h=0;
  i=~a;
  /* Before i must be 0 */ i=0;
  j=~b;
  /* Before j must be 0 */ j=0;

  a=0x0F0F0F0F;
  b=0xF0F0F0F0;
  c=a|b;
  /* Before c must be 4294967295 */ c=0;
  d=a&b;
  /* Before d must be 0 */ d=0;
  e=a^b;
  /* Before e must be 4294967295 */ e=0;
  f=~(a|b);
  /* Before f must be 0 */ f=0;
  g=~(a&b);
  /* Before g must be 4294967295 */ g=0;
  h=~(a^b);
  /* Before h must be 0 */ h=0;
  i=~a;
  /* Before i must be 4042322160 */ i=0;
  j=~b;
  /* Before j must be 252645135 */ j=0;

  a=0xFFFFFFFF;
  b=0x00000000;
  c=a|b;
  /* Before c must be 4294967295 */ c=0;
  d=a&b;
  /* Before d must be 0 */ d=0;
  e=a^b;
  /* Before e must be 4294967295 */ e=0;
  f=~(a|b);
  /* Before f must be 0 */ f=0;
  g=~(a&b);
  /* Before g must be 4294967295 */ g=0;
  h=~(a^b);
  /* Before h must be 0 */ h=0;
  i=~a;
  /* Before i must be 0 */ i=0;
  j=~b;
  /* Before j must be 4294967295 */ j=0;

  a=0x55555555;
  b=0xAAAAAAAA;
  c=a|b;
  /* Before c must be 4294967295 */ c=0;
  d=a&b;
  /* Before d must be 0 */ d=0;
  e=a^b;
  /* Before e must be 4294967295 */ e=0;
  f=~(a|b);
  /* Before f must be 0 */ f=0;
  g=~(a&b);
  /* Before g must be 4294967295 */ g=0;
  h=~(a^b);
  /* Before h must be 0 */ h=0;
  i=~a;
  /* Before i must be 2863311530 */ i=0;
  j=~b;
  /* Before j must be 1431655765 */ j=0;

  a=0x00000000;
  b=0x00000000;
  c=a|b;
  /* Before c must be 0 */ c=0;
  d=a&b;
  /* Before d must be 0 */ d=0;
  e=a^b;
  /* Before e must be 0 */ e=0;
  f=~(a|b);
  /* Before f must be 4294967295 */ f=0;
  g=~(a&b);
  /* Before g must be 4294967295 */ g=0;
  h=~(a^b);
  /* Before h must be 4294967295 */ h=0;
  i=~a;
  /* Before i must be 4294967295 */ i=0;
  j=~b;
  /* Before j must be 4294967295 */ j=0;

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
