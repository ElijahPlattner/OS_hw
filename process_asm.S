.section .text

.extern ReadyQ
.extern Running
.extern enqueue
.extern dequeue

.global dispatch

; Note: dispatch must be written in assembly.
dispatch:
    ; 1)	subtract 16*16 from the stack
    sub sp, sp, 256

    ; 2)	copy all registers to the stack the stack
    ; 		(in the order x0,x1,...,x30)

    stp x0, x1, [sp]
    stp x2, x3, [sp, 16]
    stp x4, x5, [sp, 16*2]
    stp x6, x7, [sp, 16*3]
    stp x8, x9, [sp, 16*4]
    stp x10, x11, [sp, 16*5]
    stp x12, x13, [sp, 16*6]
    stp x14, x15, [sp, 16*7]
    stp x16, x17, [sp, 16*8]
    stp x18, x19, [sp, 16*9]
    stp x20, x21, [sp, 16*10]
    stp x22, x23, [sp, 16*11]
    stp x24, x25, [sp, 16*12]
    stp x26, x27, [sp, 16*13]
    stp x28, x29, [sp, 16*14]

    //store the x30 reg
    str x30, [sp, 16*15]

    ; 3)	put the PSTATE into the stack with the
    ; 		following code:
    mrs     x0, SPSR_EL1      // Save PSTATE
    str     x0, [sp, 16*15+8]

    ; 4)	store the new sp value into the pcb where Running points
    adr     x1, Running
    ldr     x1, [x1]  // put the first value in the PCB (sp) into x1
    mov     x4, sp    // We can't str sp directly, so put sp into x4...
    str     x4, [x1]  //    Then store the new sp in x4 to the PCB 

    ; 5)	call enqueue passing it address of ReadyQ and the value of
    ; 		Running

    adr x0, ReadyQ

    adr x1, Running
    ldr x1, [x1]

    b enqueue

restore_context:   // Note that this is where go() jumps
    ; 6)	call dequeue passing it the address of ReadyQ
    adr x0, ReadyQ
    bl dequeue

    ; 7)  move the return value of dequeue into Running
    adr x1, Running
    str x0, [x1]

    ; 8)  read the value out of the returned pcb and put
    ;     	it into the sp register. The code should look
    ;         like the following:
    adr		x1, Running
    str		x0, [x1]   // store the pointer to the PCB into the Running variable
    ldr		x2, [x0]   // x2 now has the value of the stack ptr (we cant ldr sp directly)
    mov		sp, x2     // sp now has the top of stack for the chosen process
    
    ; 9)	restore the PSTATE stored in the stack
    ldr     x0, [sp, 16*15+8]   // Restore PSTATE
    msr     SPSR_EL1, x0

    ; 10) copy all register values for x0-x30 from the stack at
    ;         which sp points into those registers.
    
    ldp x0, x1, [sp]
    ldp x2, x3, [sp, 16]
    ldp x4, x5, [sp, 16*2]
    ldp x6, x7, [sp, 16*3]
    ldp x8, x9, [sp, 16*4]
    ldp x10, x11, [sp, 16*5]
    ldp x12, x13, [sp, 16*6]
    ldp x14, x15, [sp, 16*7]
    ldp x16, x17, [sp, 16*8]
    ldp x18, x19, [sp, 16*9]
    ldp x20, x21, [sp, 16*10]
    ldp x22, x23, [sp, 16*11]
    ldp x24, x25, [sp, 16*12]
    ldp x26, x27, [sp, 16*13]
    ldr x28, x29, [sp, 16*14]

    ; 11) add 16*16 to sp
    add sp, sp, 256

    ; 12) return
    ret