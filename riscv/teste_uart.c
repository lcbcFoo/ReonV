int fib();
#include <stdio.h>

int main(){
	int n = 8;

	// Allocates memory for arrays
	int* array = (int*)sbrk(n * sizeof(int));
	int* array2 = (int*)sbrk(n * sizeof(int));

	// Calculates fib(i), 1 <= i <= n
	for(int i = 1; i <= n; i++)
		array[i-1] = fib(i);

	// Writes results on output memory section
	write(0, array,n * sizeof(int));

	// Sets pointer to beginning of output memory section
	lseek(0, -n*sizeof(int), SEEK_CUR);

	// Reads the results into array2
	read(0, array2, n * sizeof(int));

	// Checks if they were copied correctly
	int correct = 0xAAAAAAAA;
	for(int i = 0; i < n; i++)
		if(array[i] != array2[i])
			correct = 0xBBBBBBBB;

	// Writes the check into output memory section
	write(0, &correct, sizeof(int));
}

int fib(int i){
	if(i == 1 || i == 2)
		return 1;
	return fib(i-1) + fib(i-2);
}
