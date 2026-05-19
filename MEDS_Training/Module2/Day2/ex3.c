#include <stdio.h>
#include <stdint.h>
#include <ctype.h>

void memory_dump(
    const uint8_t *mem,
    size_t size
) {

    for(size_t i=0;i<size;i+=8){

        printf("0x%04zX: ",i);

        for(size_t j=0;
            j<8 && (i+j)<size;
            j++){

            printf("%02X ",
            mem[i+j]);
        }

        printf("|");

        for(size_t j=0;
            j<8 && (i+j)<size;
            j++){

            char c=mem[i+j];

            if(isprint(c))
                printf("%c",c);

            else
                printf(".");
        }

        printf("|\n");
    }
}

int main(){

    uint8_t mem[]={
        0xDE,
        0xAD,
        0xBE,
        0xEF,
        0x43,
        0x41,
        0x46,
        0x45
    };

    memory_dump(
        mem,
        sizeof(mem)
    );

    return 0;
}
