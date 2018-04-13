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
#define NUMELEMS 100

int vector[NUMELEMS];
int res[NUMELEMS];

int Initialize(vector)
int vector[];
/*
 * Initializes given vector with randomly generated integers.
 */
{
    int  Index;

    for (Index = 0; Index < NUMELEMS; Index ++)
        vector[NUMELEMS - Index - 1] = Index * KNOWN_VALUE;


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
    int sorted = 1;
    for(int j = 0; j < NUMELEMS -1 ; j++)
        if(vector[j] > vector[j + 1]){
            printf("%d\n", 0);
            return;
        }
    printf("%d\n", 1);
}


int main()
{
   Initialize(vector);
   BubbleSort(vector);
   return 0;
}
