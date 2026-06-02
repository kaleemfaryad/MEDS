#include <stdio.h>
#include <stdint.h>
#include "decoder.h"

int main(void)
{
  uint32_t instruction = 0x00A28233;

  printf("Instruction: 0x%08X\n", instruction);
  printf("Opcode: 0x%02X\n",
         decode_opcode(instruction));

  return 0;
}