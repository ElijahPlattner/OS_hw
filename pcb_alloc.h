#ifndef PCB_ALLOC_H
#define PCB_ALLOC_H

#include "pcb.h"
#include <stddef.h>

//define macros
#define MAX_PCB 10
#define PCB_SIZE 1024

//allocate space for pcb's
PCB_t pcb_mem[MAX_PCB];
uint32_t next_pcb = 0;

//function to return pointer to newly allocated mem
PCB_t *alloc_pcb(){

    if (next_pcb == MAX_PCB)
    {
        return NULL;
    }

    PCB_t* new_pcb = (PCB_t *)(pcb_mem + next_pcb);
    new_pcb->sp = 0;
    new_pcb->pid = next_pcb;
    new_pcb->next= NULL;

    next_pcb++;

    return new_pcb;
}

#endif
//questions: is it ok to use an array to define the mem that were using?