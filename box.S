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

 /*
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
 */
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
    // sr in w0, sc in w1, er int w2, ec in w3
    sub     sp, sp, 32
    stp     x0, x1, [sp]
    stp     x2, x3, [sp, 16]
    
    //determine height and exit if the end row is greater than the height
    bl      term_txtheight
    ldr     w1, [sp, 16]
    cmp     x0, w1
    ble     _box_check_box_exit_

    //determine height and exit if the end row is greater than the height
    bl      term_txtwidth
    ldr     w1, [sp, 24]
    cmp     x0, w1
    ble     _box_check_box_exit_

    //load origional arguments back into regs
    ldp     x0, x1, [sp]
    ldp     x2, x3, [sp, 16]


    //make sure er > sr & ec > sc
    

_box_check_box_exit_:
    add     sp, sp, 32   // pop save arg regs

    ldp     x29, x30, [sp], 16
    ret





    


