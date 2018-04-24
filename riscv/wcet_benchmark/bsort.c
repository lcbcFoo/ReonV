/* bsort100.c */

/* All output disabled for wcsim */
//#define WCSIM 0

#ifdef TEST
    #include "../mini_printf.h"
    #include "../posix_c.h"
#else
    #include <stdio.h>
#endif

/* A read from this address will result in an known value of 1 */
#define KNOWN_VALUE 0x87

#define WORSTCASE 1
#define FALSE 0
#define TRUE 1
#define NUMELEMS 1500
#define SEED 84571
int vector[NUMELEMS];
int res[NUMELEMS];

int gen_i(int a){
    int b = SEED * (a + 13) % 66987;
    b ^= (a * b + 1) % 98746;
    return b;
}

int Initialize(vector)
int vector[];
/*
 * Initializes given vector with randomly generated integers.
 */
{
    int  Index;
    vector[NUMELEMS - 1] = gen_i(374651);

    for (Index = 1; Index < NUMELEMS; Index ++)
        vector[NUMELEMS - Index - 1] = gen_i(vector[NUMELEMS - Index]);

}


void BubbleSort(vector)
int vector[];
/*
 * Sorts an vector of integers of size NUMELEMS in ascending order.
 */
{
    int n = NUMELEMS;
    int k, j, aux, i = 0;
    for (k = 1; k < n; k++) {
        for (j = 0; j < n - 1; j++) {
            if (vector[j] > vector[j + 1]) {
                i++;
                aux          = vector[j];
                vector[j]     = vector[j + 1];
                vector[j + 1] = aux;
            }
        }
    }

#ifdef TEST
    for(int i = 0; i < NUMELEMS -1 ; i++){
        if(vector[i] > vector[i + 1]){
            j = 0;
            memcpy(out_mem, &j, sizeof(int));
            return;
        }
    }

    j = 1;
    memcpy(out_mem, &j, sizeof(int));
#endif
}


int main()
{
   Initialize(vector);
   BubbleSort(vector);
   return 0;
}
