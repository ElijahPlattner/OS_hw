#include "process.h"

//global
int next_pid = 0;

int create_process(int (*code_address)()) {
    // Set stackptr to return value of calling alloc_stack() to allocate a stack
    uint64_t* stackptr = alloc_stack();

    // Check to make sure stackptr is not null 
    if (stackptr == NULL) {
        return -1;
    }

    // Set stack pointer (sp) to the bottom of the stack
    //uint32_t *sp = (uint32_t *)(stackptr + 1024);
    uint64_t *sp = (stackptr + 1024);

    // Create context that will set general purpose registers to 0
    for (int i = 0; i < 32; i++) {
        sp--;
        *sp = 0;
    }
    // Set the value at which sp+30 points to code_address    
    *(sp+30) = (uint64_t)code_address;

    // Set PCB to the return value of alloc_pcb() to allocate a PCB for the process
    PCB_t *pcb = alloc_pcb();

    // Check if PCB is null
    if (pcb == NULL) {
        return -1;
    }

    // Set the PCB's sp member to sp, static cast so that the compiler does not complain
    // Set the PCB's pid member to next_pid
    pcb->sp = (uint64_t)sp;
    pcb->pid = next_pid++;

    // Enqueue the PCB onto the ready queue (q is a global)
    enqueue(ReadyQ, pcb);
    return 0;
}
