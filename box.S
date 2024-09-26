.section .data 
plus:   .byte   '+'

.section .text

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

    // draw top and bottom sides
    ldp     x0, x1, [sp]
    ldp     x2, x3, [sp, 16]
    bl      _box_draw_top_bottom_

    // draw left and right sides
    ldp     x0, x1, [sp]
    ldp     x2, x3, [sp, 16]
    bl      _box_draw_right_left_

    //exit
    mov     w0, 0
    b       _box_exit_
 
//
//return 1 if func has error
//
_box_error_:
    mov     w0, 1

//
//exit the box func
//
_box_exit_:
    add     sp, sp, 32   // pop save arg regs

    ldp     x29, x30, [sp], 16
    ret

//
//test box bounds
//
_box_check_box_:
    
    // standard entry: save link and stack frame registers
    //    load the stack frame with the pointer to current frame
    stp     x29, x30, [sp, -16]!

    // Save the arguments.  Called functions may overwrite x0-x3
    // sr in w0, sc in w1, er int w2, ec in w3
    sub     sp, sp, 32
    stp     x0, x1, [sp]
    stp     x2, x3, [sp, 16]
    
    //determine height and error if the end row is greater than the height
    bl      term_txtheight
    mov     x1, 0
    ldr     x1, [sp, 16]
    cmp     x0, x1
    //ble     _box_check_box_exit_
    ble     _box_check_box_exit_1_

    //determine height and error if the end row is greater than the height
    bl      term_txtwidth
    mov     x1, 0
    ldr     x1, [sp, 24]
    cmp     x0, x1
    //ble     _box_check_box_exit_ //also add into this to make w0 0
    ble     _box_check_box_exit_1_

    //load origional arguments back into regs
    ldp     x0, x1, [sp]
    ldp     x2, x3, [sp, 16]

    //error if er is -le sr
    cmp x2, x0
    ble _box_check_box_exit_1_
    
    //error if ec is -le sc
    cmp x3, x1
    ble _box_check_box_exit_1_

    //exit 0 if it passes all tests
    bl _box_check_box_exit_0_



//
//exit box func with error
//
_box_check_box_exit_1_:
    mov     x0, 1
    add     sp, sp, 32   // pop save arg regs
    ldp     x29, x30, [sp], 16
    ret



//
//exit box func with return 0
//
_box_check_box_exit_0_:
    mov     x0, 0
    add     sp, sp, 32   // pop save arg regs
    ldp     x29, x30, [sp], 16
    ret

//
//draw the four corners of the box
//
_box_draw_corners_:
    // standard entry: save link and stack frame registers
    //    load the stack frame with the pointer to current frame
    stp     x29, x30, [sp, -16]!

    // Save the arguments.  Called functions may overwrite x0-x3
    sub     sp, sp, 32
    stp     x0, x1, [sp]
    stp     x2, x3, [sp, 16]

    //top left
    ldp x0, x1, [sp]
    ldr w2, plus
    bl     putc_to
    
    //bottom left
    ldr x0, [sp,16]
    ldr x1, [sp, 8]
    ldr w2, plus
    bl     putc_to

    //top right
    ldr x0, [sp]
    ldr x1, [sp, 24]
    ldr w2, plus
    bl     putc_to
    
    //bottom right
    ldp x0, x1, [sp, 16]
    ldr w2, plus
    bl     putc_to

    bl _box_draw_corners_exit_

//
//draw corners exit function
//
_box_draw_corners_exit_:
    add     sp, sp, 32   // pop save arg regs

    ldp     x29, x30, [sp], 16
    ret

//
//draw top and bottom lines
//
_box_draw_top_bottom_:
    // standard entry: save link and stack frame registers
    //    load the stack frame with the pointer to current frame
    stp     x29, x30, [sp, -16]!

    // Save the arguments.  Called functions may overwrite x0-x3
    sub     sp, sp, 32
    stp     x0, x1, [sp]
    stp     x2, x3, [sp, 16]


//
//draw the top line
    //set the pos of the first dash to be directly folowing the plus
    add x4, x1, #1

_top_while_:

    //if we have reached the end of the row, exit the loop
    cmp x4, x3
    bge _top_endwhile_
    
    //set up the args for putc_to
    mov x1, x4
    mov w2, '-'
    bl putc_to

    //increment position and pull args back into origional regs
    add x4, x4, 1
    ldp     x0, x1, [sp]
    ldp     x2, x3, [sp, 16]


    b _top_while_

//draw the bottom line
//
_top_endwhile_:

//
//draw the bottom line
    //set the pos of the first dash to be directly folowing the plus
    add x4, x1, #1

_bottom_while_:

    //if we have reached the end of the row, exit the function
    cmp x4, x3
    bge _box_draw_top_bottom_exit_

    //set up the args for putc_to
    mov x0, x2
    mov x1, x4
    mov w2, '-'
    bl putc_to

    //increment position and pull args back into origional regs
    add x4, x4, 1
    ldp     x0, x1, [sp]
    ldp     x2, x3, [sp, 16]


    b _bottom_while_

//
//exit top, bottom drawing function
//
_box_draw_top_bottom_exit_:
    add     sp, sp, 32   // pop save arg regs

    ldp     x29, x30, [sp], 16
    ret




_box_draw_right_left_:
// standard entry: save link and stack frame registers
    //    load the stack frame with the pointer to current frame
    stp     x29, x30, [sp, -16]!

    // Save the arguments.  Called functions may overwrite x0-x3
    sub     sp, sp, 32
    stp     x0, x1, [sp]
    stp     x2, x3, [sp, 16]

//
//draw the left line
    //set the pos of the first bar to be directly below the plus
    add x4, x0, #1

_left_while_:

    //if we have reached the end of the column, exit the loop
    cmp x4, x2
    bge _left_endwhile_
    
    //set up the args for putc_to
    mov x0, x4
    mov w2, '|'
    bl putc_to

    //increment position and pull args back into origional regs
    add x4, x4, 1
    ldp     x0, x1, [sp]
    ldp     x2, x3, [sp, 16]


    b _left_while_
_left_endwhile_:

//
//draw the right line
    //set the pos of the first dash to be directly below the plus
    add x4, x0, #1

_right_while_:

    //if we have reached the end of the column, exit the function
    cmp x4, x2
    bge _box_draw_right_left_exit_

    //set up the args for putc_to
    mov x0, x4
    mov x1, x3
    mov w2, '|'
    bl putc_to

    //increment position and pull args back into origional regs
    add x4, x4, 1
    ldp     x0, x1, [sp]
    ldp     x2, x3, [sp, 16]


    b _right_while_

//
//exit right, left drawing function
//
_box_draw_right_left_exit_:
    add     sp, sp, 32   // pop save arg regs

    ldp     x29, x30, [sp], 16
    ret