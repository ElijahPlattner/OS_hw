.global     box
box:
 
    // standard entry: save link and stack frame registers
    //    load the stack frame with the pointer to current frame
    stp     x29, x30, [sp, -16]!

    // Save the arguments.  Called functions may overwrite x0-x3
    sub     sp, sp, 32
    stp     x0, x1, [sp]
    stp     x2, x3, [sp, 16]

    // sr in w0, sc in w1, er int w2, ec in w3
    
    // Make sure the argument are valid

    bl      _box_check_box_
    cmp     w0, 0
    bne     _box_error_

 
    // first, draw the corners:
    // +        +
    // +        +
    ldp     x0, x1, [sp]
    ldp     x2, x3, [sp, 16]
    bl      _box_draw_corners_

    // Now, draw the top and bottom:
    // +------+
    // +------+

    // You figure out what goes here

    // draw left and right sides

    // You figure out what goes here

    mov     w0, 0
    b       _box_exit_

_box_error_:
    mov     w0, 1

_box_exit_:
    add     sp, sp, 32   // pop save arg regs

    ldp     x29, x30, [sp], 16
    ret

_box_check_box_:
    
    // standard entry: save link and stack frame registers
    //    load the stack frame with the pointer to current frame
    stp     x29, x30, [sp, -16]!

    // Save the arguments.  Called functions may overwrite x0-x3
    sub     sp, sp, 32
    stp     x0, x1, [sp]
    stp     x2, x3, [sp, 16]
         
        
    //allocate memory on stack
    sub     sp, sp, 32
    
    //determine height, save to stack
    bl term_txtheight
    str     x0, [sp]

    //determine width, save to stack
    bl term_txtwidth
    str     x0, [sp, 8]

    //load vals back into registers
    ldp x1, x2, [sp]
    add sp, sp, 16

    ldp x3, x4, [sp] 
    add sp, sp, 16

    ldp x5, x6, [sp]
    add sp, sp, 16 




    


