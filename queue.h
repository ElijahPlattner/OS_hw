#ifndef QUEUE_H
#define QUEUE_H

#include "pcb.h"

PCB_Q_t* ReadyQ;
PCB_t* Running;

// Function declarations
extern void enqueue(PCB_Q_t *q, PCB_t *pcb);
extern PCB_t* dequeue(PCB_Q_t *q);

#endif // QUEUE_H
