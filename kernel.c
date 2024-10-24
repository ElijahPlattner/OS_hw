#include "kernel.h"

//define externs
extern int box(int srow, int scol, int erow, int ecol);
extern void go();
extern void dispatch();


//process code for process p1
int p1(){
    
    char output_char;
    char message[] = "Process 1: 0";

    //   print a box from row 9, column 23 to row 11, column 39
    box(9, 23, 11, 39);

    print_to(10, 25, message);
    int num = 0;
    while(1){
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

//process code for process p2
int p2(){
    
    char output_char;
    char message[] = "Process 2: 0";

    //   print a box from row 12, column 23 to row 15, column 39
    box(12, 23, 14, 39);

    print_to(13, 25, message);
    int num = 0;
    while(1){
        //      convert num to a character
        output_char = num + '0';

        //     set message[11] to the character number
        message[11] = output_char;

        // 	print the message at row 10 column 25
        print_to(13, 25, message);
        
        num++;

        //     if num is greater than 9, set num to zero
        if (num > 9)
            num = 0;

        //call dispatch
        dispatch();

    }

    return 0;
}

//process code for process p3
int p3(){
    
    char output_char;
    char message[] = "Process 3: 0";

    //   print a box from row 9, column 49 to row 11, column 65
    box(9, 49, 11, 65);

    print_to(10, 51, message);
    int num = 0;
    while(1){
        //      convert num to a character
        output_char = num + '0';

        //     set message[11] to the character number
        message[11] = output_char;

        // 	print the message at row 10 column 25
        print_to(10, 51, message);
        
        num++;

        //     if num is greater than 9, set num to zero
        if (num > 9)
            num = 0;

        //call dispatch
        dispatch();

    }

    return 0;
}

//process code for process p4
int p4(){
    
    char output_char;
    char message[] = "Process 4: 0";

    //   print a box from row 12, column 49 to row 15, column 65
    box(12, 49, 14, 65);
    
    print_to(13, 51, message);
    int num = 0;
    while(1){
        //      convert num to a character
        output_char = num + '0';

        //     set message[11] to the character number
        message[11] = output_char;

        // 	print the message at row 10 column 25
        print_to(13, 51, message);
        
        num++;

        //     if num is greater than 9, set num to zero
        if (num > 9)
            num = 0;

        //call dispatch
        dispatch();

    }

    return 0;
}


int main(){

    int retval;
    //clear the screen
    clear_scr(21, 49, 27, 79);
    //int returnVal = box(21, 49, 27, 79);

    //print "Running processes" to the first line of the screen
    print_to(1, 1, "Running processes");

    //initialize rr queue data structure
    ReadyQ->head = ReadyQ->tail = NULL;

    //clear the entrance messages
    clear_scr(0, 0, 2, 20);

    //create four processes
    retval = create_process(p1);
    if(retval !=0)
        return 1;

    retval = create_process(p2);
    if(retval !=0)
        return 1;
    
    retval = create_process(p3);
    if(retval !=0)
        return 1;
    
    retval = create_process(p4);
    if(retval !=0)
        return 1;
    
    
    //start processes
    go();
        
    return 0;
}

