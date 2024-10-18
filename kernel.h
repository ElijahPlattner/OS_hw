#include "libos.h"
#include <stdint.h>
#include "pcb_alloc.h"
#include "stack_alloc.h"

//global variable
int next_pid = 0;
PCB_Q_t* q;

void clear_scr(int srow, int scol, int erow, int ecol){

    for (int i = srow; i <= erow; i++){
        for (int j = scol; j <= ecol; j++ )
            putc_to(i, j, ' ');
    }
};

void enqueue(PCB_Q_t *q, PCB_t *pcb){

    //if the queue has nothing in it
    if (q->tail == NULL){
        q->head = q->tail = pcb;
        pcb->next = NULL;
        return;
    }

    //otherwise add pcb to the end of the queue
    q->tail->next = pcb;
    q->tail = pcb;
    q->tail->next = NULL;

};

PCB_t *dequeue(PCB_Q_t *q){

    //if queue is empty
    if (q->tail == NULL){
        return NULL;
    } 

    //store the head of queue and update head
    PCB_t * temp = q->head;
    q->head = q->head->next;

    if (q->head == NULL)
        q->tail = NULL;
    
    return temp;


};

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

    }
