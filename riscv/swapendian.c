/*	Author: Lucas Castro
 *  Date:   10/09/2017
 *
 * Swaps the "endian" of a binary file (little to big or big to little)
 */

#include <stdio.h>
#include <stdint.h>

int main(int argc, char* argv[]){
	uint32_t word;
	uint32_t b0,b1,b2,b3;
	uint32_t res;
	unsigned char in_name[30];
	unsigned char out_name[30];
	FILE* input;
	FILE* output;

	if(argc != 3){
		printf("Usage: ./main <input bin file> <output bin file>\n");
		return 1;
	}

	input = fopen(argv[1], "rb");
	output = fopen(argv[2], "wb");

	if(input == NULL){
		printf("Error opening input!\n");
		return 1;
	}
	if(output == NULL){
		fclose(input);
		printf("Error opening output!\n");
		return 1;
	}

	while(fread(&word, sizeof(uint32_t), 1, input)){
		b0 = (word & 0x000000ff) << 24u;
		b1 = (word & 0x0000ff00) << 8u;
		b2 = (word & 0x00ff0000) >> 8u;
		b3 = (word & 0xff000000) >> 24u;

		res = b0 | b1 | b2 | b3;

		fwrite(&res, sizeof(uint32_t), 1, output);
	}

	fclose(input);
	fclose(output);

	return 0;
}
