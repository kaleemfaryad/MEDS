#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "memory.h"

uint32_t *load_hex(const char *filename, size_t *count)
{
    FILE *fp = fopen(filename, "r");

    if (fp == NULL)
    {
        perror("fopen");
        return NULL;
    }

    size_t capacity = 16;

    uint32_t *memory = malloc(capacity * sizeof(uint32_t));

    if (memory == NULL)
    {
        fclose(fp);
        return NULL;
    }

    *count = 0;

    while (1)
    {
        uint32_t instruction;

        if (fscanf(fp, "%x", &instruction) != 1)
            break;

        if (*count >= capacity)
        {
            capacity *= 2;

            uint32_t *temp =
                realloc(memory, capacity * sizeof(uint32_t));

            if (temp == NULL)
            {
                free(memory);
                fclose(fp);
                return NULL;
            }

            memory = temp;
        }

        memory[*count] = instruction;
        (*count)++;
    }

    fclose(fp);

    return memory;
}