/*Title: DPR partial bit-file conversion utility (beta)

Author: Pascal Trotta (Politecnico di Torino - TestGroup) www.testgroup.polito.it

Compiled using:
g++ -Wall -fexceptions -O2 -c ./main.cpp -o ./main.o
g++  -o ./dprc_sw ./main.o

*/

#include <iostream>
#include <stdlib.h>
#include <fstream>
#include <math.h>
#include <iomanip>
#include <algorithm>

using namespace std;

int bin2dec(string bin){
    int acc=0;

    for (unsigned int i=0;(i<bin.size()) && i<32;i++)
        if (bin.at(i)=='1')
            acc+=pow(2,32-1-i);

    return acc;
}

string dec2bin(int value){
    string result;
    for(int i=0; i<32; i++){
        if ( (value & 1) == 0 ) result += "0";
        else result += "1";
        value >>= 1;
    };

    reverse(result.begin(), result.end());
    return result;
}

bool c2b(char c){
  if (c=='1') return true;
  else return false;
}

string encode_word(string data_in){ // returns a 39-bit encoded word starting from 32-bit information
  bool coded[39];
  char c_coded[40];

  reverse(data_in.begin(), data_in.end());

  // P1
  coded[1] = c2b(data_in.at(0)) ^ c2b(data_in.at(1)) ^ c2b(data_in.at(3)) ^ c2b(data_in.at(4)) ^ c2b(data_in.at(6)) ^ c2b(data_in.at(8)) ^
             c2b(data_in.at(10)) ^ c2b(data_in.at(11)) ^ c2b(data_in.at(13)) ^ c2b(data_in.at(15)) ^ c2b(data_in.at(17)) ^ c2b(data_in.at(19)) ^
             c2b(data_in.at(21)) ^ c2b(data_in.at(23)) ^ c2b(data_in.at(25)) ^ c2b(data_in.at(26)) ^ c2b(data_in.at(28)) ^ c2b(data_in.at(30));
  // P2
  coded[2] = c2b(data_in.at(0)) ^ c2b(data_in.at(2)) ^ c2b(data_in.at(3)) ^ c2b(data_in.at(5)) ^ c2b(data_in.at(6)) ^ c2b(data_in.at(9)) ^
               c2b(data_in.at(10)) ^ c2b(data_in.at(12)) ^ c2b(data_in.at(13)) ^ c2b(data_in.at(16)) ^ c2b(data_in.at(17)) ^ c2b(data_in.at(20)) ^
               c2b(data_in.at(21)) ^ c2b(data_in.at(24)) ^ c2b(data_in.at(25)) ^ c2b(data_in.at(27)) ^ c2b(data_in.at(28)) ^ c2b(data_in.at(31));
  coded[3] = c2b(data_in.at(0));
  // P3
  coded[4] = c2b(data_in.at(1)) ^ c2b(data_in.at(2)) ^ c2b(data_in.at(3)) ^ c2b(data_in.at(7)) ^ c2b(data_in.at(8)) ^ c2b(data_in.at(9)) ^
               c2b(data_in.at(10)) ^ c2b(data_in.at(14)) ^ c2b(data_in.at(15)) ^ c2b(data_in.at(16)) ^ c2b(data_in.at(17)) ^ c2b(data_in.at(22)) ^
               c2b(data_in.at(23)) ^ c2b(data_in.at(24)) ^ c2b(data_in.at(25)) ^ c2b(data_in.at(29)) ^ c2b(data_in.at(30)) ^ c2b(data_in.at(31));
  coded[5] = c2b(data_in.at(1));
  coded[6] = c2b(data_in.at(2));
  coded[7] = c2b(data_in.at(3));
  // P4
  coded[8] = c2b(data_in.at(4)) ^ c2b(data_in.at(5)) ^ c2b(data_in.at(6)) ^ c2b(data_in.at(7)) ^ c2b(data_in.at(8)) ^ c2b(data_in.at(9)) ^
               c2b(data_in.at(10)) ^ c2b(data_in.at(18)) ^ c2b(data_in.at(19)) ^ c2b(data_in.at(20)) ^ c2b(data_in.at(21)) ^ c2b(data_in.at(22)) ^
               c2b(data_in.at(23)) ^ c2b(data_in.at(24)) ^ c2b(data_in.at(25));
  coded[9] = c2b(data_in.at(4));
  coded[10] = c2b(data_in.at(5));
  coded[11] = c2b(data_in.at(6));
  coded[12] = c2b(data_in.at(7));
  coded[13] = c2b(data_in.at(8));
  coded[14] = c2b(data_in.at(9));
  coded[15] = c2b(data_in.at(10));
  // P5
  coded[16] = c2b(data_in.at(11)) ^ c2b(data_in.at(12)) ^ c2b(data_in.at(13)) ^ c2b(data_in.at(14)) ^ c2b(data_in.at(15)) ^ c2b(data_in.at(16)) ^
                c2b(data_in.at(17)) ^ c2b(data_in.at(18)) ^ c2b(data_in.at(19)) ^ c2b(data_in.at(20)) ^ c2b(data_in.at(21)) ^ c2b(data_in.at(22)) ^
                c2b(data_in.at(23)) ^ c2b(data_in.at(24)) ^ c2b(data_in.at(25));
  coded[17] = c2b(data_in.at(11));
  coded[18] = c2b(data_in.at(12));
  coded[19] = c2b(data_in.at(13));
  coded[20] = c2b(data_in.at(14));
  coded[21] = c2b(data_in.at(15));
  coded[22] = c2b(data_in.at(16));
  coded[23] = c2b(data_in.at(17));
  coded[24] = c2b(data_in.at(18));
  coded[25] = c2b(data_in.at(19));
  coded[26] = c2b(data_in.at(20));
  coded[27] = c2b(data_in.at(21));
  coded[28] = c2b(data_in.at(22));
  coded[29] = c2b(data_in.at(23));
  coded[30] = c2b(data_in.at(24));
  coded[31] = c2b(data_in.at(25));
  // P6
  coded[32] = c2b(data_in.at(26)) ^ c2b(data_in.at(27)) ^ c2b(data_in.at(28)) ^ c2b(data_in.at(29)) ^ c2b(data_in.at(30)) ^ c2b(data_in.at(31));
  coded[33] = c2b(data_in.at(26));
  coded[34] = c2b(data_in.at(27));
  coded[35] = c2b(data_in.at(28));
  coded[36] = c2b(data_in.at(29));
  coded[37] = c2b(data_in.at(30));
  coded[38] = c2b(data_in.at(31));

  // P0
  coded[0] = false;

  for (int i=1; i<39; i++)
    coded[0]= coded[0] ^ coded[i];

  for (int i=0; i<39; i++){
		if (coded[i]) c_coded[i]='1';
		else c_coded[i]='0';
	}

  c_coded[39]='\0';
  string str_coded(c_coded);
  reverse(str_coded.begin(), str_coded.end());

  return str_coded;

}

class crc32{
public:
    void crc32_init();
    int crc32_koopmanII(string value);
private:
    char lfsr_q[32];
};

void crc32::crc32_init(){
    // Initialize CRC
    fill(lfsr_q,lfsr_q+32,'1');
}

int crc32::crc32_koopmanII(string value){

    char lfsr_c[32],data_in[32],lfsr_q_temp[32];
    bool lfsr_cB[32];

	//swap bits
	for (int i=0; i<32; i++) data_in[i]=value[31-i];
	for (int i=0; i<32; i++) lfsr_q_temp[i]=lfsr_q[i];
	for (int i=0; i<32; i++) lfsr_q[i]=lfsr_q_temp[31-i];

    //CRC computation
	lfsr_cB[0] = lfsr_q[0] ^ lfsr_q[3] ^ lfsr_q[6] ^ lfsr_q[9] ^ lfsr_q[12] ^ lfsr_q[14] ^ lfsr_q[15] ^ lfsr_q[20] ^ lfsr_q[21] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[31] ^ data_in[0] ^ data_in[3] ^ data_in[6] ^ data_in[9] ^ data_in[12] ^ data_in[14] ^ data_in[15] ^ data_in[20] ^ data_in[21] ^ data_in[26] ^ data_in[27] ^ data_in[28] ^ data_in[29] ^ data_in[31];
    lfsr_cB[1] = lfsr_q[1] ^ lfsr_q[4] ^ lfsr_q[7] ^ lfsr_q[10] ^ lfsr_q[13] ^ lfsr_q[15] ^ lfsr_q[16] ^ lfsr_q[21] ^ lfsr_q[22] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[30] ^ data_in[1] ^ data_in[4] ^ data_in[7] ^ data_in[10] ^ data_in[13] ^ data_in[15] ^ data_in[16] ^ data_in[21] ^ data_in[22] ^ data_in[27] ^ data_in[28] ^ data_in[29] ^ data_in[30];
    lfsr_cB[2] = lfsr_q[2] ^ lfsr_q[5] ^ lfsr_q[8] ^ lfsr_q[11] ^ lfsr_q[14] ^ lfsr_q[16] ^ lfsr_q[17] ^ lfsr_q[22] ^ lfsr_q[23] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[30] ^ lfsr_q[31] ^ data_in[2] ^ data_in[5] ^ data_in[8] ^ data_in[11] ^ data_in[14] ^ data_in[16] ^ data_in[17] ^ data_in[22] ^ data_in[23] ^ data_in[28] ^ data_in[29] ^ data_in[30] ^ data_in[31];
    lfsr_cB[3] = lfsr_q[0] ^ lfsr_q[14] ^ lfsr_q[17] ^ lfsr_q[18] ^ lfsr_q[20] ^ lfsr_q[21] ^ lfsr_q[23] ^ lfsr_q[24] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[30] ^ data_in[0] ^ data_in[14] ^ data_in[17] ^ data_in[18] ^ data_in[20] ^ data_in[21] ^ data_in[23] ^ data_in[24] ^ data_in[26] ^ data_in[27] ^ data_in[28] ^ data_in[30];
    lfsr_cB[4] = lfsr_q[1] ^ lfsr_q[15] ^ lfsr_q[18] ^ lfsr_q[19] ^ lfsr_q[21] ^ lfsr_q[22] ^ lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[31] ^ data_in[1] ^ data_in[15] ^ data_in[18] ^ data_in[19] ^ data_in[21] ^ data_in[22] ^ data_in[24] ^ data_in[25] ^ data_in[27] ^ data_in[28] ^ data_in[29] ^ data_in[31];
    lfsr_cB[5] = lfsr_q[2] ^ lfsr_q[16] ^ lfsr_q[19] ^ lfsr_q[20] ^ lfsr_q[22] ^ lfsr_q[23] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[30] ^ data_in[2] ^ data_in[16] ^ data_in[19] ^ data_in[20] ^ data_in[22] ^ data_in[23] ^ data_in[25] ^ data_in[26] ^ data_in[28] ^ data_in[29] ^ data_in[30];
    lfsr_cB[6] = lfsr_q[3] ^ lfsr_q[17] ^ lfsr_q[20] ^ lfsr_q[21] ^ lfsr_q[23] ^ lfsr_q[24] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[29] ^ lfsr_q[30] ^ lfsr_q[31] ^ data_in[3] ^ data_in[17] ^ data_in[20] ^ data_in[21] ^ data_in[23] ^ data_in[24] ^ data_in[26] ^ data_in[27] ^ data_in[29] ^ data_in[30] ^ data_in[31];
    lfsr_cB[7] = lfsr_q[4] ^ lfsr_q[18] ^ lfsr_q[21] ^ lfsr_q[22] ^ lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[30] ^ lfsr_q[31] ^ data_in[4] ^ data_in[18] ^ data_in[21] ^ data_in[22] ^ data_in[24] ^ data_in[25] ^ data_in[27] ^ data_in[28] ^ data_in[30] ^ data_in[31];
    lfsr_cB[8] = lfsr_q[5] ^ lfsr_q[19] ^ lfsr_q[22] ^ lfsr_q[23] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[31] ^ data_in[5] ^ data_in[19] ^ data_in[22] ^ data_in[23] ^ data_in[25] ^ data_in[26] ^ data_in[28] ^ data_in[29] ^ data_in[31];
    lfsr_cB[9] = lfsr_q[6] ^ lfsr_q[20] ^ lfsr_q[23] ^ lfsr_q[24] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[29] ^ lfsr_q[30] ^ data_in[6] ^ data_in[20] ^ data_in[23] ^ data_in[24] ^ data_in[26] ^ data_in[27] ^ data_in[29] ^ data_in[30];
    lfsr_cB[10] = lfsr_q[7] ^ lfsr_q[21] ^ lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[30] ^ lfsr_q[31] ^ data_in[7] ^ data_in[21] ^ data_in[24] ^ data_in[25] ^ data_in[27] ^ data_in[28] ^ data_in[30] ^ data_in[31];
    lfsr_cB[11] = lfsr_q[8] ^ lfsr_q[22] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[31] ^ data_in[8] ^ data_in[22] ^ data_in[25] ^ data_in[26] ^ data_in[28] ^ data_in[29] ^ data_in[31];
    lfsr_cB[12] = lfsr_q[9] ^ lfsr_q[23] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[29] ^ lfsr_q[30] ^ data_in[9] ^ data_in[23] ^ data_in[26] ^ data_in[27] ^ data_in[29] ^ data_in[30];
    lfsr_cB[13] = lfsr_q[10] ^ lfsr_q[24] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[30] ^ lfsr_q[31] ^ data_in[10] ^ data_in[24] ^ data_in[27] ^ data_in[28] ^ data_in[30] ^ data_in[31];
    lfsr_cB[14] = lfsr_q[0] ^ lfsr_q[3] ^ lfsr_q[6] ^ lfsr_q[9] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[14] ^ lfsr_q[15] ^ lfsr_q[20] ^ lfsr_q[21] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[27] ^ data_in[0] ^ data_in[3] ^ data_in[6] ^ data_in[9] ^ data_in[11] ^ data_in[12] ^ data_in[14] ^ data_in[15] ^ data_in[20] ^ data_in[21] ^ data_in[25] ^ data_in[26] ^ data_in[27];
    lfsr_cB[15] = lfsr_q[1] ^ lfsr_q[4] ^ lfsr_q[7] ^ lfsr_q[10] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[15] ^ lfsr_q[16] ^ lfsr_q[21] ^ lfsr_q[22] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[28] ^ data_in[1] ^ data_in[4] ^ data_in[7] ^ data_in[10] ^ data_in[12] ^ data_in[13] ^ data_in[15] ^ data_in[16] ^ data_in[21] ^ data_in[22] ^ data_in[26] ^ data_in[27] ^ data_in[28];
    lfsr_cB[16] = lfsr_q[2] ^ lfsr_q[5] ^ lfsr_q[8] ^ lfsr_q[11] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[16] ^ lfsr_q[17] ^ lfsr_q[22] ^ lfsr_q[23] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[29] ^ data_in[2] ^ data_in[5] ^ data_in[8] ^ data_in[11] ^ data_in[13] ^ data_in[14] ^ data_in[16] ^ data_in[17] ^ data_in[22] ^ data_in[23] ^ data_in[27] ^ data_in[28] ^ data_in[29];
    lfsr_cB[17] = lfsr_q[3] ^ lfsr_q[6] ^ lfsr_q[9] ^ lfsr_q[12] ^ lfsr_q[14] ^ lfsr_q[15] ^ lfsr_q[17] ^ lfsr_q[18] ^ lfsr_q[23] ^ lfsr_q[24] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[30] ^ data_in[3] ^ data_in[6] ^ data_in[9] ^ data_in[12] ^ data_in[14] ^ data_in[15] ^ data_in[17] ^ data_in[18] ^ data_in[23] ^ data_in[24] ^ data_in[28] ^ data_in[29] ^ data_in[30];
    lfsr_cB[18] = lfsr_q[0] ^ lfsr_q[3] ^ lfsr_q[4] ^ lfsr_q[6] ^ lfsr_q[7] ^ lfsr_q[9] ^ lfsr_q[10] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[16] ^ lfsr_q[18] ^ lfsr_q[19] ^ lfsr_q[20] ^ lfsr_q[21] ^ lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[30] ^ data_in[0] ^ data_in[3] ^ data_in[4] ^ data_in[6] ^ data_in[7] ^ data_in[9] ^ data_in[10] ^ data_in[12] ^ data_in[13] ^ data_in[14] ^ data_in[16] ^ data_in[18] ^ data_in[19] ^ data_in[20] ^ data_in[21] ^ data_in[24] ^ data_in[25] ^ data_in[26] ^ data_in[27] ^ data_in[28] ^ data_in[30];
    lfsr_cB[19] = lfsr_q[1] ^ lfsr_q[4] ^ lfsr_q[5] ^ lfsr_q[7] ^ lfsr_q[8] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[15] ^ lfsr_q[17] ^ lfsr_q[19] ^ lfsr_q[20] ^ lfsr_q[21] ^ lfsr_q[22] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[31] ^ data_in[1] ^ data_in[4] ^ data_in[5] ^ data_in[7] ^ data_in[8] ^ data_in[10] ^ data_in[11] ^ data_in[13] ^ data_in[14] ^ data_in[15] ^ data_in[17] ^ data_in[19] ^ data_in[20] ^ data_in[21] ^ data_in[22] ^ data_in[25] ^ data_in[26] ^ data_in[27] ^ data_in[28] ^ data_in[29] ^ data_in[31];
    lfsr_cB[20] = lfsr_q[2] ^ lfsr_q[5] ^ lfsr_q[6] ^ lfsr_q[8] ^ lfsr_q[9] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[14] ^ lfsr_q[15] ^ lfsr_q[16] ^ lfsr_q[18] ^ lfsr_q[20] ^ lfsr_q[21] ^ lfsr_q[22] ^ lfsr_q[23] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[30] ^ data_in[2] ^ data_in[5] ^ data_in[6] ^ data_in[8] ^ data_in[9] ^ data_in[11] ^ data_in[12] ^ data_in[14] ^ data_in[15] ^ data_in[16] ^ data_in[18] ^ data_in[20] ^ data_in[21] ^ data_in[22] ^ data_in[23] ^ data_in[26] ^ data_in[27] ^ data_in[28] ^ data_in[29] ^ data_in[30];
    lfsr_cB[21] = lfsr_q[3] ^ lfsr_q[6] ^ lfsr_q[7] ^ lfsr_q[9] ^ lfsr_q[10] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[15] ^ lfsr_q[16] ^ lfsr_q[17] ^ lfsr_q[19] ^ lfsr_q[21] ^ lfsr_q[22] ^ lfsr_q[23] ^ lfsr_q[24] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[30] ^ lfsr_q[31] ^ data_in[3] ^ data_in[6] ^ data_in[7] ^ data_in[9] ^ data_in[10] ^ data_in[12] ^ data_in[13] ^ data_in[15] ^ data_in[16] ^ data_in[17] ^ data_in[19] ^ data_in[21] ^ data_in[22] ^ data_in[23] ^ data_in[24] ^ data_in[27] ^ data_in[28] ^ data_in[29] ^ data_in[30] ^ data_in[31];
    lfsr_cB[22] = lfsr_q[4] ^ lfsr_q[7] ^ lfsr_q[8] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[16] ^ lfsr_q[17] ^ lfsr_q[18] ^ lfsr_q[20] ^ lfsr_q[22] ^ lfsr_q[23] ^ lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[30] ^ lfsr_q[31] ^ data_in[4] ^ data_in[7] ^ data_in[8] ^ data_in[10] ^ data_in[11] ^ data_in[13] ^ data_in[14] ^ data_in[16] ^ data_in[17] ^ data_in[18] ^ data_in[20] ^ data_in[22] ^ data_in[23] ^ data_in[24] ^ data_in[25] ^ data_in[28] ^ data_in[29] ^ data_in[30] ^ data_in[31];
    lfsr_cB[23] = lfsr_q[5] ^ lfsr_q[8] ^ lfsr_q[9] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[14] ^ lfsr_q[15] ^ lfsr_q[17] ^ lfsr_q[18] ^ lfsr_q[19] ^ lfsr_q[21] ^ lfsr_q[23] ^ lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[29] ^ lfsr_q[30] ^ lfsr_q[31] ^ data_in[5] ^ data_in[8] ^ data_in[9] ^ data_in[11] ^ data_in[12] ^ data_in[14] ^ data_in[15] ^ data_in[17] ^ data_in[18] ^ data_in[19] ^ data_in[21] ^ data_in[23] ^ data_in[24] ^ data_in[25] ^ data_in[26] ^ data_in[29] ^ data_in[30] ^ data_in[31];
    lfsr_cB[24] = lfsr_q[6] ^ lfsr_q[9] ^ lfsr_q[10] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[15] ^ lfsr_q[16] ^ lfsr_q[18] ^ lfsr_q[19] ^ lfsr_q[20] ^ lfsr_q[22] ^ lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[30] ^ lfsr_q[31] ^ data_in[6] ^ data_in[9] ^ data_in[10] ^ data_in[12] ^ data_in[13] ^ data_in[15] ^ data_in[16] ^ data_in[18] ^ data_in[19] ^ data_in[20] ^ data_in[22] ^ data_in[24] ^ data_in[25] ^ data_in[26] ^ data_in[27] ^ data_in[30] ^ data_in[31];
    lfsr_cB[25] = lfsr_q[7] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[16] ^ lfsr_q[17] ^ lfsr_q[19] ^ lfsr_q[20] ^ lfsr_q[21] ^ lfsr_q[23] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[31] ^ data_in[7] ^ data_in[10] ^ data_in[11] ^ data_in[13] ^ data_in[14] ^ data_in[16] ^ data_in[17] ^ data_in[19] ^ data_in[20] ^ data_in[21] ^ data_in[23] ^ data_in[25] ^ data_in[26] ^ data_in[27] ^ data_in[28] ^ data_in[31];
    lfsr_cB[26] = lfsr_q[8] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[14] ^ lfsr_q[15] ^ lfsr_q[17] ^ lfsr_q[18] ^ lfsr_q[20] ^ lfsr_q[21] ^ lfsr_q[22] ^ lfsr_q[24] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[29] ^ data_in[8] ^ data_in[11] ^ data_in[12] ^ data_in[14] ^ data_in[15] ^ data_in[17] ^ data_in[18] ^ data_in[20] ^ data_in[21] ^ data_in[22] ^ data_in[24] ^ data_in[26] ^ data_in[27] ^ data_in[28] ^ data_in[29];
    lfsr_cB[27] = lfsr_q[9] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[15] ^ lfsr_q[16] ^ lfsr_q[18] ^ lfsr_q[19] ^ lfsr_q[21] ^ lfsr_q[22] ^ lfsr_q[23] ^ lfsr_q[25] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[30] ^ data_in[9] ^ data_in[12] ^ data_in[13] ^ data_in[15] ^ data_in[16] ^ data_in[18] ^ data_in[19] ^ data_in[21] ^ data_in[22] ^ data_in[23] ^ data_in[25] ^ data_in[27] ^ data_in[28] ^ data_in[29] ^ data_in[30];
    lfsr_cB[28] = lfsr_q[10] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[16] ^ lfsr_q[17] ^ lfsr_q[19] ^ lfsr_q[20] ^ lfsr_q[22] ^ lfsr_q[23] ^ lfsr_q[24] ^ lfsr_q[26] ^ lfsr_q[28] ^ lfsr_q[29] ^ lfsr_q[30] ^ lfsr_q[31] ^ data_in[10] ^ data_in[13] ^ data_in[14] ^ data_in[16] ^ data_in[17] ^ data_in[19] ^ data_in[20] ^ data_in[22] ^ data_in[23] ^ data_in[24] ^ data_in[26] ^ data_in[28] ^ data_in[29] ^ data_in[30] ^ data_in[31];
    lfsr_cB[29] = lfsr_q[0] ^ lfsr_q[3] ^ lfsr_q[6] ^ lfsr_q[9] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[17] ^ lfsr_q[18] ^ lfsr_q[23] ^ lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[28] ^ lfsr_q[30] ^ data_in[0] ^ data_in[3] ^ data_in[6] ^ data_in[9] ^ data_in[11] ^ data_in[12] ^ data_in[17] ^ data_in[18] ^ data_in[23] ^ data_in[24] ^ data_in[25] ^ data_in[26] ^ data_in[28] ^ data_in[30];
    lfsr_cB[30] = lfsr_q[1] ^ lfsr_q[4] ^ lfsr_q[7] ^ lfsr_q[10] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[18] ^ lfsr_q[19] ^ lfsr_q[24] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[29] ^ lfsr_q[31] ^ data_in[1] ^ data_in[4] ^ data_in[7] ^ data_in[10] ^ data_in[12] ^ data_in[13] ^ data_in[18] ^ data_in[19] ^ data_in[24] ^ data_in[25] ^ data_in[26] ^ data_in[27] ^ data_in[29] ^ data_in[31];
    lfsr_cB[31] = lfsr_q[2] ^ lfsr_q[5] ^ lfsr_q[8] ^ lfsr_q[11] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[19] ^ lfsr_q[20] ^ lfsr_q[25] ^ lfsr_q[26] ^ lfsr_q[27] ^ lfsr_q[28] ^ lfsr_q[30] ^ data_in[2] ^ data_in[5] ^ data_in[8] ^ data_in[11] ^ data_in[13] ^ data_in[14] ^ data_in[19] ^ data_in[20] ^ data_in[25] ^ data_in[26] ^ data_in[27] ^ data_in[28] ^ data_in[30];


	for (int i=0; i<32; i++){
		if (lfsr_cB[i]) lfsr_c[i]='1';
		else lfsr_c[i]='0';
	}

	//swap bits
	for (int i=0; i<32; i++) lfsr_q[i]=lfsr_c[31-i];

	return bin2dec(lfsr_q);
}

int main(int argc, char *argv[])
{
    unsigned int i, j, crc_value, line_count, line_value;
    int crc_block, crc_count;
    bool flag;
    string value, line, secded_word;
    char secded_words[32];
    ifstream inFile;
    ofstream outFile;
    crc32 crc;

    // Arguments check
    if (argc<4){
        cout << "ERROR: Missing input parameters" << endl;
        exit(1);
    }

    value=argv[argc-2];

    if (!isdigit(value[0]) && (value[0]!='-')){
        cout << "ERROR: Wrong input parameters" << endl;
        exit(1);
    }
    for(i=1;i<value.size();i++)
        if (!isdigit(value[i])){
            cout << "ERROR: Wrong input parameters" << endl;
            exit(1);
        }

    crc_block=atoi(argv[argc-2]);
    if ((crc_block==1) || (crc_block>496)){
        cout << "ERROR: Wrong input parameters" << endl;
        exit(1);
    }

    outFile.open(argv[argc-1],ios::out);
    if (!outFile){
            cout << "ERROR: Cannot open file " << argv[argc-1] << endl;
            exit(1);
        }
    //////////////////////////////////////////

    // Start writing output file
    outFile << "#ifndef BITSTREAM_H\n#define BITSTREAM_H\n\n" ;

    // Loop over input files
    for (i=0;i<(unsigned int)(argc-3);i++){

        outFile << "const unsigned int bitstream" << i << "[]={";
        // Open file
        inFile.open(argv[i+1],ios::in);
        if (!inFile){
            cout << "ERROR: Cannot open file " << argv[i+1] << endl;
            exit(1);
        }else cout << "Reading file " << argv[i+1] << "...";


        //Scan file and compute number of words
        line_count=0;

        //Discard header lines
        flag=false;
        while(!flag){
            flag=true;
            getline(inFile,line);
            line_value=bin2dec(line);
            if ((line.size()==32) && (line_value==0xFFFFFFFF)) break;
            else flag=false;
            }

        // Count number of words
        line_count++;
        while(1){
            getline(inFile,line);
            if (inFile.eof()) break;
            line_count++;
        }
        if (crc_block>=0)
          outFile << "0x" << hex << setw(8) << setfill('0') << uppercase << line_count+1;
        cout << line_count+1 << " words" << endl;
        inFile.close();

        // Open file
        inFile.open(argv[i+1],ios::in);
        if (!inFile){
            cout << "ERROR: Cannot open file" << argv[i+1] << endl;
            exit(1);
        }
        //Discard header lines
        flag=false;
        while(!flag){
            flag=true;
            getline(inFile,line);
            line_value=bin2dec(line);
            if ((line.size()==32) && (line_value==0xFFFFFFFF)) break;
            else flag=false;
            }

        if (crc_block==0){
            // Print bitstream without CRC signatures
            // Print first line
            outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << line_value;
            for (j=1; j<line_count; j++){ //First word already written
                getline(inFile,line);
                line_value=bin2dec(line);
                outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << line_value;
            }
        }else if (crc_block<0){ // EDAC
            secded_words[0]='0';
            secded_words[8]='0';
            secded_words[16]='0';
            secded_words[24]='0';

            // Compute and print first packet (i.e., 4 encoded words (including line_count))            
            secded_word=encode_word(dec2bin(line_count+1+ceil((line_count+1)/4.0f)+4-((line_count+1)%4)));
            for (int ii=0;ii<7;ii++){
                secded_words[25+ii]=secded_word.at(ii);
            }
            outFile << "0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));

            secded_word=encode_word(line);
            for (int ii=0;ii<7;ii++){
                secded_words[17+ii]=secded_word.at(ii);
            }
            outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));

            getline(inFile,line);
            secded_word=encode_word(line);
            for (int ii=0;ii<7;ii++){
                secded_words[9+ii]=secded_word.at(ii);
            }
            outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));

            getline(inFile,line);
            secded_word=encode_word(line);
            for (int ii=0;ii<7;ii++){
                secded_words[1+ii]=secded_word.at(ii);
            }
            outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));

            outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_words); // End of the first packet

            for (j=1; j<(line_count+1)/4; j++){ //First three bitstream words already read
              getline(inFile,line);
              secded_word=encode_word(line);
              for (int ii=0;ii<7;ii++){
                secded_words[25+ii]=secded_word.at(ii);
              }
              outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));

              getline(inFile,line);
              secded_word=encode_word(line);
              for (int ii=0;ii<7;ii++){
                secded_words[17+ii]=secded_word.at(ii);
              }
              outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));

              getline(inFile,line);
              secded_word=encode_word(line);
              for (int ii=0;ii<7;ii++){
                secded_words[9+ii]=secded_word.at(ii);
              }
              outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));

              getline(inFile,line);
              secded_word=encode_word(line);
              for (int ii=0;ii<7;ii++){
                secded_words[1+ii]=secded_word.at(ii);
              }
              outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));

              outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_words);

            }

            if (((line_count+1)%4) !=0){
                switch ((line_count+1)%4){
                  case 1:
                    getline(inFile,line);
                    secded_word=encode_word(line);
                    for (int ii=0;ii<7;ii++){
                      secded_words[25+ii]=secded_word.at(ii);
                      secded_words[1+ii]=secded_word.at(ii);
                      secded_words[9+ii]=secded_word.at(ii);
                      secded_words[17+ii]=secded_word.at(ii);
                    }
                    //for (int ii=0;ii<24;ii++){
                    //  secded_words[ii]='0';
                    //}
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_words);
                    break;

                  case 2:
                    getline(inFile,line);
                    secded_word=encode_word(line);
                    for (int ii=0;ii<7;ii++){
                      secded_words[25+ii]=secded_word.at(ii);
                    }
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));

                    getline(inFile,line);
                    secded_word=encode_word(line);
                    for (int ii=0;ii<7;ii++){
                      secded_words[17+ii]=secded_word.at(ii);
                      secded_words[1+ii]=secded_word.at(ii);
                      secded_words[9+ii]=secded_word.at(ii);
                    }
                    //for (int ii=0;ii<16;ii++){
                    //  secded_words[ii]='0';
                    //}
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_words);
                    break;

                  case 3:
                    getline(inFile,line);
                    secded_word=encode_word(line);
                    for (int ii=0;ii<7;ii++){
                      secded_words[25+ii]=secded_word.at(ii);
                    }
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));

                    getline(inFile,line);
                    secded_word=encode_word(line);
                    for (int ii=0;ii<7;ii++){
                      secded_words[17+ii]=secded_word.at(ii);
                    }
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));

                    getline(inFile,line);
                    secded_word=encode_word(line);
                    for (int ii=0;ii<7;ii++){
                      secded_words[9+ii]=secded_word.at(ii);
                      secded_words[1+ii]=secded_word.at(ii);
                    }
                    //for (int ii=0;ii<8;ii++){
                    //  secded_words[ii]='0';
                    //}
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_word.substr(7,38));
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << bin2dec(secded_words);
                    break;
                }
            }
        }else{ // Print bitstream with CRC signatures
        	// Print first line
            outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << line_value;
            crc_count=0;
            crc.crc32_init();
            crc_value=crc.crc32_koopmanII(dec2bin(line_count+1));
            crc_value=crc.crc32_koopmanII(line);
            crc_count+=2;
            if (crc_block==2){
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << crc_value;
                    crc_count=0;
                    }
            for (j=1; j<line_count; j++){ //First word already written
                getline(inFile,line);
                line_value=bin2dec(line);
                crc_value=crc.crc32_koopmanII(line);
                crc_count++;
                outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << line_value;
                if ((crc_count==crc_block) || (j==line_count-1)){
                    outFile << ",0x" << hex << setw(8) << setfill('0') << uppercase << crc_value;
                    crc_count=0;
                }

            }
        }

        outFile << "};\n";
        inFile.close();

    }

    outFile << "\n#endif\n";
    outFile.close();

    cout << "File " << argv[argc-1] << " generated" << endl;
    return 0;

}
