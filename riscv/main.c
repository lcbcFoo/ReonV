int mul();
int fib();
#include <stdio.h>

int main(){
	// int i[3] = {0xF1E2D3C4, 0x12345678, 0xACB45321};
	//
	int count = 0xDDDDDDDD;
	// int j[3] = {0xECECECEC, 0xBBBBBBBB, 0x01010202};

	int* array = (int*)sbrk(4 * sizeof(int));
	int* array2 = (int*)sbrk(2 * sizeof(int));

	int cc = 0xcccccccc;
	array[0] = 0xAAAABBBB;
	array[1] = 0xCCCCDDDD;
	array[2] = 0xEEEEFFFF;
	array[3] = 0x1111AAAA;
	array2[0] = 0x2222BBBB;
	array2[1] = 0x3333CCCC;

	// Multiplies i by 4
	//do{
	//	i = mul(i,3);
	//	__asm("mv x31,a0");
	//	count++;
	//}while(i < 2500);

	//i = fib(i);	// fib(16) = 987 = 0x3DB

	//dbgleon_printf("%d", i);
	// bsp_debug_uart_init();
	// apbuart_write_polled(&i, sizeof(int));

	// write(0,&i,3 * sizeof(int));
	// lseek(0, -3*sizeof(int), SEEK_CUR);
	// read(0, &j, 3 * sizeof(int));
}

int fib(int i){
	if(i == 1 || i == 2)
		return 1;
	return fib(i-1) + fib(i-2);
}
