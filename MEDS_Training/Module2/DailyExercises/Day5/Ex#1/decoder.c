#include "decoder.h"

uint32_t decode_opcode(uint32_t instruction)
{
    return instruction & 0x7F;
}