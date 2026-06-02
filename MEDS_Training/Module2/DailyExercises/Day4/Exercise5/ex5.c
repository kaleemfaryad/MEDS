#include <stdio.h>
#include <stdlib.h>

int compute(int *arr, int size)
{
  int sum;
  for (int i = 0; i <= size; i++) // BUG 1 (<=)
  {
    sum += arr[i]; // BUG 2 (uninitialized sum + overflow)
  }
  return sum;
}

int main()
{
  int *arr = malloc(5 * sizeof(int));

  for (int i = 0; i < 5; i++)
    arr[i] = i + 1;

  int result = compute(arr, 5);

  printf("Result = %d\n", result);

  free(arr);
  return 0;
}