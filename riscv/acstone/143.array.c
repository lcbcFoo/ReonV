/**
 * @file      143.array.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief     It is a simple main function that uses signed and unsigned char Bubble Sort.
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

void scBubbleSort(signed char scarray[],int size);
void ucBubbleSort(unsigned char ucarray[],int size);

int main() {

  signed char scinput[21];
  unsigned char ucinput[21];

  signed char i;
  unsigned char j;
    
  int count=0,errorsc=0,erroruc=0;

  scinput[0]=0xDF;
  scinput[1]=0x44;
  scinput[2]=0x12;
  scinput[3]=0x45;
  scinput[4]=0x80;
  scinput[5]=0xDD;
  scinput[6]=0x43;
  scinput[7]=0x67;
  scinput[8]=0x00;
  scinput[9]=0x23;
  scinput[10]=0x01;
  scinput[11]=0xF7;
  scinput[12]=0x45;
  scinput[13]=0x86;
  scinput[14]=0x96;
  scinput[15]=0x52;
  scinput[16]=0xFF;
  scinput[17]=0x56;
  scinput[18]=0x23;
  scinput[19]=0x10;
  scinput[20]=0x05;
  
  ucinput[0]=0xDF;
  ucinput[1]=0x44;
  ucinput[2]=0x12;
  ucinput[3]=0x45;
  ucinput[4]=0x80;
  ucinput[5]=0xDD;
  ucinput[6]=0x43;
  ucinput[7]=0x67;
  ucinput[8]=0x00;
  ucinput[9]=0x23;
  ucinput[10]=0x01;
  ucinput[11]=0xF7;
  ucinput[12]=0x45;
  ucinput[13]=0x86;
  ucinput[14]=0x96;
  ucinput[15]=0x52;
  ucinput[16]=0xFF;
  ucinput[17]=0x56;
  ucinput[18]=0x23;
  ucinput[19]=0x10;
  ucinput[20]=0x05;


  /* signed sort */
  scBubbleSort(scinput,21);
  /* unsigned sort */
  ucBubbleSort(ucinput,21);


  /* Check */
  errorsc=0;
  for(count=0 ; count < 20 ; count++)
    if(scinput[count] > scinput[count+1])
      errorsc=1;

  /* Check */
  erroruc=0;
  for(count=0 ; count < 20 ; count++)
    if(ucinput[count] > ucinput[count+1])
      erroruc=1;

   
  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif

/* signed char bubble sort */
void scBubbleSort(signed char scarray[],int size) {
  int i,j;
  signed char temp;
  for(i=(size-1);i>=0;i--) {
    for(j=0;j<i;j++) {
      if(scarray[j+1] < scarray[j]) {
	temp=scarray[j+1];
	scarray[j+1]=scarray[j];
	scarray[j]=temp;
      }
    }
  }
}

/* unsigned char bubble sort */
void ucBubbleSort(unsigned char ucarray[],int size) {
  int i,j;
  unsigned char temp;
  for(i=(size-1);i>=0;i--) {
    for(j=0;j<i;j++) {
      if(ucarray[j+1] < ucarray[j]) {
	temp=ucarray[j+1];
	ucarray[j+1]=ucarray[j];
	ucarray[j]=temp;
      }
    }
  }
}
