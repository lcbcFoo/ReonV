/*	Author: Lucas Castro
 *  Date:   10/09/2017
 *
 * Reads a binary file and converts its content to readable hexadecimal
 */

#include <stdio.h>
#include <stdint.h>

int main(int argc, char** argv){
	char word;
	char res[8];
	uint8_t i = 0;
	FILE* input;
	FILE* output;

	if(argc != 3){
		printf("Usage: ./<program name> <input bin file> <output readable hex file>\n");
		return 1;
	}

	input = fopen(argv[1], "rb");
	output = fopen(argv[2], "w");

	if(input == NULL){
		printf("Error opening input!\n");
		return 1;
	}
	if(output == NULL){
		fclose(input);
		printf("Error opening output!\n");
		return 1;
	}

	while(fread(&word, sizeof(unsigned char), 1, input)){
		sprintf(res, "%02X", (unsigned char) word & 0xff);
		fwrite(&res, sizeof(unsigned char), 2, output);

		i++;
		if(i == 4){
			fwrite("\n", sizeof(char), 1, output);
			i = 0;
		}
	}

	fclose(input);
	fclose(output);

	return 0;
}
