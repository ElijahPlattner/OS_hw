.global init_timer
.global clear_timer
.global vector_table

.extern unsupported


init_timer:
    stp     x29, x30, [sp, -16]!
    bl      clear_timer
    //route core 0 counter to core 0 irq
    ldr     x0, =0x40000040
    mov     x1, 0x08
    str     w1, [x0]
    // enable timer
    mov     x0, 1
    msr     CNTV_CTL_EL0, x0
    ldp     x29, x30, [sp], 16
    ret

clear_timer:
    stp     x29, x30, [sp, -16]!
    bl      clear_timer
    //route core 0 counter to core 0 irq
    ldr     x0, =0x40000040
    mov     x1, 0x08
    str     w1, [x0]
    // enable timer
    mov     x0, 1
    msr     CNTV_CTL_EL0, x0
    ldp     x29, x30, [sp], 16
    ret

vector_table:
 .balign 128
    b unsupported
.balign 128
    b dispatch
.balign 128
    b unsupported
.balign 128
    b unsupported
.balign 128
    b unsupported
.balign 128
    b dispatch    // yes
.balign 128
    b unsupported
.balign 128
    b unsupported
.balign 128
    b unsupported
.balign 128
    b dispatch
.balign 128
    b unsupported
.balign 128
    b unsupported
.balign 128
    b unsupported
.balign 128
    b dispatch
.balign 128
    b unsupported
.balign 128
    b unsupported
