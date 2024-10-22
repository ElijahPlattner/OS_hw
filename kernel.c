#include "kernel.h"

//define externs
extern int box(int srow, int scol, int erow, int ecol);
extern void go();

int main(){

    int retval;
    //clear the screen
    clear_scr(21, 49, 27, 79);
    //int returnVal = box(21, 49, 27, 79);

    //print "Running processes" to the first line of the screen
    print_to(1, 1, "Running processes");

    //initialize rr queue data structure
    ReadyQ->head = ReadyQ->tail = NULL;

    //create four processes
    retval = create_process(p1);
    if(retval !=0)
        return 1;

    // retval = create_process(p2);
    // if(retval !=0)
    //     return 1;
    
    // retval = create_process(p1);
    // if(retval !=0)
    //     return 1;
    
    // retval = create_process(p2);
    // if(retval !=0)
    //     return 1;
    
    
    //start processes
    go();
        
    return 0;
}