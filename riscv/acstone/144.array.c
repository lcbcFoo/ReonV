/**
 * @file      144.array.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function that uses signed and unsigned short int Bubble Sort.
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

void ssiBubbleSort(signed short int ssiarray[],int size);
void usiBubbleSort(unsigned short int usiarray[],int size);

int main() {

  signed short int ssiinput[21];
  unsigned short int usiinput[21];

  signed char i;
  unsigned char j;
    
  int count,errorssi,errorusi;

  ssiinput[0]=0xF5DF;
  ssiinput[1]=0x2444;
  ssiinput[2]=0x5612;
  ssiinput[3]=0xF645;
  ssiinput[4]=0xFF80;
  ssiinput[5]=0x12DD;
  ssiinput[6]=0x4343;
  ssiinput[7]=0xF167;
  ssiinput[8]=0x0000;
  ssiinput[9]=0x0123;
  ssiinput[10]=0x3301;
  ssiinput[11]=0x12F7;
  ssiinput[12]=0x8745;
  ssiinput[13]=0x8286;
  ssiinput[14]=0x1296;
  ssiinput[15]=0x3452;
  ssiinput[16]=0xE3FF;
  ssiinput[17]=0x2456;
  ssiinput[18]=0x6723;
  ssiinput[19]=0x7510;
  ssiinput[20]=0x0005;
  
  usiinput[0]=0xF5DF;
  usiinput[1]=0x2444;
  usiinput[2]=0x5612;
  usiinput[3]=0xF645;
  usiinput[4]=0xFF80;
  usiinput[5]=0x12DD;
  usiinput[6]=0x4343;
  usiinput[7]=0xF167;
  usiinput[8]=0x0000;
  usiinput[9]=0x0123;
  usiinput[10]=0x3301;
  usiinput[11]=0x12F7;
  usiinput[12]=0x8745;
  usiinput[13]=0x8286;
  usiinput[14]=0x1296;
  usiinput[15]=0x3452;
  usiinput[16]=0xE3FF;
  usiinput[17]=0x2456;
  usiinput[18]=0x6723;
  usiinput[19]=0x7510;
  usiinput[20]=0x0005;


  /* signed sort */
  ssiBubbleSort(ssiinput,21);
  /* unsigned sort */
  usiBubbleSort(usiinput,21);


  /* Check */
  errorssi=0;
  for(count=0 ; count < 20 ; count++)
    if(ssiinput[count] > ssiinput[count+1])
      errorssi=1;

  /* Check */
  errorusi=0;
  for(count=0 ; count < 20 ; count++)
    if(usiinput[count] > usiinput[count+1])
      errorusi=1;

   
  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif

/* signed short int bubble sort */
void ssiBubbleSort(signed short int ssiarray[],int size) {
  int i,j;
  signed short int temp;
  for(i=(size-1);i>=0;i--) {
    for(j=0;j<i;j++) {
      if(ssiarray[j+1] < ssiarray[j]) {
	temp=ssiarray[j+1];
	ssiarray[j+1]=ssiarray[j];
	ssiarray[j]=temp;
      }
    }
  }
}

/* unsigned short int bubble sort */
void usiBubbleSort(unsigned short int usiarray[],int size) {
  int i,j;
  unsigned short int temp;
  for(i=(size-1);i>=0;i--) {
    for(j=0;j<i;j++) {
      if(usiarray[j+1] < usiarray[j]) {
	temp=usiarray[j+1];
	usiarray[j+1]=usiarray[j];
	usiarray[j]=temp;
      }
    }
  }
}
