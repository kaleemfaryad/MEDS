#include <stdio.h>
#include <stdint.h>

uint32_t extract_field(uint32_t instruction,
                       int high,
                       int low)
{
    return (instruction >> low) &
           ((1U << (high - low + 1)) - 1);
}

int main() {

    uint32_t instruction = 0x00A28233;

    printf("opcode = 0x%X\n",
           extract_field(instruction, 6, 0));

    printf("rd = x%u\n",
           extract_field(instruction, 11, 7));

    printf("funct3 = %u\n",
           extract_field(instruction, 14, 12));

    printf("rs1 = x%u\n",
           extract_field(instruction, 19, 15));

    printf("rs2 = x%u\n",
           extract_field(instruction, 24, 20));

    printf("funct7 = 0x%X\n",
           extract_field(instruction, 31, 25));

    return 0;
}
