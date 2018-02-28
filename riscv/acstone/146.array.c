/**
 * @file      146.array.c
 * @author    The ArchC Team
 *            http://www.archc.org/
 *
 *            Computer Systems Laboratory (LSC)
 *            IC-UNICAMP
 *            http://www.lsc.ic.unicamp.br
 *
 * @version   1.0
 * @date      Mon, 19 Jun 2006 15:33:22 -0300
 * @brief      It is a simple main function that uses signed and unsigned long long int Bubble Sort.
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

/* It is a simple main function that uses signed and unsigned long long int Bubble Sort.*/

/* The file begin.h is included if compiler flag -DBEGINCODE is used */
#ifdef BEGINCODE
#include "begin.h"
#endif

void sliBubbleSort(signed long long int siarray[],int size);
void uliBubbleSort(unsigned long long int uiarray[],int size);

int main() {

  signed long long int sliinput[21];
  unsigned long long int uliinput[21];

  signed char i;
  unsigned char j;
    
  int count,errorsli,erroruli;

  sliinput[0]=0xF5032345F234F5DFLL;
  sliinput[1]=0xD3A4F62123512444LL;
  sliinput[2]=0x9876223434565612LL;
  sliinput[3]=0x000000001234F645LL;
  sliinput[4]=0x234567898901FF80LL;
  sliinput[5]=0x78905432789012DDLL;
  sliinput[6]=0x1234567823454343LL;
  sliinput[7]=0x890765238965F167LL;
  sliinput[8]=0x0000000000000000LL;
  sliinput[9]=0x4523457845670123LL;
  sliinput[10]=0x0987123423453301LL;
  sliinput[11]=0x56780987543212F7LL;
  sliinput[12]=0x8654123476548745LL;
  sliinput[13]=0x45E3213423458286LL;
  sliinput[14]=0xF234566887651296LL;
  sliinput[15]=0xD345674902953452LL;
  sliinput[16]=0x4523457845670123LL;
  sliinput[17]=0x2345678922222456LL;
  sliinput[18]=0x8889098612346723LL;
  sliinput[19]=0x12345433D4567510LL;
  sliinput[20]=0x0000000000000005LL;

  uliinput[0]=0xF5032345F234F5DFULL;
  uliinput[1]=0xD3A4F62123512444ULL;
  uliinput[2]=0x9876223434565612ULL;
  uliinput[3]=0x000000001234F645ULL;
  uliinput[4]=0x234567898901FF80ULL;
  uliinput[5]=0x78905432789012DDULL;
  uliinput[6]=0x1234567823454343ULL;
  uliinput[7]=0x890765238965F167ULL;
  uliinput[8]=0x0000000000000000ULL;
  uliinput[9]=0x4523457845670123ULL;
  uliinput[10]=0x0987123423453301ULL;
  uliinput[11]=0x56780987543212F7ULL;
  uliinput[12]=0x8654123476548745ULL;
  uliinput[13]=0x45E3213423458286ULL;
  uliinput[14]=0xF234566887651296ULL;
  uliinput[15]=0xD345674902953452ULL;
  uliinput[16]=0x4523457845670123ULL;
  uliinput[17]=0x2345678922222456ULL;
  uliinput[18]=0x8889098612346723ULL;
  uliinput[19]=0x12345433D4567510ULL;
  uliinput[20]=0x0000000000000005ULL;


  /* signed sort */
  sliBubbleSort(sliinput,21);
  /* unsigned sort */
  uliBubbleSort(uliinput,21);


  /* Check */
  errorsli=0;
  for(count=0 ; count < 20 ; count++)
    if(sliinput[count] > sliinput[count+1])
      errorsli=1;

  /* Check */
  erroruli=0;
  for(count=0 ; count < 20 ; count++)
    if(uliinput[count] > uliinput[count+1])
      erroruli=1;

   
  return 0; 
  /* Return 0 only */
}

/* The file end.h is included if compiler flag -DENDCODE is used */
#ifdef ENDCODE
#include "end.h"
#endif

/* signed long long int  bubble sort */
void sliBubbleSort(signed long long int sliarray[],int size) {
  int i,j;
  signed long long int temp;
  for(i=(size-1);i>=0;i--) {
    for(j=0;j<i;j++) {
      if(sliarray[j+1] < sliarray[j]) {
	temp=sliarray[j+1];
	sliarray[j+1]=sliarray[j];
	sliarray[j]=temp;
      }
    }
  }
}

/* unsigned long long int bubble sort */
void uliBubbleSort(unsigned long long int uliarray[],int size) {
  int i,j;
  unsigned long long int temp;
  for(i=(size-1);i>=0;i--) {
    for(j=0;j<i;j++) {
      if(uliarray[j+1] < uliarray[j]) {
	temp=uliarray[j+1];
	uliarray[j+1]=uliarray[j];
	uliarray[j]=temp;
      }
    }
  }
}
