/**
 * @file      075.bool.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:21 -0300
 * @brief     It is a simple main function that uses various boolean operators.
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

  signed long int a,b;

  a=0x00000000;
  b=a|0x01F;
  /* Before b must be 0xFFFFFF00 */ b=0;
  b=a|0x00F;
  /* Before b must be 0x0000000F */ b=0;
  b=a|0x011;
  /* Before b must be 0x10000000 */ b=0;
  b=~(a|0x101);
  /* Before b must be 361700864190383365 */ b=0;
  b=~(a|0x111);
  /* Before b must be 6872316419617283935 */ b=0;
  b=~(a|0xFFF);
  /* Before b must be 11936128518282651045 */ b=0;

  return 0;
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif