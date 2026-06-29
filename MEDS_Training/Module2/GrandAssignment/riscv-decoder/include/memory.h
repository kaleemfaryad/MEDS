#ifndef MEMORY_H
#define MEMORY_H

#include <stdint.h>
#include <stddef.h>

/* ==========================================================
   Load a hex file into memory.

   Parameters:
       filename -> path of .hex file
       count    -> returns number of instructions

   Returns:
       Pointer to dynamically allocated array
       NULL on failure.
   ========================================================== */

uint32_t *load_hex(const char *filename,
                   size_t *count);

/* ==========================================================
   Free allocated instruction memory
   ========================================================== */

void free_memory(uint32_t *memory);

#endif