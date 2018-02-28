/**
 * @file      082.shift.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function that uses signed and unsigned short int shifts.
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

  unsigned short int usi;
  signed short int ssi;
  
  
  usi=0xFFFF;
  usi=usi>>1;
  /* Before usi must be 32767 */ usi=0;

  usi=0x0000;
  usi=usi>>1;
  /* Before usi must be 0 */ usi=0;

  usi=0x0001;
  usi=usi>>1;
  /* Before usi must be 0 */ usi=0;

  usi=0x8000;
  usi=usi>>1;
  /* Before usi must be 16384 */ usi=0;
  
  usi=0xAAAA;
  usi=usi>>1;
  /* Before usi must be 21845 */ usi=0;
  
  usi=0x03C0;
  usi=usi>>2;
  /* Before usi must be 240 */ usi=0;

  
  ssi=0xFFFF;
  ssi=ssi>>1;
  /* Before ssi must be -1 */ ssi=0;

  ssi=0x0000;
  ssi=ssi>>1;
  /* Before ssi must be 0 */ ssi=0;

  ssi=0x0001;
  ssi=ssi>>1;
  /* Before ssi must be 0 */ ssi=0;

  ssi=0x8000;
  ssi=ssi>>1;
  /* Before ssi must be -16384 */ ssi=0;
  
  ssi=0xAAAA;
  ssi=ssi>>1;
  /* Before ssi must be -10923 */ ssi=0;
  
  ssi=0x03C0;
  ssi=ssi>>2;
  /* Before ssi must be 240 */ ssi=0;

    
  usi=0xFFFF;
  usi=usi<<1;
  /* Before usi must be 65534 */ usi=0;

  usi=0x0000;
  usi=usi<<1;
  /* Before usi must be 0 */ usi=0;

  usi=0x0001;
  usi=usi<<1;
  /* Before usi must be 2 */ usi=0;

  usi=0x8000;
  usi=usi<<1;
  /* Before usi must be 0 */ usi=0;
  
  usi=0xAAAA;
  usi=usi<<1;
  /* Before usi must be 21844 */ usi=0;
  
  usi=0x03C0;
  usi=usi<<2;
  /* Before usi must be 3840 */ usi=0;


  ssi=0xFFFF;
  ssi=ssi<<1;
  /* Before ssi must be -2 */ ssi=0;

  ssi=0x0000;
  ssi=ssi<<1;
  /* Before ssi must be 0 */ ssi=0;

  ssi=0x0001;
  ssi=ssi<<1;
  /* Before ssi must be 2 */ ssi=0;

  ssi=0x8000;
  ssi=ssi<<1;
  /* Before ssi must be 0 */ ssi=0;
  
  ssi=0xAAAA;
  ssi=ssi<<1;
  /* Before ssi must be 21844 */ ssi=0;
  
  ssi=0x03C0;
  ssi=ssi<<2;
  /* Before ssi must be 3840 */ ssi=0;

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
