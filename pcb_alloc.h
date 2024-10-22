#ifndef PCB_ALLOC_H
#define PCB_ALLOC_H

#include "pcb.h"
#include <stddef.h>
#include <stdint.h>

// Declare the function prototype for alloc_pcb
PCB_t *alloc_pcb();

#endif // PCB_ALLOC_H

//questions: is it ok to use an array to define the mem that were using?