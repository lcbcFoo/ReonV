int fib(int i);

void _start(){
	int i = 5;
	int j = fib(i);
}

int fib(int i){
	if(i == 2 || i == 1)
		return 1;
	return fib(i-1) + fib(i-2);
}
