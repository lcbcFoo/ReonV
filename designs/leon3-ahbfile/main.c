#include <stdio.h>

int main(void)
{
  int c;
  puts("internet2");
  c = getchar();
  if (EOF == c) {
    puts("got EOF!");
  } else {
    puts("got char: ");
    putchar(c);
  }
  return 0;
}

