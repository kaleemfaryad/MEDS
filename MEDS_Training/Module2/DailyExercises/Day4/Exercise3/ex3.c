#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[])
{
  if (argc < 2)
  {
    printf("Usage: %s <logfile>\n", argv[0]);
    return 1;
  }

  FILE *fp = fopen(argv[1], "r");
  if (!fp)
  {
    perror("File open failed");
    return 1;
  }

  char line[256];
  int pass = 0, fail = 0, skip = 0;

  while (fgets(line, sizeof(line), fp))
  {
    if (strstr(line, "PASS"))
      pass++;
    else if (strstr(line, "FAIL"))
      fail++;
    else if (strstr(line, "SKIP"))
      skip++;
  }

  fclose(fp);

  printf("PASS = %d\n", pass);
  printf("FAIL = %d\n", fail);
  printf("SKIP = %d\n", skip);

  return 0;
}