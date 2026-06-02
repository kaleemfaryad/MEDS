#include <stdio.h>
#include <stdint.h>

void write_reg(
    uint32_t *regs,
    uint8_t rd,
    uint32_t value)
{

    if (rd == 0)
        return;

    regs[rd] = value;
}

uint32_t read_reg(
    const uint32_t *regs,
    uint8_t rs)
{
    return regs[rs];
}

int main()
{

    uint32_t regs[32] = {0};

    write_reg(regs, 5, 100);

    write_reg(regs, 10, 200);

    write_reg(regs, 0, 999);

    printf("x0 = %u\n",
           read_reg(regs, 0));

    printf("x5 = %u\n",
           read_reg(regs, 5));

    printf("x10 = %u\n",
           read_reg(regs, 10));

    return 0;
}
