# Digital Design Homework - Adder/Subtractor and Finite State Machine

This repository contains solutions for a set of digital design problems using Logisim Evolution, focusing on building and testing a 16-bit ripple-carry adder/subtractor and designing a finite state machine (FSM) for controlling a robot arm. Below is a brief overview of each problem and the skills demonstrated.

## Table of Contents

- [Problem 1: Adder/Subtractor Design](#problem-1-addersubtractor-design)
- [Problem 2: Finite State Machine (FSM)](#problem-2-finite-state-machine-fsm)
- [Extra Circuits](#extra-circuits)
- [Skills Highlight](#skills-highlight)

## Problem 1: Adder/Subtractor Design

**File:** `my_adder.circ`

**Description:**
This project involves building and testing a 16-bit ripple-carry adder using Logisim Evolution. The adder performs addition when the `sub` input is 0 and subtraction when the `sub` input is 1. The design includes an overflow signal (`ovf`) to indicate signed overflow. Created a 1-bit full adder as a module, then utilized the 1-bit full adder to construct a the full adder.

## Problem 2: Finite State Machine (FSM)

**File:** `robot.circ`

**Description:**
This project involves designing a finite state machine (FSM) to control an industrial robot arm. The FSM determines whether the robot is moving in 1D, 2D, or not at all based on the input signals. The FSM is implemented as a Moore machine, where the output depends only on the current state. The systematic design methodology included:
- Drawing a state transition diagram.
- Creating a truth table for the state transition diagram.
- Writing logic expressions for the next-state bits and outputs.

## Extra Circuits

**File:** `circuit1a.circ`
**File:** `circuit2a.circ`

**Description:**
Small circuits to implement given truth tables.

## Skills Highlight

### Logisim

### Digital Circuit Design
- Using modular design principles in Logisim Evolution.
- Implemented boolean logic to detect signed overflow in arithmetic operations.

### Finite State Machine Design
- Designed a finite state machine utilizing state transition diagrams and truth tables.
- Implemented the FSM as a Moore machine, ensuring outputs depend only on the current state.
- Wrote and optimized logic expressions for state transitions and outputs.
