#include "libos.h"
#include "process.h"
#include "pcb.h"



//function to clear the screen
void clear_scr(int srow, int scol, int erow, int ecol){

    for (int i = srow; i <= erow; i++){
        for (int j = scol; j <= ecol; j++ )
            putc_to(i, j, ' ');
    }
}

