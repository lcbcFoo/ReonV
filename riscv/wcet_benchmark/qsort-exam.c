#ifdef TEST
    #include "../mini_printf.h"
    #include "../posix_c.h"
#else
    #include <stdio.h>
#endif

void swap(float* a, float* b){
    float t = (*a);
    (*a) = (*b);
    (*b) = t;
}

int pivoting(float arr[],int b, int e){
    int pivot = (b + e) / 2;
    swap(&arr[pivot], &arr[e]);
    pivot = b;
    for(int i = b; i < e; i++){
        if(arr[i] <= arr[e])
            swap(&arr[i], &arr[pivot++]);
    }
    swap(&arr[pivot], &arr[e]);

    return pivot;
}

void sort(float arr[],int b, int e){
    if(b >= e)
        return;
    int pivot = pivoting(arr, b, e);
    sort(arr, b, pivot - 1);
    sort(arr, pivot + 1, e);
}


int main()
{

  float arr[60] = {
      5, 4, 10.3, 1.1, 5.7, 100, 231, 111, 49.5, 99,
      10, 150, 222.22, 101, 77, 44, 35, 20.54, 99.99, 88.88,
      114.1, 1.2, 55.4, 77.6, 29.4, 30.50, 66.4, 187.6, 215.2, 60,
      25, 34, 110.3, 21.1, 15.7, 1010, 1231, 3111, 249.5, 199,
      1510, 1950, 2322.22, 1031, 787, 0.44, 6.35, 250.54, 979.99, 838.88,
      1184.1, 31.2, 455.4, 747.6, 292.4, 301.50, 666.4, 186.6, 235.2, 0
  };

  sort(arr, 0, 60-1);

  for(int i = 0; i < 60-1; i++){
      if(arr[i] > arr[i + 1]){
          printf("%d\n", 0);
          return 0;
      }
  }
  printf("%d\n", 1);
  return 0;
}
