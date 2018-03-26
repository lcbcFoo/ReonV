int fib();
#include <stdio.h>
#include "mini_printf.h"

int main(){
	int n = 20;

	printf("Testing fib calculator, array dealing, write, read and lseek functions\n\n");

	// Allocates memory for arrays
	int* array = (int*)sbrk(n * sizeof(int));
	int* array2 = (int*)sbrk(n * sizeof(int));

	printf("Address array 1: 0x%x\n", array);
	printf("Address array 2: 0x%x\n", array2);

	// Calculates fib(i), 1 <= i <= n
	for(int i = 1; i <= n; i++)
		array[i-1] = fib(i);

	// Uses console
	for(int i = 1; i <= n; i++)
		printf("Fib(%02d) = %04d\n", i, array[i-1]);

	// Writes results on output memory section
	write(3, array,n * sizeof(int));

	// Sets pointer to beginning of output memory section
	lseek(3, -n*sizeof(int), SEEK_CUR);

	// Reads the results into array2
	read(3, array2, n * sizeof(int));

	// Checks if they were copied correctly
	int correct = 1;
	for(int i = 0; i < n; i++)
		if(array[i] != array2[i])
			correct = 0;

	if(correct)
		printf("\nCopied array1 into array2!\n");
	else
		printf("Oh no, error!\n");

	printf("\n\nTesting printf\n\n");
	int d = 1234567890;
	int neg = -987654321;
	unsigned int u = 0xff123456;
	char s[] = "This is a string";
	char a = 'A';
	printf("Testing big int:  1234567890 = %d\nBig int in hex:   0x499602d2 = 0x%x\n", d, d);
	printf("Testing negative: -987654321 = %d\nNegative in hex:  0xC521974F = 0x%x\n", neg, neg);
	printf("Testing unsigned: 4279383126 = %u\nUnsigned in hex:  0xff123456 = 0x%x\n", u, u);
	printf("This is a string = %s\n", s);
	printf("%c comes after %c which comes after %c!\n", a + 2, a + 1, a);
	printf("\n\nFinished main!\n\n");
	return 0;
}

int fib(int i){
	if(i == 1 || i == 2)
		return 1;
	return fib(i-1) + fib(i-2);
}
