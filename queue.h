#ifndef QUEUE_H
#define QUEUE_H

#include "globals.h"

// Function declarations
void enqueue(PCB_Q_t *q, PCB_t *pcb);
PCB_t* dequeue(PCB_Q_t *q);

#endif // QUEUE_H
