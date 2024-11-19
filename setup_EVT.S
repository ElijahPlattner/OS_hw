.global setup_EVT

.extern vector_table
setup_EVT:
// set up the exception vector table
    adr     x0, vector_table 
    msr     VBAR_EL1, x0        // Set the vector base address
    ret


