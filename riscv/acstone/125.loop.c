/**
 * @file      125.loop.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function that uses a implemented simple strlen loop.
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
  
  unsigned char *ac="ArchC - Architecture Description Language\n";
  unsigned char *lsc="Computer System Laboratory\n";
  unsigned char *ic="Institute of Computing - UNICAMP\n";
  unsigned char *p;
  unsigned int count;

  p=ac;
  count=0;
  while(*p) { /* strlen */
    p++; count++;
  }
  /* Before count must be 42 */ count=0;
  
  p=lsc;
  count=0;
  while(*p) { /* strlen */
    p++; count++;
  }
  /* Before count must be 27 */ count=0;
  
  p=ic;
  count=0;
  while(*p) { /* strlen */
    p++; count++;
  }
  /* Before count must be 33 */ count=0;

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
