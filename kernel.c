#include "libos.h"
#include <unistd.h>
#include <stdio.h>


extern int box(int srow, int scol, int erow, int ecol);
// int main:
// 	call clear_scr with the start row, start column, end row, and end column
// 	call the box function with the start row, start column
// 		end row, and end column of the box
// 	call print_to with the row and column, and string to print

	// note: prototype of the following functions are:
	//   int box(unsigned int srow, unsigned int scol, unsigned 
	//           int erow, unsigned int ecol);
	//   int print_to(unsinged int row, unsigned int col, char *string);
	//   int clear_scr(int start_row, int start_col, int width, int height);
	// box() and clear_scr returns 1 on error
	// The values that you should pass for box and clear_scr are srow = 21, 
	//   scol = 49, erow = 27, ecol = 79
	// The values that you should pass for print_to are row = 24, 
	//   column= 59, and string = "Hello world"

void fill_scr(int srow, int scol, int erow, int ecol){

    for (int i = srow; i <= erow; i++){
        for (int j = scol; j <= ecol; j++ )
            putc_to(i, j, '+');
    }

}
void clear_scr(int srow, int scol, int erow, int ecol){

    for (int i = srow; i <= erow; i++){
        for (int j = scol; j <= ecol; j++ )
            putc_to(i, j, ' ');
    }
}

int main(){

    clear_scr(21, 49, 27, 79);
    int height = term_txtheight();
    int width = term_txtwidth();
    printf("height: %d, width: %d", height, width);
    int returnVal = box(21, 49, 27, 79);
    
    return 0;
}