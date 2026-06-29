#include <stdio.h>
#include <string.h>
#include "../include/decoder.h"

int main(void)
{
    char out[128];

    printf("=========================================\n");
    printf("     RISC-V Decoder Unit Tests\n");
    printf("=========================================\n\n");

    /* ---------- R-Type ---------- */

    decode_instruction(0x00000000, 0x003100B3, out);
    printf("Test 1 (ADD):\n");
    printf("%s\n\n", out);

    decode_instruction(0x00000004, 0x40310133, out);
    printf("Test 2 (SUB):\n");
    printf("%s\n\n", out);

    decode_instruction(0x00000008, 0x003170B3, out);
    printf("Test 3 (AND):\n");
    printf("%s\n\n", out);

    decode_instruction(0x0000000C, 0x003160B3, out);
    printf("Test 4 (OR):\n");
    printf("%s\n\n", out);

    /* ---------- I-Type ---------- */

    decode_instruction(0x00000010, 0x00500113, out);
    printf("Test 5 (ADDI):\n");
    printf("%s\n\n", out);

    decode_instruction(0x00000014, 0x0050F113, out);
    printf("Test 6 (ANDI):\n");
    printf("%s\n\n", out);

    decode_instruction(0x00000018, 0x00506113, out);
    printf("Test 7 (ORI):\n");
    printf("%s\n\n", out);

    /* ---------- LOAD ---------- */

    decode_instruction(0x0000001C, 0x0000A103, out);
    printf("Test 8 (LW):\n");
    printf("%s\n\n", out);

    /* ---------- STORE ---------- */

    decode_instruction(0x00000020, 0x0020A023, out);
    printf("Test 9 (SW):\n");
    printf("%s\n\n", out);

    /* ---------- BRANCH ---------- */

    decode_instruction(0x00000024, 0x00108063, out);
    printf("Test 10 (BEQ):\n");
    printf("%s\n\n", out);

    decode_instruction(0x00000028, 0xFE209CE3, out);
    printf("Test 11 (BNE):\n");
    printf("%s\n\n", out);

    /* ---------- U-Type ---------- */

    decode_instruction(0x0000002C, 0x000010B7, out);
    printf("Test 12 (LUI):\n");
    printf("%s\n\n", out);

    decode_instruction(0x00000030, 0x00001117, out);
    printf("Test 13 (AUIPC):\n");
    printf("%s\n\n", out);

    /* ---------- J-Type ---------- */

    decode_instruction(0x00000034, 0x004000EF, out);
    printf("Test 14 (JAL):\n");
    printf("%s\n\n", out);

    decode_instruction(0x00000038, 0x00008067, out);
    printf("Test 15 (JALR):\n");
    printf("%s\n\n", out);

    /* ---------- UNKNOWN ---------- */

    decode_instruction(0x0000003C, 0xDEADBEEF, out);
    printf("Test 16 (UNKNOWN):\n");
    printf("%s\n\n", out);

    printf("=========================================\n");
    printf("All decoder tests executed successfully.\n");
    printf("=========================================\n");

    return 0;
}