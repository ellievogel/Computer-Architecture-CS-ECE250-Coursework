# CPU Design Project

This repository contains the design and implementation of a CPU using Logisim Evolution. The CPU supports a specified instruction set with 16 instructions, including arithmetic operations, comparators, branches, jumps, input, and output. The design features 8 general-purpose registers and adheres to a Harvard architecture with separate memory spaces for instructions and data.

**File:** cpu.circ

## Table of Contents

- [Register File](#register-file)
- [Reset Functionality](#reset-functionality)
- [Memory Allocation](#memory-allocation)
- [Buffering with Memory Latch](#buffering-with-memory-latch)
- [Design](#design)
- [Skills Highlight](#skills-highlight)


## Register File

The CPU has 8 general-purpose registers: `$r0-$r7`. Key points include:
- `$r0` is the constant value 0 and cannot be modified.
- `$r7` is the link register for the `jal` instruction, similar to `$ra` in MIPS.
- `$r6` is recommended for use as the stack pointer.

The register file's read ports use Tri-state Buffers and a Decoder for faster performance.

## Reset Functionality

The processor has a single input called `reset` that performs the following actions asynchronously:
1. Reset the Program Counter (PC) to 0.
2. Clear the TTY display.
3. Clear the keyboard input buffer.
4. Reset the registers in the register file to all-zero.

Note: The reset input does not affect instruction memory or data memory.

## Memory Allocation

The CPU uses a Harvard architecture with separate memory spaces for instructions and data:
- **Instruction Memory:** Address range 0x0000 to 0x7FFF for user programs.
- **Data Memory:**
  - Static data: First 8 Kwords (0x2000 words).
  - Heap: Starts at address 0x2000 and grows upward.
  - Stack: Starts at address 0x7FFF and grows downward.

## Buffering with Memory Latch

To accommodate the realistic modeling of RAM in Logisim Evolution, a memory latch is used. RAM in configured in the main circuit and connected to data, addresses, and control signals.

## Design

- The project is broken into smaller subcircuits (e.g., ALU, Instruction Decode, Register File, Next PC computation).
- Wiring is neat and organized by utilizing tunnels and splitters effectively.
- Only five clocked components exist: PC register, register file, data memory, keyboard, and TTY.

## Skills Highlight

### Logisim

### Digital Circuit Design
- Instruction Set implementation.
- Register File Design.
- Memory Allocation.

### Modular Design and Testing
- Designed modular subcircuits.
- Developed simple test programs to verify each instruction and functionality individually.

Feel free to explore each file for detailed implementations and comments explaining the logic. If you have any questions or suggestions, please open an issue or submit a pull request.
