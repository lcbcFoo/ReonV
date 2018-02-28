/**
 * @file      133.call.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:21 -0300
 * @brief     It is a simple main function that uses recursive fatorial.
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

/* Declarations */
unsigned long long int ulifatorial(unsigned long long int n);
signed long long int slifatorial(signed long long int n);


/* The file begin.h is included if compiler flag -DBEGINCODE is used */
#ifdef BEGINCODE
#include "begin.h"
#endif

int main() {

  unsigned long long int ulin;
  signed long long int slin;
  
  ulin=ulifatorial(25);
  /* Before ulin must be 7034535277573963776 */ ulin=0;
  slin=slifatorial(25);
  /* Before slin must be 7034535277573963776 */ slin=0;

  return 0; 
  /* Return 0 only */
}


unsigned long long int ulifatorial(unsigned long long int n) {
  if(n > 1)
    return(n*ulifatorial(n-1));
  else
    return 1;
}

signed long long int slifatorial(signed long long int n) {
  if(n > 1)
    return(n*slifatorial(n-1));
  else
    return 1;
}


/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
