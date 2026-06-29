#ifndef COMMON_H
#define COMMON_H

#include <stdint.h>

/* ==========================================================
   Project Constants
   ========================================================== */

#define NUM_REGISTERS      32
#define MEMORY_SIZE        65536
#define PC_START           0x00000000
#define OPCODE_MASK        0x7F

/* ==========================================================
   Bit Extraction Macro
   Extract bits [high:low]
   Example:
       EXTRACT_BITS(inst,11,7)
   ========================================================== */

#define EXTRACT_BITS(val, high, low) \
    (((val) >> (low)) & ((1U << ((high) - (low) + 1)) - 1))

/* ==========================================================
   Sign Extension
   ========================================================== */

#define SIGN_EXTEND(value, bits) \
    (((value) ^ (1 << ((bits)-1))) - (1 << ((bits)-1)))

#endif