#ifndef PROCESS_H
#define PROCESS_H

#include <stdint.h>
#include "pcb_alloc.h"
#include "stack_alloc.h"
#include "queue.h"

//global
int next_pid = 0;

// Function declaration
int create_process(int (*code_address)());

#endif // PROCESS_H
