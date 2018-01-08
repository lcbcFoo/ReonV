int mul();

void main(){
	int i = 1;
	int count = 0;

	// Multiplies i by 4
	do{
		i = mul(i,4);
		count++;
	}while(i < 2500);
}

int mul(int i,int j){
	if (i == 0)
		return 0;
	return mul(i - 1,j) + j;
}
