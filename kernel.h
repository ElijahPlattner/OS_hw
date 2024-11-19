#include "libos.h"
#include "process.h"
#include "pcb.h"

//define externs
extern int box(int srow, int scol, int erow, int ecol);
extern void go();
extern void dispatch();
extern void setup_EVT();
extern void init_timer();
extern void unsupported();

