#include <stdio.h>
#include <stdint.h>

void store_word(
    uint8_t mem[],
    uint32_t addr,
    uint32_t value)
{

  if (
      addr % 4 != 0 ||
      addr + 3 >= 256)
  {

    printf(
        "Alignment Error\n");

    return;
  }

  mem[addr] =
      value & 0xFF;

  mem[addr + 1] =
      (value >> 8) & 0xFF;

  mem[addr + 2] =
      (value >> 16) & 0xFF;

  mem[addr + 3] =
      (value >> 24) & 0xFF;
}

uint32_t load_word(
    uint8_t mem[],
    uint32_t addr)
{

  if (
      addr % 4 != 0 ||
      addr + 3 >= 256)
  {

    printf(
        "Alignment Error\n");

    return 0;
  }

  return

      mem[addr]

      |

      (mem[addr + 1]
       << 8)

      |

      (mem[addr + 2]
       << 16)

      |

      (mem[addr + 3]
       << 24);
}

int main()
{

  uint8_t mem[256] = {0};

  store_word(
      mem,
      4,
      0xDEADBEEF);

  uint32_t value =
      load_word(
          mem,
          4);

  printf(
      "0x%08X\n",
      value);

  return 0;
}