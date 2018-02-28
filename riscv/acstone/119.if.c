/**
 * @file      119.if.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:21 -0300
 * @brief     It is a simple main function that uses various ifs.
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

  signed char a;
  unsigned char b;
  signed short int c;
  unsigned short int d;
  signed int e;
  unsigned int f;
  signed long long int g;
  unsigned long long int h;

  unsigned char ok,failed;

  ok=0;
  failed=0;
  a=0;
  b=1;
  c=2;
  d=3;
  e=4;
  f=5;
  g=6;
  h=7;
    
  if(a==0)
    if(b==1)
      if(c==2)
	if(d==3)
	  if(e==4)
	    if(f==5)
	      if(g==6)
		if(h==7)
		  ok++; /* $= OK! */
    
  if(a>=0)
    if(b<=1)
      if(c>=2)
	if(d<=3)
	  if(e>=4)
	    if(f>=5)
	      if(g<=6)
		if(h<=7)
		  ok++; /* $= OK! */

  if(a>=-1)
    if(b>=1)
      if(c>=-2)
	if(d>=3)
	  if(e>=-3)
	    if(f>=5)
	      if(g>=-4)
		if(h>=7)
		  ok++; /* $= OK! */
   
  if(a==0)
    if(b==1)
      if(c==2)
	if(d==3)
	  if(e<4)
	    if(f==5)
	      if(g==6)
		if(h==7)
		  failed++; /* $= FAILED! */
    
  if(a>=0)
    if(b<=1)
      if(c>=2)
	if(d<=3)
	  if(e>=4)
	    if(f>=5)
	      if(g<=6)
		if(h==8)
		  failed++; /* $= FAILED! */

  if(a==-1)
    if(b>=1)
      if(c>=-2)
	if(d>=3)
	  if(e>=-3)
	    if(f>=5)
	      if(g>=-4)
		if(h>=7)
		  failed++; /* $= FAILED! */
   
  ok=0; /* Before ok must be 3 */
  failed=0; /* Before failed must be 0 */

  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif
