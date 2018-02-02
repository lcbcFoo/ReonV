int mul();
int fib();
#include <stdio.h>
int main(){
	int i = 3;
	int count = 0;

	// Multiplies i by 4
	//do{
	//	i = mul(i,3);
	//	__asm("mv x31,a0");
	//	count++;
	//}while(i < 2500);

	i = fib(i);

	//printf("i = \n", i);
	return i;
}

int fib(int i){
	if(i == 1 || i == 2)
		return 1;
	return fib(i-1) + fib(i-2);
}

int mul(int i,int j){
	return i*j;
}
