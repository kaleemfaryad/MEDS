#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include "../include/decoder.h"
#include "../include/common.h"

/*=========================================================
    Decode R-Type Instruction
=========================================================*/
void decode_r_type(uint32_t inst, decoded_instr_t *d)
{
    d->opcode  = EXTRACT_BITS(inst, 6,  0);
    d->rd      = EXTRACT_BITS(inst, 11, 7);
    d->funct3  = EXTRACT_BITS(inst, 14, 12);
    d->rs1     = EXTRACT_BITS(inst, 19, 15);
    d->rs2     = EXTRACT_BITS(inst, 24, 20);
    d->funct7  = EXTRACT_BITS(inst, 31, 25);
}

/*=========================================================
    Decode I-Type Instruction
=========================================================*/
void decode_i_type(uint32_t inst, decoded_instr_t *d)
{
    d->opcode  = EXTRACT_BITS(inst, 6,  0);
    d->rd      = EXTRACT_BITS(inst, 11, 7);
    d->funct3  = EXTRACT_BITS(inst, 14, 12);
    d->rs1     = EXTRACT_BITS(inst, 19, 15);
    d->funct7  = EXTRACT_BITS(inst, 31, 25);
    d->imm     = SIGN_EXTEND(EXTRACT_BITS(inst, 31, 20), 12);
}

/*=========================================================
    Decode S-Type Instruction
=========================================================*/
void decode_s_type(uint32_t inst, decoded_instr_t *d)
{
    d->opcode  = EXTRACT_BITS(inst, 6,  0);
    d->funct3  = EXTRACT_BITS(inst, 14, 12);
    d->rs1     = EXTRACT_BITS(inst, 19, 15);
    d->rs2     = EXTRACT_BITS(inst, 24, 20);

    uint32_t imm =
        (EXTRACT_BITS(inst, 31, 25) << 5) |
         EXTRACT_BITS(inst, 11,  7);

    d->imm = SIGN_EXTEND(imm, 12);
}

/*=========================================================
    Decode B-Type Instruction
=========================================================*/
void decode_b_type(uint32_t inst, decoded_instr_t *d)
{
    d->opcode  = EXTRACT_BITS(inst, 6,  0);
    d->funct3  = EXTRACT_BITS(inst, 14, 12);
    d->rs1     = EXTRACT_BITS(inst, 19, 15);
    d->rs2     = EXTRACT_BITS(inst, 24, 20);

    uint32_t imm =
        (EXTRACT_BITS(inst, 31, 31) << 12) |
        (EXTRACT_BITS(inst,  7,  7) << 11) |
        (EXTRACT_BITS(inst, 30, 25) <<  5) |
        (EXTRACT_BITS(inst, 11,  8) <<  1);

    d->imm = SIGN_EXTEND(imm, 13);
}

/*=========================================================
    Decode U-Type Instruction
=========================================================*/
void decode_u_type(uint32_t inst, decoded_instr_t *d)
{
    d->opcode = EXTRACT_BITS(inst, 6, 0);
    d->rd     = EXTRACT_BITS(inst, 11, 7);
    d->imm    = (int32_t)(inst & 0xFFFFF000);
}

/*=========================================================
    Decode J-Type Instruction
=========================================================*/
void decode_j_type(uint32_t inst, decoded_instr_t *d)
{
    d->opcode = EXTRACT_BITS(inst, 6, 0);
    d->rd     = EXTRACT_BITS(inst, 11, 7);

    uint32_t imm =
        (EXTRACT_BITS(inst, 31, 31) << 20) |
        (EXTRACT_BITS(inst, 19, 12) << 12) |
        (EXTRACT_BITS(inst, 20, 20) << 11) |
        (EXTRACT_BITS(inst, 30, 21) <<  1);

    d->imm = SIGN_EXTEND(imm, 21);
}

/*=========================================================
    Decode Complete Instruction
=========================================================*/
void decode_instruction(uint32_t addr,
                        uint32_t inst,
                        char *out)
{
    (void)addr;

    decoded_instr_t d  = {0};
    int             valid = 1;       /* innocent until proven guilty  */
    char            mnemonic[128]  = {0};

    uint32_t opcode = EXTRACT_BITS(inst, 6, 0);

    /*-----------------------------------------------------
     * RV32I: every valid instruction has bits [1:0] == 11.
     * Anything that fails this is immediately UNKNOWN.
     *----------------------------------------------------*/
    if ((inst & 0x3) != 0x3)
    {
        valid = 0;
    }
    else
    {
        switch (opcode)
        {

        /*=================================================
            R-Type Instructions
            Valid funct3 / funct7 combinations are
            explicitly listed; everything else → invalid.
        =================================================*/
        case OP_R_TYPE:

            decode_r_type(inst, &d);

            if      (d.funct3 == 0x0 && d.funct7 == 0x00)
                sprintf(mnemonic, "add x%d, x%d, x%d",  d.rd, d.rs1, d.rs2);

            else if (d.funct3 == 0x0 && d.funct7 == 0x20)
                sprintf(mnemonic, "sub x%d, x%d, x%d",  d.rd, d.rs1, d.rs2);

            else if (d.funct3 == 0x7 && d.funct7 == 0x00)
                sprintf(mnemonic, "and x%d, x%d, x%d",  d.rd, d.rs1, d.rs2);

            else if (d.funct3 == 0x6 && d.funct7 == 0x00)
                sprintf(mnemonic, "or x%d, x%d, x%d",   d.rd, d.rs1, d.rs2);

            else if (d.funct3 == 0x4 && d.funct7 == 0x00)
                sprintf(mnemonic, "xor x%d, x%d, x%d",  d.rd, d.rs1, d.rs2);

            else if (d.funct3 == 0x1 && d.funct7 == 0x00)
                sprintf(mnemonic, "sll x%d, x%d, x%d",  d.rd, d.rs1, d.rs2);

            else if (d.funct3 == 0x5 && d.funct7 == 0x00)
                sprintf(mnemonic, "srl x%d, x%d, x%d",  d.rd, d.rs1, d.rs2);

            else if (d.funct3 == 0x5 && d.funct7 == 0x20)
                sprintf(mnemonic, "sra x%d, x%d, x%d",  d.rd, d.rs1, d.rs2);

            else if (d.funct3 == 0x2 && d.funct7 == 0x00)
                sprintf(mnemonic, "slt x%d, x%d, x%d",  d.rd, d.rs1, d.rs2);

            else if (d.funct3 == 0x3 && d.funct7 == 0x00)
                sprintf(mnemonic, "sltu x%d, x%d, x%d", d.rd, d.rs1, d.rs2);

            else
                valid = 0;

            break;

        /*=================================================
            I-Type Arithmetic Instructions
        =================================================*/
        case OP_I_TYPE:

            decode_i_type(inst, &d);

            if      (d.funct3 == 0x0)
                sprintf(mnemonic, "addi x%d, x%d, %d",  d.rd, d.rs1, d.imm);

            else if (d.funct3 == 0x7)
                sprintf(mnemonic, "andi x%d, x%d, %d",  d.rd, d.rs1, d.imm);

            else if (d.funct3 == 0x6)
                sprintf(mnemonic, "ori x%d, x%d, %d",   d.rd, d.rs1, d.imm);

            else if (d.funct3 == 0x4)
                sprintf(mnemonic, "xori x%d, x%d, %d",  d.rd, d.rs1, d.imm);

            else if (d.funct3 == 0x2)
                sprintf(mnemonic, "slti x%d, x%d, %d",  d.rd, d.rs1, d.imm);

            else if (d.funct3 == 0x3)
                sprintf(mnemonic, "sltiu x%d, x%d, %d", d.rd, d.rs1, d.imm);

            else if (d.funct3 == 0x1 && d.funct7 == 0x00)
                sprintf(mnemonic, "slli x%d, x%d, %d",  d.rd, d.rs1, d.imm & 0x1F);

            else if (d.funct3 == 0x5 && d.funct7 == 0x00)
                sprintf(mnemonic, "srli x%d, x%d, %d",  d.rd, d.rs1, d.imm & 0x1F);

            else if (d.funct3 == 0x5 && d.funct7 == 0x20)
                sprintf(mnemonic, "srai x%d, x%d, %d",  d.rd, d.rs1, d.imm & 0x1F);

            else
                valid = 0;

            break;

        /*=================================================
            Load Instructions
        =================================================*/
        case OP_LOAD:

            decode_i_type(inst, &d);

            if      (d.funct3 == 0x0)
                sprintf(mnemonic, "lb x%d, %d(x%d)",  d.rd, d.imm, d.rs1);

            else if (d.funct3 == 0x1)
                sprintf(mnemonic, "lh x%d, %d(x%d)",  d.rd, d.imm, d.rs1);

            else if (d.funct3 == 0x2)
                sprintf(mnemonic, "lw x%d, %d(x%d)",  d.rd, d.imm, d.rs1);

            else if (d.funct3 == 0x4)
                sprintf(mnemonic, "lbu x%d, %d(x%d)", d.rd, d.imm, d.rs1);

            else if (d.funct3 == 0x5)
                sprintf(mnemonic, "lhu x%d, %d(x%d)", d.rd, d.imm, d.rs1);

            else
                valid = 0;

            break;

        /*=================================================
            Store Instructions
        =================================================*/
        case OP_STORE:

            decode_s_type(inst, &d);

            if      (d.funct3 == 0x0)
                sprintf(mnemonic, "sb x%d, %d(x%d)", d.rs2, d.imm, d.rs1);

            else if (d.funct3 == 0x1)
                sprintf(mnemonic, "sh x%d, %d(x%d)", d.rs2, d.imm, d.rs1);

            else if (d.funct3 == 0x2)
                sprintf(mnemonic, "sw x%d, %d(x%d)", d.rs2, d.imm, d.rs1);

            else
                valid = 0;

            break;

        /*=================================================
            Branch Instructions
        =================================================*/
        case OP_BRANCH:

            decode_b_type(inst, &d);

            if      (d.funct3 == 0x0)
                sprintf(mnemonic, "beq x%d, x%d, %d",  d.rs1, d.rs2, d.imm);

            else if (d.funct3 == 0x1)
                sprintf(mnemonic, "bne x%d, x%d, %d",  d.rs1, d.rs2, d.imm);

            else if (d.funct3 == 0x4)
                sprintf(mnemonic, "blt x%d, x%d, %d",  d.rs1, d.rs2, d.imm);

            else if (d.funct3 == 0x5)
                sprintf(mnemonic, "bge x%d, x%d, %d",  d.rs1, d.rs2, d.imm);

            else if (d.funct3 == 0x6)
                sprintf(mnemonic, "bltu x%d, x%d, %d", d.rs1, d.rs2, d.imm);

            else if (d.funct3 == 0x7)
                sprintf(mnemonic, "bgeu x%d, x%d, %d", d.rs1, d.rs2, d.imm);

            else
                valid = 0;

            break;

        /*=================================================
            LUI
            U-type: no funct3/funct7 to validate.
            bits[1:0]==11 check above is sufficient.
        =================================================*/
        case OP_LUI:

            decode_u_type(inst, &d);
            sprintf(mnemonic, "lui x%d, %d", d.rd, d.imm);

            break;

        /*=================================================
            AUIPC
        =================================================*/
        case OP_AUIPC:

            decode_u_type(inst, &d);
            sprintf(mnemonic, "auipc x%d, %d", d.rd, d.imm);

            break;

        /*=================================================
            JAL
            J-type: no funct3/funct7.
            The bits[1:0]==11 guard above is the key check.
            DEADBEEF  → bits[1:0] = 11  AND  opcode = 0x6F
            but bits[6:2] = 0x1B which IS 0x6F>>2... wait,
            let's be precise:

            0xDEADBEEF & 0x7F = 0x6F  → opcode matches JAL
            0xDEADBEEF &  0x3 = 0x03  → bits[1:0] pass

            So DEADBEEF passes both guards above and IS a
            technically-encodable JAL in raw bits.  The only
            way to reject it is to add a project-specific
            check (e.g. imm must be 4-byte-aligned, which
            the RISC-V spec already requires: imm[0] is
            always 0 because JAL encodes imm[20:1]).

            The immediate reconstructed from DEADBEEF:
              inst = 0xDEADBEEF
              imm[20]    = bit31        = 1
              imm[10:1]  = bits[30:21]  = 1101 1110 10
              imm[11]    = bit20        = 1
              imm[19:12] = bits[19:12]  = 1011 1110

            The lowest bit of the final immediate is always 0
            because we shift left by 1 (imm[0] is implicit 0).
            So alignment cannot distinguish DEADBEEF.

            Conclusion: DEADBEEF is a valid-encoding JAL by
            the RV32I spec.  Use genuinely-invalid opcodes
            (see unknown.hex) to test UNKNOWN output.
        =================================================*/
        case OP_JAL:

            decode_j_type(inst, &d);
            sprintf(mnemonic, "jal x%d, %d", d.rd, d.imm);

            break;

        /*=================================================
            JALR
            funct3 must be 0x0
        =================================================*/
        case OP_JALR:

            decode_i_type(inst, &d);

            if (d.funct3 == 0x0)
                sprintf(mnemonic, "jalr x%d, %d(x%d)", d.rd, d.imm, d.rs1);
            else
                valid = 0;

            break;

        /*=================================================
            Unknown / unimplemented opcode
        =================================================*/
        default:
            valid = 0;
            break;

        } /* end switch (opcode) */

    } /* end else (bits[1:0] == 11) */

    /*-----------------------------------------------------
     * Final output: prepend the hex encoding to mnemonic
     * or emit UNKNOWN.
     *----------------------------------------------------*/
    if (!valid)
        sprintf(out, "0x%08X UNKNOWN", inst);
    else
        sprintf(out, "0x%08X %s", inst, mnemonic);
}