/* 
 * This file is part of the ReonV distribution (https://github.com/lcbcFoo/ReonV).
 * Copyright (c) 2018 to Lucas C. B. Castro.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/*	Author: Lucas C. B. Castro
 *  Description: Reads a binary file and converts its content to readable
 * 				 hexadecimal
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

        // Force output to always end with \n 
        if(i != 0)
	    fwrite("\n", sizeof(char), 1, output);
	fclose(input);
	fclose(output);

	return 0;
}
