#include "queue.h"

// Define and initialize globals
PCB_Q_t* ReadyQ = NULL;
PCB_t* Running = NULL;

void enqueue(PCB_Q_t *q, PCB_t *pcb) {
    // If the queue has nothing in it
    if (q->tail == NULL) {
        q->head = q->tail = pcb;
        pcb->next = NULL;
        return;
    }

    // Otherwise, add PCB to the end of the queue
    q->tail->next = pcb;
    q->tail = pcb;
    q->tail->next = NULL;
}

PCB_t* dequeue(PCB_Q_t *q) {
    // If the queue is empty
    if (q->tail == NULL) {
        return NULL;
    }

    // Store the head of the queue and update head
    PCB_t *temp = q->head;
    q->head = q->head->next;

    // If the queue becomes empty after dequeueing, reset tail to NULL
    if (q->head == NULL) {
        q->tail = NULL;
    }

    return temp;
}

