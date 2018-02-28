/**
 * @file      016.const.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function that uses unsigned int and returns 0.
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
  unsigned int ui;

  ui=0x55555555; 
  /* After ui is 1431655765 */

  /* Before ui is 1431655765 */ ui=0xAAAAAAAA; 
  /* After ui is 2863311530 */

  /* Before ui is 2863311530 */ ui=0x00000000; 
  /* After ui is 0 */
 
  /* Before ui is 0 */ ui=0xFFFFFFFF;
  /* After ui is 4294967295 */

  /* Before ui is 4294967295 */ ui=0x80000000;
  /* After ui is 2147483648 */

  /* Before ui is 2147483648 */ ui=0x00000001;
  /* After ui is 1 */

  /* Before ui is 1 */ ui=0x7FFFFFFF;
  /* After ui is 2147483647 */
 
  /* Before ui is 2147483647 */ ui=0xFFFFFFFE;
  /* After ui is 4294967294 */
  
  /* Before ui is 4294967294 */ return 0;
  /* Return 0 */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
