#include <stdio.h>
#include <stdint.h>
#include <string.h>

typedef struct{

    uint32_t x[32];

    uint32_t pc;

}cpu_state_t;

const char *abi[32]={

"zero","ra","sp","gp",
"tp","t0","t1","t2",
"s0","s1","a0","a1",
"a2","a3","a4","a5",
"a6","a7","s2","s3",
"s4","s5","s6","s7",
"s8","s9","s10","s11",
"t3","t4","t5","t6"

};

void cpu_init(cpu_state_t *cpu){

    memset(cpu->x,0,sizeof(cpu->x));

    cpu->pc=0;

}

void reg_write(cpu_state_t *cpu,
               uint8_t rd,
               uint32_t value){

    if(rd!=0)
        cpu->x[rd]=value;

}

uint32_t reg_read(cpu_state_t *cpu,
                  uint8_t rs){

    return cpu->x[rs];

}

void dump_registers(cpu_state_t *cpu){

    for(int i=0;i<32;i++){

        printf("x%d/%s = %u\n",
                i,
                abi[i],
                cpu->x[i]);

    }

}

int main(){

    cpu_state_t cpu;

    cpu_init(&cpu);

    reg_write(&cpu,5,100);

    reg_write(&cpu,2,500);

    reg_write(&cpu,0,999);

    dump_registers(&cpu);

    printf("\nx5=%u\n",
            reg_read(&cpu,5));

    return 0;

}
