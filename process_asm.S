.global     go
go:
    b restore_context

.global     dispatch
.extern     ReadyQ
.extern     Running
.extern     enqueue
.extern     dequeue
.extern     clear_timer

// Note: dispatch must be written in assembly.
dispatch:

    //disable interupts
    msr     DAIFSet, #0x2

    //store x1
    str x1, [sp, #-16]!

    //load the process stack pointer
    MRS     x1, SP_EL0

    //make room for the process context on the stack
    sub x1, x1, 16*17

    //save process general purpose registers
    str x0, [x1]
    ldr x0, [sp]
    str x0, [x1,8]

    // 2)	copy all registers to the stack the stack
    // 		(in the order x0,x1,...,x30)
    //stp x0, x1, [x1]//!
    stp x2, x3, [x1, 16]
    stp x4, x5, [x1, 16*2]
    stp x6, x7, [x1, 16*3]
    stp x8, x9, [x1, 16*4]
    stp x10, x11, [x1, 16*5]
    stp x12, x13, [x1, 16*6]
    stp x14, x15, [x1, 16*7]
    stp x16, x17, [x1, 16*8]
    stp x18, x19, [x1, 16*9]
    stp x20, x21, [x1, 16*10]
    stp x22, x23, [x1, 16*11]
    stp x24, x25, [x1, 16*12]
    stp x26, x27, [x1, 16*13]
    stp x28, x29, [x1, 16*14]

    //store the x30 reg
    str x30, [x1, 16*15]
// push this and test it. also see if the registers match whats happening in the vm



    // 3)	put the PSTATE into the stack with the
    // 		following code:
    mrs     x0, SPSR_EL1      // Save PSTATE
    str     x0, [x1, 16*15+8]

    //save interrupt return address
    mrs     x0, ELR_EL1              
    str     x0, [x1, 16*16]

    // 4)	store the new x1 value into the pcb where Running points
    adr     x1, Running
    ldr     x1, [x1]  // put the first value in the PCB (x1) into x1
    mov     x4, x1    // We can't str x1 directly, so put x1 into x4...
    str     x4, [x1]  //    Then store the new x1 in x4 to the PCB 

    // 5)	call enqueue passing it address of ReadyQ and the value of
    // 		Running

    adr x0, ReadyQ
    ldr x0, [x0]

    adr x1, Running
    ldr x1, [x1]

    //restore x1
    ldr x1, [sp], #16//!

    bl enqueue

restore_context:   // Note that this is where go() jumps
    // 6)	call dequeue passing it the address of ReadyQ
    ldr x0, =ReadyQ          //!// Load the address of the ReadyQ pointer
    ldr x0, [x0]   //!didnt have          // Dereference to get the actual queue pointer
    bl dequeue

    // 7)  move the return value of dequeue into Running
    adr x1, Running
    str x0, [x1]

    // 8)  read the value out of the returned pcb and put
    //     	it into the x1 register. The code should look
    //         like the following:
    ldr		x1, [x0]   // x2 now has the value of the stack ptr (we cant ldr sp directly)
    //mov		x1, x2     // x1 now has the top of stack for the chosen process
    
    // 9)	restore the PSTATE stored in the stack
    ldr     x0, [x1, 16*15+8]   // Restore PSTATE
    msr     SPSR_EL1, x0

    //Restore interrupt return address	
    ldr     x0, [x1, 16*16]   
  	msr     ELR_EL1, x0

    //Store the new top of stack into the
    //System exception register for EL0.		
    mov     x0, x1           
    add     x0, x0, 16*17    
    MSR     SP_EL0, x0   

    // 10) copy all register values for x2-x28 from the stack at
    //         which x1 points into those registers.
    
    ldp x0, x1, [x1, 0]//!
    ldp x2, x3, [x1, 16]
    ldp x4, x5, [x1, 16*2]
    ldp x6, x7, [x1, 16*3]
    ldp x8, x9, [x1, 16*4]
    ldp x10, x11, [x1, 16*5]
    ldp x12, x13, [x1, 16*6]
    ldp x14, x15, [x1, 16*7]
    ldp x16, x17, [x1, 16*8]
    ldp x18, x19, [x1, 16*9]
    ldp x20, x21, [x1, 16*10]
    ldp x22, x23, [x1, 16*11]
    ldp x24, x25, [x1, 16*12]
    ldp x26, x27, [x1, 16*13]
    ldr x28, [x1, 16*14]
    


    // 11) add 16*16 to sp
    //add sp, sp, 256

    stp x0, x1, [sp, -16]!

    // branch to clear timer
    bl clear_timer

    //restore x0 and x1
    ldp x0, x1, [sp], 16

    //restore  x29
    ldr x29, [x1, 16*14+8]

    //restore  x30
    ldr x30, [x1, 16*15]
    
    //this might have fixed it
    //restore x0 and x1
    ldp x0, x1, [x1]

    //enable interupts
    msr     DAIFClr, #0x2

    // 12) return
    eret