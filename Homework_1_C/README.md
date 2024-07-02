# C Programming Homework

This repository contains solutions for a set of C programming problems.

## Table of Contents

- [Problem 1: Tribonacci](#problem-1-tribonacci)
- [Problem 2: Recursion](#problem-2-recursion)
- [Problem 3: Plus/Minus Ranking](#problem-3-plusminus-ranking)
- [Skills Highlight](#skills-highlight)

## Problem 1: Tribonacci

**File:** `tribonacci.c`

**Description:**
This program prints the first N Tribonacci numbers, where N is provided as a command line argument.

## Problem 2: Recursion

**File:** `recurse.c`

**Description:**
This recursive program calculates the function f(N), where N is a positive integer provided as a command line argument. The function is defined as:
- f(0) = 2
- f(N) = 3*N – 2*f(N-1) + 7 (for N > 0)

## Problem 3: Plus/Minus Ranking

**File:** `plusminus.c`

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

### C Programming

### File I/O
- Implemented file reading using `fgets` and `fscanf` to process and extract data from text files.
- Handled input and output file operations, ensuring correct data retrieval and manipulation.

### Command Line Arguments
- Managed command line arguments to dynamically specify input files and parameters, enabling flexible program execution.

### Memory Management
- Understanding memory management for arrays and dynamic data structures in C, involving `malloc` and `free` for memory management.

### Bubble Sort
- Utilized bubble sort to order data based on specific criteria using customized comparators.

### Debugging and Testing
- Ensured that code compiles and runs correctly on Duke Linux machines, adhering to the specified environment requirements.
- Tested programs with various inputs to validate correctness and handle potential edge cases.

