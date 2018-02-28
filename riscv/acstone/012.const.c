/**
 * @file      012.const.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function that uses unsigned char and returns 0.
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
  unsigned char uc;

  uc=0x55; 
  /* After uc is 85 */

  /* Before uc is 85 */ uc=0xAA; 
  /* After uc is 170 */

  /* Before uc is 170 */ uc=0x00; 
  /* After uc is 0 */

  /* Before uc is 0 */ uc=0xFF; 
  /* After uc is 255 */

  /* Before uc is 255 */ uc=0x80; 
  /* After uc is 128 */

  /* Before uc is 128 */ uc=0x01; 
  /* After uc is 1 */

  /* Before uc is 1 */ uc=0x7F; 
  /* After uc is 127 */

  /* Before uc is 127 */ uc=0xFE; 
  /* After uc is 254 */

  /* Before uc is 254 */ return 0; 
  /* Return 0 */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
