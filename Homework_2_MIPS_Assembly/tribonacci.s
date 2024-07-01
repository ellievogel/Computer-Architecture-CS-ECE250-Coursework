.text
.align 2
main:
    li      $v0,    5
    la      $a0,    number
    syscall 
    move    $t0,    $v0                 # $t0 holds the inputted number

    li      $t4,    0                   # $t4 will be my counter

    li      $t3,    0                   # $t3 holds least_recent
    li      $t2,    1                   # $t2 holds middle
    li      $t1,    1                   # $t1 holds most_recent

loop:

    beqz    $t4,    _if
    li      $t5,    1                   # temporary to compare value to 1
    beq     $t4,    $t0,        _done   # if the counter is equal to the number, we are done
    beq     $t4,    $t5,        _if
    j       _else

_if:
    li      $v0,    1
    li      $a0,    1
    syscall 
    li      $v0,    4
    la      $a0,    newline
    syscall 
    addi    $t4,    $t4,        1
    j       loop

_else:
    add     $t6,    $t3,        $t2     # create variable temp to hold sum before shifting values
    add     $t6,    $t6,        $t1
    move    $t3,    $t2                 # shift numbers around
    move    $t2,    $t1
    move    $t1,    $t6

    li      $v0,    1
    move    $a0,    $t6
    syscall 
    li      $v0,    4
    la      $a0,    newline
    syscall 
    addi    $t4,    $t4,        1
    j       loop

_done:
    jr      $ra


.data
.align 2
prompt: .asciiz "input a number "
number: .space 4
newline: .asciiz "\n"
