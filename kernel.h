#include "libos.h"
#include "pcb.h"
#include <stdint.h>

typedef struct {
    uint64_t sp;
    uint32_t pid;
} PCB_t;

typedef struct {

    struct Node_t *front;
    struct Node_t *rear;

} PCB_Q_t;


void clear_scr(int srow, int scol, int erow, int ecol){

    for (int i = srow; i <= erow; i++){
        for (int j = scol; j <= ecol; j++ )
            putc_to(i, j, ' ');
    }
};

void enqueue(PCB_Q_t *q, PCB_t *pcb){


};

PCB_t *dequeue(PCB_Q_t *q){


};

