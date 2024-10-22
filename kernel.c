#include "kernel.h"

//define externs
extern int box(int srow, int scol, int erow, int ecol);
extern void go();
extern void dispatch(void);
int p1();

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

//process code for process p1
int p1(){
    int num = 0;
    char output_char;
    char message[] = "Process 1: 0";

    //   print a box from row 9, column 23 to row 11, column 39
    box(9, 23, 11, 39);

    //   print_to the message "Process 1: 0" at row 10 column 25
    
    print_to(10, 25, message);
    
    while(0 == 0){
        //      convert num to a character
        output_char = num + '0';

        //     set message[11] to the character number
        message[11] = output_char;

        // 	print the message at row 10 column 25
        print_to(10, 25, message);
        
        num++;

        //     if num is greater than 9, set num to zero
        if (num > 9)
            num = 0;

        //call dispatch
        dispatch();

    }

    return 0;
}