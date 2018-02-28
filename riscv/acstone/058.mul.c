/**
 * @file      058.mul.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function uses various unsigned multiplication.
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
  unsigned char uc1,uc2,uc3,uc4,uc5,ucresult;
  unsigned short int usi1,usi2,usi3,usi4,usi5,usiresult;
  unsigned int ui1,ui2,ui3,ui4,ui5,uiresult;
  unsigned long long int uli1,uli2,uli3,uli4,uli5,uliresult;
  
  uc1=1;
  uc2=2;
  uc3=3;
  uc4=4;
  uc5=5;
  ucresult=uc1*uc2*uc3*uc4*uc5;
  /* Before ucresult must be 120 */ ucresult=0;

  usi1=1;
  usi2=2;
  usi3=3;
  usi4=4;
  usi5=5;
  usiresult=usi1*usi2*usi3*usi4*usi5;
  /* Before usiresult must be 120 */ usiresult=0;
  
  ui1=1;
  ui2=2;
  ui3=3;
  ui4=4;
  ui5=5;
  uiresult=ui1*ui2*ui3*ui4*ui5;
  /* Before uiresult must be 120 */ uiresult=0;

  uli1=1;
  uli2=2;
  uli3=3;
  uli4=4;
  uli5=5;
  uliresult=uli1*uli2*uli3*uli4*uli5;
  /* Before uliresult must be 120 */ uliresult=0;

  uc1=5;
  usiresult=uc1*7;
  /* Before usiresult must be 35 */ usiresult=0;

  usi1=5;
  uiresult=usi1*7;
  /* Before uiresult must be 35 */ uiresult=0;

  ui1=5;
  uliresult=ui1*7;
  /* Before uliresult must be 35 */ uliresult=0;

  uc1=17;
  usiresult=uc1*5;
  /* Before usiresult must be 85 */ usiresult=0;

  usi1=17;
  uiresult=usi1*5;
  /* Before uiresult must be 85 */ uiresult=0;

  ui1=17;
  uliresult=ui1*5;
  /* Before siresult must be 85 */ uliresult=0;

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
