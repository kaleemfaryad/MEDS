#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

// Global initialized → Data segment
int global_init = 100;

// Global uninitialized → BSS segment
int global_uninit;

// Static initialized → Data segment
static int static_var = 50;

int main() {

    // Local variable → Stack
    int local_var = 10;

    // Dynamic allocation → Heap
    int *heap_var = malloc(sizeof(int));

    *heap_var = 200;

    printf("Global initialized (Data): %p\n",
           (void*)&global_init);

    printf("Global uninitialized (BSS): %p\n",
           (void*)&global_uninit);

    printf("Static variable (Data): %p\n",
           (void*)&static_var);

    printf("Heap variable: %p\n",
           (void*)heap_var);

    printf("Local variable (Stack): %p\n",
           (void*)&local_var);

    free(heap_var);

    return 0;
}

