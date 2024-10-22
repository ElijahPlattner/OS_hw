#ifndef PROCESS_H
#define PROCESS_H

#include <stdint.h>
#include "pcb_alloc.h"
#include "stack_alloc.h"
#include "queue.h"



// Function declaration
int create_process(int (*code_address)());

#endif // PROCESS_H
