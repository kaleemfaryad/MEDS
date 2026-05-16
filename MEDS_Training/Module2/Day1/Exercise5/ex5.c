#include <stdio.h>
#include <stdint.h>

int32_t sign_extend(uint32_t val,
                    int bit_width)
{
    uint32_t sign_bit =
        1U << (bit_width - 1);

    return (int32_t)
           ((val ^ sign_bit) - sign_bit);
}

int main() {

    int32_t x = sign_extend(0xFFF, 12);

    printf("Decimal : %d\n", x);

    printf("Hex     : 0x%08X\n",
           (uint32_t)x);

    return 0;
}
