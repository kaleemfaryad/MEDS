#include<stdio.h>
#include<stdint.h>

struct A{

uint8_t a;

uint32_t b;

uint8_t c;

};

struct B{

uint32_t b;

uint8_t a;

uint8_t c;

};

int main(){

printf("%zu\n",
sizeof(struct A));

printf("%zu\n",
sizeof(struct B));

}
