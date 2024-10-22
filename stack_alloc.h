#ifndef PCB_STACK_H
#define PCB_STACK_H

#include <stdint.h>
#include <stddef.h>

//define macros
#define MAX_STACKS 10
#define STACK_SIZE 1024

//declare the stacks
uint64_t stacks [MAX_STACKS][STACK_SIZE];
uint32_t next_stack = 0;


uint64_t *alloc_stack (){

    if(next_stack == MAX_STACKS)
        return NULL; //ELIJAH add error handling
    
    return stacks[next_stack++];
}

#endif

