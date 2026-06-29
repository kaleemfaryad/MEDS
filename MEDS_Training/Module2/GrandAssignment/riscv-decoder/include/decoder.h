#ifndef DECODER_H
#define DECODER_H

#include <stdint.h>

/* ==========================================================
   RV32I Opcodes
   ========================================================== */

typedef enum
{
    OP_LOAD    = 0x03,
    OP_I_TYPE  = 0x13,
    OP_AUIPC   = 0x17,
    OP_STORE   = 0x23,
    OP_R_TYPE  = 0x33,
    OP_LUI     = 0x37,
    OP_BRANCH  = 0x63,
    OP_JALR    = 0x67,
    OP_JAL     = 0x6F,
    OP_SYSTEM  = 0x73

} opcode_t;

/* ==========================================================
   ALU Operations
   ========================================================== */

typedef enum
{
    ALU_ADD,
    ALU_SUB,
    ALU_AND,
    ALU_OR,
    ALU_XOR,
    ALU_SLL,
    ALU_SRL,
    ALU_SRA,
    ALU_SLT,
    ALU_SLTU

} alu_op_t;

/* ==========================================================
   Decoded Instruction Structure
   ========================================================== */

typedef struct
{
    uint32_t opcode;

    uint32_t rd;

    uint32_t rs1;

    uint32_t rs2;

    uint32_t funct3;

    uint32_t funct7;

    int32_t imm;

} decoded_instr_t;

/* ==========================================================
   Decoder Functions
   ========================================================== */

void decode_r_type(uint32_t inst, decoded_instr_t *d);

void decode_i_type(uint32_t inst, decoded_instr_t *d);

void decode_s_type(uint32_t inst, decoded_instr_t *d);

void decode_b_type(uint32_t inst, decoded_instr_t *d);

void decode_u_type(uint32_t inst, decoded_instr_t *d);

void decode_j_type(uint32_t inst, decoded_instr_t *d);

/* Decode one complete instruction */

void decode_instruction(uint32_t addr,
                        uint32_t instruction,
                        char *output);

#endif