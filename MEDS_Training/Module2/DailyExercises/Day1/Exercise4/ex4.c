#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

uint32_t extract(uint32_t x, int h, int l) {
    return (x >> l) &
           ((1U << (h - l + 1)) - 1);
}

int main(int argc, char *argv[]) {

    if (argc != 2) {
        printf("Usage: %s <instruction>\n", argv[0]);
        return 1;
    }

    uint32_t instruction =
        (uint32_t)strtoul(argv[1], NULL, 16);

    printf("Instruction : 0x%08X\n", instruction);

    printf("opcode : 0x%X\n",
           extract(instruction, 6, 0));

    printf("rd      : x%u\n",
           extract(instruction, 11, 7));

    printf("funct3  : %u\n",
           extract(instruction, 14, 12));

    printf("rs1     : x%u\n",
           extract(instruction, 19, 15));

    printf("rs2     : x%u\n",
           extract(instruction, 24, 20));

    printf("funct7  : 0x%X\n",
           extract(instruction, 31, 25));

    return 0;
}
