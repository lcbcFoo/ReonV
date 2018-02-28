/**
 * @file      124.loop.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:21 -0300
 * @brief     It is a simple main function that uses a implemented signed multiplication (Booth)
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

  unsigned char count;
  unsigned int A,Q,Qmenos,M,mask;
  signed long long int result;

  count=32; /* 32 bits * 32 bits = 64 bits */

  /* Some variable */
  M=0x82348243;
  Q=0x41378972;
  Qmenos=0x00000000;
  A=0x00000000;

  while(count!=0) {
    
    mask=(((Q<<1) & 0x00000002) | (Qmenos & 0x00000001));
    
    switch(mask) {
      
    case 0x0: /* q0=0 and qm=0 */
    case 0x3: /* qo=1 and qm=1 */
      /* Nothing */
      break;
      
    case 0x2: /* q0=1 and qm=0 */
      A=A-M;
      break;
      
    case 0x1: /* q0=0 and qm=1 */
      A=A+M;
      break;
      
    }
    
    /* Shift */
    if(Q & 0x00000001)
      Qmenos=1;
    else
      Qmenos=0;
    
    Q=Q>>1;
    
    if(A & 0x00000001)
      Q=(Q | 0x80000000);
    else
      Q=(Q & 0x7FFFFFFF);
    
    A=A>>1;
    if(A & 0x40000000)
      A=(A | 0x80000000);
    
    count--;
  }
  
  result=0;
  result=((((unsigned long long int)(A)) << 32) | 
	  ((unsigned long long int)(Q)));
  /* Before result must be -2309208815826051882 */ result=0;

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
