#include <stdio.h>
#include <stdlib.h>

#include "decoder.h"
#include "memory.h"

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        printf("Usage: %s <hex_file>\n", argv[0]);
        return EXIT_FAILURE;
    }

    size_t count = 0;

    uint32_t *instructions = load_hex(argv[1], &count);

    if (instructions == NULL)
    {
        fprintf(stderr, "Error: Unable to load %s\n", argv[1]);
        return EXIT_FAILURE;
    }

    printf("RISC-V RV32I Instruction Decoder\n");
    printf("=========================================\n");
    printf("Loaded %zu instructions from %s\n\n", count, argv[1]);

    printf("%-12s %-12s %s\n", "Address", "Hex", "Assembly");
    printf("--------------------------------------------------------\n");

    char assembly[128];

    for (size_t i = 0; i < count; i++)
    {
        decode_instruction(i * 4, instructions[i], assembly);

        printf("0x%08X %-12.8X %s\n",
               (unsigned)(i * 4),
               instructions[i],
               assembly + 11);
    }

    free(instructions);

    return EXIT_SUCCESS;
}