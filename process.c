#include "process.h"

int create_process(int (*code_address)()) {
    // Set stackptr to return value of calling alloc_stack() to allocate a stack
    uint64_t stackptr = alloc_stack();

    // Check to make sure stackptr is not null 
    if (stackptr == 0) {
        return -1;
    }

    // Set stack pointer (sp) to the bottom of the stack
    uint32_t *sp = (uint32_t *)(stackptr + 1024);

    // Create context that will set general purpose registers to 0
    for (int i = 1; i <= 31; i++) {
        sp--;

        // Set the value at which sp+30 points to code_address
        if (i == 30) {
            *sp = (uint64_t)code_address;
        } else {
            *sp = 0;
        }
    }

    // Set PCB to the return value of alloc_pcb() to allocate a PCB for the process
    PCB_t *pcb = alloc_pcb();

    // Check if PCB is null
    if (pcb == NULL) {
        return -1;
    }

    // Set the PCB's sp member to sp
    // Set the PCB's pid member to next_pid
    pcb->sp = sp;
    pcb->pid = next_pid++;

    // Enqueue the PCB onto the ready queue (q is a global)
    enqueue(q, pcb);

    return 0;
}
