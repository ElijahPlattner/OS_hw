#include "libos.h"
#include "process.h"
#include "pcb.h"

//define externs
extern int box(int srow, int scol, int erow, int ecol);
extern void go();
extern void dispatch();

//function to clear the screen
void clear_scr(int srow, int scol, int erow, int ecol){

    for (int i = srow; i <= erow; i++){
        for (int j = scol; j <= ecol; j++ )
            putc_to(i, j, ' ');
    }
}

//process code for process p1
void p1(){
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
}

//process code for process p2
void p2(){
    return;
}
