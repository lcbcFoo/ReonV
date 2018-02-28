/**
 * @file      014.const.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function that uses unsigned short int and returns 0.
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

  usi=0x5555; 
  /* After usi is 21845 */
  
  /* Before usi is 21845 */ usi=0xAAAA; 
  /* After usi is 43690 */
  
  /* Before usi is 43690 */ usi=0x0000; 
  /* After usi is 0 */

  /* Before usi is 0 */ usi=0xFFFF; 
  /* After usi is 65535 */
  
  /* Before usi is 65535 */ usi=0x8000; 
  /* After usi is 32768 */

  /* Before usi is 32768 */ usi=0x0001;
  /* After usi is 1 */

  /* Before usi is 1 */ usi=0x7FFF; 
  /* After usi is 32767 */
  
  /* Before usi is 32767 */ usi=0xFFFE;
  /* After usi is 65534 */

  /* Before usi is 65534 */ return 0; 
  /* Return 0 */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
