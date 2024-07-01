.text
.align 2
main:

    addi    $sp,                $sp,                    -4
    sw      $ra,                0($sp)

    li      $t1,                0                                               # this is my head pointer

_construct_loop:

    li      $v0,                9                                               # address of string is in v0
    li      $a0,                72
    syscall 
    move    $t0,                $v0                                             # $t0 holds memory


    li      $v0,                4                                               # print new line character
    la      $a0,                name_prompt
    syscall 

    li      $v0,                8                                               # read the string
    li      $a1,                64                                              # max. number of characters is 64
    move    $a0,                $t0                                             # put the string into memory address specified by $t0
    syscall 

    move    $a1,                $a0                                             # move string into $a1 to call copy on it

    jal     strcpy
    move    $a0,                $t0                                             # move memory address of space into $a0 for string comparison

    la      $a1,                DONE                                            # load DONE into $a1 for string comparison
    jal     strcmp                                                              # call string compare, result stored in $v0
    beqz    $v0,                _clean                                          # jump to cleaning if the name is DONE

    li      $v0,                4                                               # print team prompt
    la      $a0,                team_prompt
    syscall 

    li      $v0,                5                                               # inputted number is in $v0
    syscall 
    move    $t9,                $v0                                             # $t9 holds team stat

    li      $v0,                4                                               # print opposition prompt
    la      $a0,                opposition_prompt
    syscall 

    li      $v0,                5                                               # inputted number is in $v0
    syscall 
    move    $t8,                $v0                                             # $t8 holds opposition stat

    sub     $t7,                $t9,                    $t8                     # $t7 holds difference

    sw      $t7,                64($t0)                                         # store difference 64 bytes into struct

    bne     $t1,                $0,                     _else_statement

    move    $t1,                $t0
    sw      $zero,              68($t0)

    j       _construct_loop

_else_statement:
    sw      $t1,                68($t0)
    move    $t1,                $t0
    j       _construct_loop

_clean:
    move    $a0,                $t1
    jal     sort
    move    $t1,                $v0

_print:
    li      $v0,                4                                               # print name
    move    $a0,                $t1
    syscall 

    li      $v0,                4                                               # print name
    la      $a0,                space
    syscall 

    li      $v0,                1                                               # print number
    lw      $a0,                64($t1)
    syscall 

    li      $v0,                4                                               # print new line character
    la      $a0,                newline
    syscall 

    lw      $t1,                68($t1)
    beqz    $t1,                _cleanprint
    j       _print

_cleanprint:
    lw      $ra,                0($sp)
    addi    $sp,                $sp,                    4
    jr      $ra

sort:
    addi    $sp,                $sp,                    -4
    sw      $ra,                0($sp)
    move    $t7,                $a0                                             # $t7 holds *list
    li      $t1,                0                                               # $t1 is the sorted boolean, set at 0
    #move   $t9,                $t7                                             # keep track of the head

_sort_loop:
    li      $s1,                1
    beq     $t1,                $s1,                    _cleansort

    move    $t2,                $t7                                             # load address of *list into $t2, the current pointer
    li      $t3,                0                                               # load zero into $t3, the previous pointer
    li      $t1,                1                                               # set sorted to 1

_while_loop:
    beq     $t2,                $zero,                  _sort_loop
    lw      $t4,                68($t2)                                         # load address of NEXT into $t4, the next pointer

    beq     $t4,                $zero,                  _else_if

    lw      $t5,                64($t2)                                         # $t5 holds stat of current
    lw      $t6,                64($t4)                                         # $t6 holds stat of next

    bgt     $t5,                $t6,                    _else_if                # branch over if next stat > current stat
    beq     $t5,                $t6,                    _else_if

    li      $t1,                0                                               # change sorted to false

    lw      $t8,                68($t4)                                         # current->next = next->next
    sw      $t8,                68($t2)                                         # current->next = next->next

    sw      $t2,                68($t4)                                         # next->next = current

    beq     $t3,                $zero,                  _else_statement_in_if

    sw      $t4,                68($t3)                                         # previous->next = next



    j       _after_move_head

_else_statement_in_if:
    move    $t7,                $t4                                             # *list = next
                                                                                # bne     $t3,                $zero,                  _after_move_head
    #move   $t9,                $t4                                             # if previous is null, switch the actual head because the thing switching was the head before
    beq     $t3,                $zero,                  _sort_loop

_after_move_head:
    move    $t2,                $t4                                             # current = next
    lw      $t4,                68($t2)                                         # next = current->next

    j       _after_else_if

_else_if:
    beq     $t4,                $zero,                  _after_else_if
    lw      $t5,                64($t2)                                         # $t5 holds stat of current
    lw      $t6,                64($t4)                                         # $t6 holds stat of next
    bne     $t5,                $t6,                    _after_else_if

    move    $a0,                $t2
    move    $a1,                $t4

    addi    $sp,                $sp,                    -40
    sw      $t0,                0($sp)
    sw      $t1,                4($sp)
    sw      $t2,                8($sp)
    sw      $t3,                12($sp)
    sw      $t4,                16($sp)
    sw      $t5,                20($sp)
    sw      $t6,                24($sp)
    sw      $t7,                28($sp)
    sw      $t8,                32($sp)
    sw      $t9,                36($sp)

    jal     strcmp

    lw      $t9,                36($sp)
    lw      $t8,                32($sp)
    lw      $t7,                28($sp)
    lw      $t6,                24($sp)
    lw      $t5,                20($sp)
    lw      $t4,                16($sp)
    lw      $t3,                12($sp)
    lw      $t2,                8($sp)
    lw      $t1,                4($sp)
    lw      $t0,                0($sp)
    addi    $sp,                $sp,                    40

    blt     $v0,                $zero,                  _after_else_if
    beqz    $v0,                _after_else_if

    li      $t1,                0                                               # sorted = false
    lw      $t8,                68($t4)                                         # current->next = next->next
    sw      $t8,                68($t2)                                         # current->next = next->next
    sw      $t2,                68($t4)                                         # next->next = current

    beq     $t3,                $zero,                  _else_in_else_if

    sw      $t4,                68($t3)                                         # previous->next = next
    j       _after_else_if

_else_in_else_if:
    move    $t7,                $t4                                             # head = next


_after_else_if:
    move    $t3,                $t2                                             # previous = current
    move    $t2,                $t4                                             # current = next

    j       _while_loop

_cleansort:
    move    $v0,                $t7
    lw      $ra,                0($sp)
    addi    $sp,                $sp,                    4
    jr      $ra

# $a0 = dest, $a1 = src
strcpy:
    lb      $t2,                0($a1)
    li      $t4,                10
    beq     $t2,                $t4,                    done_copying
    addi    $a1,                $a1,                    1
    j       strcpy

done_copying:
    li      $t2,                0
    sb      $t2,                0($a1)
    jr      $ra

# $a0 = string buffer to be zeroed out
strclr:
    lb      $t0,                0($a0)
    beq     $t0,                $zero,                  done_clearing
    sb      $zero,              0($a0)
    addi    $a0,                $a0,                    1
    j       strclr

done_clearing:
    jr      $ra

# $a0, $a1 = strings to compare
# $v0 = result of strcmp($a0, $a1)
strcmp:
    lb      $t2,                0($a0)
    lb      $t3,                0($a1)

    bne     $t2,                $t3,                    done_with_strcmp_loop
    addi    $a0,                $a0,                    1
    addi    $a1,                $a1,                    1
    beqz    $t2,                done_with_strcmp_loop

    j       strcmp

done_with_strcmp_loop:
    sub     $v0,                $t2,                    $t3
    jr      $ra

.data

name: .space 8
name_prompt: .asciiz "Enter a name:"
DONE: .asciiz "DONE"
space: .asciiz " "
newline: .asciiz "\n"
opposition_prompt: .asciiz "Enter opposition points:"
team_prompt: .asciiz "Enter team points:"