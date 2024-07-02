# MIPS Assembly Homework

This repository contains code for the same problems as Homework 1, but in MIPS Assembly

## Table of Contents

- [Problem 1: Tribonacci](#problem-1-tribonacci)
- [Problem 2: Recursion](#problem-2-recursion)
- [Problem 3: Plus/Minus Ranking](#problem-3-plusminus-ranking)
- [Skills Highlight](#skills-highlight)

## Problem 1: Tribonacci

**File:** `tribonacci.s`

**Description:**
This program prints the first N Tribonacci numbers, where N is provided as a command line argument.

## Problem 2: Recursion

**File:** `recurse.s`

**Description:**
This recursive program calculates the function f(N), where N is a positive integer provided as a command line argument. The function is defined as:
- f(0) = 2
- f(N) = 3*N – 2*f(N-1) + 7 (for N > 0)

## Problem 3: Plus/Minus Ranking

**File:** `plusminus.s`

**Description:**
This program reads a file containing basketball player statistics and computes the "plus/minus" metric for each player. The input file format is as follows:
- Each player's statistics are contained in 4 lines:
  1. Player's last name
  2. Points scored by the player's team while on the court (an integer)
  3. Points scored by the opposing team while the player is on the court (an integer)
  4. A blank line or separator (not included in the count)

- The file ends with the string `DONE`.

The program calculates the plus/minus metric for each player using the formula:
- Plus/Minus = (Points scored by the player's team) - (Points scored by the opposing team)

The output will list each player's name along with their plus/minus value. The list is sorted in descending order based on the plus/minus metric. In case of a tie, players are sorted alphabetically by their last name.

## Skills Highlight

### MIPS Assembly Programming

### Dynamic Memory Allocation
- Used dynamic memory allocation to manage memory on the heap.
- Dynamically allocated memory, ensuring flexibility and efficient memory use.
- Understood memory management for dynamic data structures in MIPS assembly.

### Error Handling
- Ensured the program handles incorrect or unexpected input gracefully, including validating console input.
- Implemented error checking for operations to handle scenarios where inputs might be incorrect.

### Compilation and Build Management
- Used SPIM and QtSpim for compiling and running MIPS assembly programs.
- Utilized appropriate flags to facilitate code development and debugging.

### Standard MIPS Conventions
- Followed MIPS calling conventions, including proper saving and restoring of caller- and callee-saved registers.
- Ensured proper stack management, with each function restoring the stack pointer before returning.
- Maintained function independence by not sharing data via registers, using only $a for arguments and $v for return values.
