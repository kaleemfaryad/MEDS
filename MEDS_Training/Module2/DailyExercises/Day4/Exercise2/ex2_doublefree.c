#include <stdlib.h>

int main()
{
  int *p = malloc(10);

  free(p);
  free(p); // BUG

  return 0;
}