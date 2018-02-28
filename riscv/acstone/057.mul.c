/**
 * @file      057.mul.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:21 -0300
 * @brief     It is a simple main function uses various signed multiplication.
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
  signed char c1,c2,c3,c4,c5,cresult;
  signed short int si1,si2,si3,si4,si5,siresult;
  signed int i1,i2,i3,i4,i5,iresult;
  signed long long int li1,li2,li3,li4,li5,liresult;
  
  c1=1;
  c2=2;
  c3=3;
  c4=4;
  c5=5;
  cresult=c1*c2*c3*c4*c5;
  /* Before cresult must be 120 */ cresult=0;

  si1=1;
  si2=2;
  si3=3;
  si4=4;
  si5=5;
  siresult=si1*si2*si3*si4*si5;
  /* Before siresult must be 120 */ siresult=0;
  
  i1=1;
  i2=2;
  i3=3;
  i4=4;
  i5=5;
  iresult=i1*i2*i3*i4*i5;
  /* Before iresult must be 120 */ iresult=0;

  li1=1;
  li2=2;
  li3=3;
  li4=4;
  li5=5;
  liresult=li1*li2*li3*li4*li5;
  /* Before liresult must be 120 */ liresult=0;

  c1=5;
  siresult=c1*7;
  /* Before siresult must be 35 */ siresult=0;

  si1=5;
  iresult=si1*7;
  /* Before iresult must be 35 */ iresult=0;

  i1=5;
  liresult=i1*7;
  /* Before liresult must be 35 */ liresult=0;

  c1=17;
  siresult=c1*(-1);
  /* Before siresult must be -17 */ siresult=0;

  si1=17;
  iresult=si1*(-1);
  /* Before iresult must be -17 */ iresult=0;

  i1=17;
  liresult=i1*(-1);
  /* Before siresult must be -17 */ liresult=0;

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
