#include <stdio.h>
#include <stdint.h>

#ifdef RV64

typedef uint64_t reg_t;

#define REG_FMT "0x%016lX"

#else

typedef uint32_t reg_t;

#define REG_FMT "0x%08X"

#endif

int main(void)
{
  reg_t value = 0x12345678;

  printf("Register = " REG_FMT "\n", value);

  return 0;
}