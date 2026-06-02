#include <stdio.h>
#include <string.h>

int strcat_safe(
    char *dest,
    size_t dest_size,
    const char *src)
{

  size_t dest_len =
      strlen(dest);

  size_t src_len =
      strlen(src);

  if (
      dest_len +
          src_len + 1 >
      dest_size)
    return -1;

  strcat(dest, src);

  return 0;
}

int main()
{

  char str[20] = "Muhammad ";

  if (
      strcat_safe(
          str,
          sizeof(str),
          "Kaleem") == 0)
  {

    printf(
        "%s\n",
        str);
  }

  else
  {

    printf(
        "Overflow\n");
  }

  return 0;
}