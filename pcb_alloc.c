#include "pcb_alloc.h"

// Define macros
#define MAX_PCB 10
#define PCB_SIZE 1024

// Define and initialize the global variables
PCB_t pcb_mem[MAX_PCB];
uint32_t next_pcb = 0;

// Function to return pointer to newly allocated memory
PCB_t *alloc_pcb() {
    if (next_pcb == MAX_PCB) {
        return NULL;
    }

    PCB_t *new_pcb = (PCB_t *)(pcb_mem + next_pcb);
    new_pcb->sp = 0;
    new_pcb->pid = next_pcb;
    new_pcb->next = NULL;

    next_pcb++;

    return new_pcb;
}