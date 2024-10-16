#include "libos.h"
#include <stdint.h>

#define NULL ((void*)0) 

typedef struct {
    uint64_t sp;
    uint32_t pid;
    PCB_t * next;

} PCB_t;

typedef struct {

    PCB_t * head;
    PCB_t * tail;

} PCB_Q_t;


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

