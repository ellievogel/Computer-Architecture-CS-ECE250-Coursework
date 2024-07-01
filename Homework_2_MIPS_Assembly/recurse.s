.text
.align 2
main:
    addi    $sp,        $sp,        -4      # make space for return address
    sw      $ra,        0($sp)              # store ra

    li      $v0,        5
    la      $a0,        number
    syscall                                 # inputted number in $v0
    move    $a0,        $v0                 # now, inputted number in $a0
    jal     recursion

    move    $a0,        $v0
    li      $v0,        1
    syscall 

    lw      $ra,        0($sp)
    addi    $sp,        $sp,        4
    jr      $ra

recursion:
    addi    $sp,        $sp,        -8      # set up the stack frame
    sw      $ra,        4($sp)
    sw      $s0,        0($sp)

    move    $s0,        $a0

    beqz    $s0,        _basecase

    addi    $a0,        $s0,        -1
    jal     recursion                       # input is at s0, recursion(input-1) is at v0

    li      $t3,        3                   # load integers to use
    li      $t2,        2
    li      $t7,        7

    mul     $s0,        $s0,        $t3     # multiply input by 3
    mul     $v0,        $v0,        $t2     # multiply recursion(input-1) by 2
    sub     $s0,        $s0,        $v0     # subtract 2*(recursion(input-1)) from 3*input
    addi    $v0,        $s0,        7


    j       _clean

_basecase:
    li      $v0,        2
    j       _clean

_clean:
    lw      $s0,        0($sp)
    lw      $ra,        4($sp)
    addi    $sp,        $sp,        8
    jr      $ra

.data
.align 2
number: .space 4