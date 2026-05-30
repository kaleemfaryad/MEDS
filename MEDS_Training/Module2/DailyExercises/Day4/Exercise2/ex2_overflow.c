#include <stdlib.h>

int main()
{
  int *arr = malloc(5 * sizeof(int));

  arr[5] = 100; // BUG (valid: 0–4)

  free(arr);

  return 0;
}