#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main()
{
  uint8_t memory[4];

  uint32_t word = 0xDEADBEEF;

  memory[0] = (word >> 0) & 0xFF;
  memory[1] = (word >> 8) & 0xFF;
  memory[2] = (word >> 16) & 0xFF;
  memory[3] = (word >> 24) & 0xFF;

  printf("Memory bytes:\n");
  for (int i = 0; i < 4; i++)
  {
    printf("%02X ", memory[i]);
  }

  printf("\n");

  return 0;
}