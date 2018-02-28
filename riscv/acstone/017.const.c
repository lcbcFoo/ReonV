/**
 * @file      017.const.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function that uses signed long long int and returns 0.
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
  signed long long int li;

  li=0x5555555555555555LL; 
  /* After li is 6148914691236517205 */

  /* Before li is 6148914691236517205 */ li=0xAAAAAAAAAAAAAAAALL; 
  /* After li is -6148914691236517206 */

  /* Before li is -6148914691236517206 */ li=0x0000000000000000LL;
  /* After li is 0 */
  
  /* Before li is 0 */ li=0xFFFFFFFFFFFFFFFFLL;
  /* After li is -1 */

  /* Before li is -1 */ li=0x8000000000000000LL;
  /* After li is -9223372036854775808 */

  /* Before li is -9223372036854775808 */ li=0x0000000000000001LL;
  /* After li is 1 */
  
  /* Before li is 1 */ li=0x7FFFFFFFFFFFFFFFLL;
  /* After li is 9223372036854775807 */
  
  /* Before li is 9223372036854775807 */ li=0xFFFFFFFFFFFFFFFELL;
  /* After li is -2 * /
  
  /* Before li is -2 */ return 0; 
  /* Return 0 */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
