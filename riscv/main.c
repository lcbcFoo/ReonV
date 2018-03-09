int mul();
int fib();
#include <stdio.h>

int main(){
	// int* array = (int*)sbrk(4 * sizeof(int));
	// int* array2 = (int*)sbrk(2 * sizeof(int));
	//
	// array[0] = 0xAAAABBBB;
	// array[1] = 0xCCCCDDDD;
	// array[2] = 0xEEEEFFFF;
	// array[3] = 0x1111AAAA;
	// array2[0] = 0x2222BBBB;
	// array2[1] = 0x3333CCCC;
	//
	// write(0, array,4 * sizeof(int));
	// lseek(0, -4*sizeof(int), SEEK_CUR);
	// read(0, array2, 2 * sizeof(int));

	int n = 16;
	int* array = (int*)sbrk(n * sizeof(int));
	int* array2 = (int*)sbrk(n * sizeof(int));

	for(int i = 1; i <= n; i++)
		array[i-1] = fib(i);

	write(0, array,n * sizeof(int));
	lseek(0, -n*sizeof(int), SEEK_CUR);
	read(0, array2, n * sizeof(int));

	int correct = 0xAAAABBBB;
	for(int i = 0; i < n; i++)
		if(array[i] != array2[i])
			correct = 0xCCCCDDDD;
	write(0, &correct, sizeof(int));
}

int fib(int i){
	if(i == 1 || i == 2)
		return 1;
	return fib(i-1) + fib(i-2);
}
