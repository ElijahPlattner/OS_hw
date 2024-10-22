#include "globals.h"

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
