#include "kernel.h"

void enqueue(PCB_Q_t *q, PCB_t *pcb);
PCB_t *dequeue(PCB_Q_t *q);

extern int box(int srow, int scol, int erow, int ecol);

int main(){

    //clear the screen
    clear_scr(21, 49, 27, 79);

    //return the val
    int returnVal = box(21, 49, 27, 79);
    print_to(24, 59, "Hello World!");
    
    return returnVal;
}