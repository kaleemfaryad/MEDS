#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

void print_binary(uint32_t value) {

    for (int i = 31; i >= 0; i--) {

        printf("%u", (value >> i) & 1U);

        if (i % 4 == 0)
            printf(" ");
    }

    printf("\n");
}

int main(int argc, char *argv[]) {

    if (argc != 2) {
        printf("Usage: %s <32-bit-hex>\n", argv[0]);
        return 1;
    }

    uint32_t value =
        (uint32_t)strtoul(argv[1], NULL, 16);

    printf("Hexadecimal : 0x%08X\n", value);

    printf("Unsigned    : %u\n", value);

    printf("Signed      : %d\n", (int32_t)value);

    printf("Binary      : ");

    print_binary(value);

    return 0;
}