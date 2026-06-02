#include <stdio.h>

#ifdef DEBUG

#define LOG(fmt, ...) \
  fprintf(stderr, "[DEBUG] " fmt "\n", ##__VA_ARGS__)

#else

#define LOG(fmt, ...)

#endif

int main(void)
{
  LOG("Program started");

  int x = 10;

  LOG("x = %d", x);

  printf("Program running\n");

  return 0;
}