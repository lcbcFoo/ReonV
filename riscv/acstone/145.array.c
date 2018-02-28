/**
 * @file      145.array.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function that uses signed and unsigned int Bubble Sort.
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

void siBubbleSort(signed int siarray[],int size);
void uiBubbleSort(unsigned int uiarray[],int size);

int main() {

  signed int siinput[21];
  unsigned int uiinput[21];

  signed char i;
  unsigned char j;
    
  int count,errorsi,errorui;

  siinput[0]=0xF234F5DF;
  siinput[1]=0x23512444;
  siinput[2]=0x34565612;
  siinput[3]=0x1234F645;
  siinput[4]=0x8901FF80;
  siinput[5]=0x789012DD;
  siinput[6]=0x23454343;
  siinput[7]=0x8965F167;
  siinput[8]=0x00000000;
  siinput[9]=0x45670123;
  siinput[10]=0x23453301;
  siinput[11]=0x543212F7;
  siinput[12]=0x76548745;
  siinput[13]=0x23458286;
  siinput[14]=0x87651296;
  siinput[15]=0xD3453452;
  siinput[16]=0xC432E3FF;
  siinput[17]=0x22222456;
  siinput[18]=0x12346723;
  siinput[19]=0xD4567510;
  siinput[20]=0x00000005;

  uiinput[0]=0xF234F5DF;
  uiinput[1]=0x23512444;
  uiinput[2]=0x34565612;
  uiinput[3]=0x1234F645;
  uiinput[4]=0x8901FF80;
  uiinput[5]=0x789012DD;
  uiinput[6]=0x23454343;
  uiinput[7]=0x8965F167;
  uiinput[8]=0x00000000;
  uiinput[9]=0x45670123;
  uiinput[10]=0x23453301;
  uiinput[11]=0x543212F7;
  uiinput[12]=0x76548745;
  uiinput[13]=0x23458286;
  uiinput[14]=0x87651296;
  uiinput[15]=0xD3453452;
  uiinput[16]=0xC432E3FF;
  uiinput[17]=0x22222456;
  uiinput[18]=0x12346723;
  uiinput[19]=0xD4567510;
  uiinput[20]=0x00000005;


  /* signed sort */
  siBubbleSort(siinput,21);
  /* unsigned sort */
  uiBubbleSort(uiinput,21);


  /* Check */
  errorsi=0;
  for(count=0 ; count < 20 ; count++)
    if(siinput[count] > siinput[count+1])
      errorsi=1;

  /* Check */
  errorui=0;
  for(count=0 ; count < 20 ; count++)
    if(uiinput[count] > uiinput[count+1])
      errorui=1;

   
  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif

/* signed int bubble sort */
void siBubbleSort(signed int siarray[],int size) {
  int i,j;
  signed int temp;
  for(i=(size-1);i>=0;i--) {
    for(j=0;j<i;j++) {
      if(siarray[j+1] < siarray[j]) {
	temp=siarray[j+1];
	siarray[j+1]=siarray[j];
	siarray[j]=temp;
      }
    }
  }
}

/* unsigned int bubble sort */
void uiBubbleSort(unsigned int uiarray[],int size) {
  int i,j;
  unsigned int temp;
  for(i=(size-1);i>=0;i--) {
    for(j=0;j<i;j++) {
      if(uiarray[j+1] < uiarray[j]) {
	temp=uiarray[j+1];
	uiarray[j+1]=uiarray[j];
	uiarray[j]=temp;
      }
    }
  }
}
