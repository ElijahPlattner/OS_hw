#ifndef PCB_H
#define PCB_H

#include <unistd.h>

//PCB_t struct def
typedef struct {
    uint64_t sp;
    uint32_t pid;
    PCB_t * next; //

} PCB_t;

//PCB_Q_t struct definition
typedef struct {

    PCB_t * head;
    PCB_t * tail;

} PCB_Q_t;

#endif
