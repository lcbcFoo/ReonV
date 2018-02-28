/**
 * @file      141.array.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function that uses size three dot products.
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
  
  unsigned char uca[3];
  unsigned char ucb[3];
  unsigned char ucc;

  signed char sca[3];
  signed char scb[3];
  signed char scc;

  unsigned short int usia[3];
  unsigned short int usib[3];
  unsigned short int usic;

  signed short int ssia[3];
  signed short int ssib[3];
  signed short int ssic;

  unsigned int uia[3];
  unsigned int uib[3];
  unsigned int uic;

  signed int sia[3];
  signed int sib[3];
  signed int sic;

  unsigned long long int ulia[3];
  unsigned long long int ulib[3];
  unsigned long long int ulic;

  signed long long int slia[3];
  signed long long int slib[3];
  signed long long int slic;

  unsigned char count;

  for(count=1;count<=3;count++) {
    uca[count-1]=count;
    ucb[count-1]=count;
  }

  for(count=1;count<=3;count++) {
    usia[count-1]=count;
    usib[count-1]=count;
  }
  
  for(count=1;count<=3;count++) {
    uia[count-1]=count;
    uib[count-1]=count;
  }
  
  for(count=1;count<=3;count++) {
    ulia[count-1]=count;
    ulib[count-1]=count;
  }

  for(count=1;count<=3;count++) {
    sca[count-1]=count;
    scb[count-1]=count;
  }

  for(count=1;count<=3;count++) {
    ssia[count-1]=count;
    ssib[count-1]=count;
  }
  
  for(count=1;count<=3;count++) {
    sia[count-1]=count;
    sib[count-1]=count;
  }
  
  for(count=1;count<=3;count++) {
    slia[count-1]=count;
    slib[count-1]=count;
  }

  
  ucc=0;
  for(count=0;count<3;count++)
    ucc=ucc+(uca[count]*ucb[count]);
  /* Before ucc must be 14 */ ucc=0;
  
  scc=0;
  for(count=0;count<3;count++)
    scc=scc+(sca[count]*scb[count]);
  /* Before scc must be 14 */ scc=0;
  
  usic=0;
  for(count=0;count<3;count++)
    usic=usic+(usia[count]*usib[count]);
  /* Before usic must be 14 */ usic=0;
     
  ssic=0;
  for(count=0;count<3;count++)
    ssic=ssic+(ssia[count]*ssib[count]);
  /* Before ssic must be 14 */ ssic=0;
     
  uic=0;
  for(count=0;count<3;count++)
    uic=uic+(uia[count]*uib[count]);
  /* Before uic must be 14 */ uic=0;
     
  sic=0;
  for(count=0;count<3;count++)
    sic=sic+(sia[count]*sib[count]);
  /* Before sic must be 14 */ sic=0;
     
  ulic=0;
  for(count=0;count<3;count++)
    ulic=ulic+(ulia[count]*ulib[count]);
  /* Before ulic must be 14 */ ulic=0;
     
  slic=0;
  for(count=0;count<3;count++)
    slic=slic+(slia[count]*slib[count]);
  /* Before slic must be 14 */ slic=0;     


  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
