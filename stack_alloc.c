#include "stack_alloc.h"

// Define macros
#define MAX_STACKS 10
#define STACK_SIZE 1024

// Define and initialize the global variables
uint64_t stacks[MAX_STACKS][STACK_SIZE];
uint32_t next_stack = 0;

// Function to return a pointer to the next available stack
uint64_t *alloc_stack() {
    if (next_stack == MAX_STACKS)
        return NULL; // Handle stack allocation failure

    return stacks[next_stack++];
}
