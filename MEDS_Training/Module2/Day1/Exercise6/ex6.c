#include <stdio.h>
#include <stdint.h>

uint32_t pack_r_type(uint32_t opcode,
                     uint32_t rd,
                     uint32_t funct3,
                     uint32_t rs1,
                     uint32_t rs2,
                     uint32_t funct7)
{
    return (funct7 << 25) |
           (rs2 << 20) |
           (rs1 << 15) |
           (funct3 << 12) |
           (rd << 7) |
           opcode;
}

int main() {

    uint32_t instruction =
        pack_r_type(0x33,
                    4,
                    0,
                    5,
                    10,
                    0);

    printf("Instruction = 0x%08X\n",
           instruction);

    return 0;
}
