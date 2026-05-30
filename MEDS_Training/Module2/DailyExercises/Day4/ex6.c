#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

int main(int argc, char *argv[])
{
  size_t mem_size = 65536;
  uint32_t start_addr = 0;
  int trace = 0;

  for (int i = 1; i < argc; i++)
  {
    if (strcmp(argv[i], "--trace") == 0)
    {
      trace = 1;
    }
    else if (strcmp(argv[i], "--mem-size") == 0)
    {
      mem_size = atoi(argv[++i]);
    }
    else if (strcmp(argv[i], "--start-addr") == 0)
    {
      start_addr = strtoul(argv[++i], NULL, 0);
    }
  }

  printf("Memory Size : %zu bytes\n", mem_size);
  printf("Start Addr  : 0x%X\n", start_addr);
  printf("Trace       : %s\n", trace ? "ON" : "OFF");

  uint8_t *memory = calloc(mem_size, 1);
  if (!memory)
  {
    perror("Memory allocation failed");
    return 1;
  }

  free(memory);
  return 0;
}