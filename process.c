#include <stdint.h>
#include "pcb_alloc.h"
#include "globals.h"


int create_process(int (*code_address)()) {

    //set stackptr to return value of calling alloc_stack() to allocate a stack
    uint64_t stackptr = alloc_stack();

    //check to make sure stackptr is not null 
    if(stackptr == NULL){
        return -1;
    } 
    
    //set stack pointer (sp) to the bottom of the stack
    uint32_t * sp = stackptr + 1024;
    
    //create context that will set gen purpose regs to 0
    for(int i =1; i <= 31; i++){
        sp--;

        //set the value at which sp+30 points to code_address
        if(i==30)
            *sp = (uint64_t)code_address;
        else
            *sp = 0;
    }

    //     set pcb to the return value of alloc_pcb() to allocate a pcb for the process
    PCB_t * pcb= alloc_pcb();

	//check the pcb and if is null then return -1
    if(pcb == NULL)
        return -1;

    //set the pcb's sp member to sp.
    //set the pcb's pid member to next_pid
    pcb->sp = sp;
    pcb->pid= next_pid++;

    //enqueue the pcb onto the ready queue  // ready queue will be a global
    enqueue(q, pcb);

    return 0;

    };