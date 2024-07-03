# Cache Simulator Project

This repository contains a simulator of a single-level cache and the memory underneath it. The simulator processes memory access traces and simulates a cache with configurable size, associativity, and block size. The replacement policy used is LRU (Least Recently Used).

**File** cachesim.c

## Table of Contents

- [Introduction](#introduction)
- [Important Assumptions](#important-assumptions)
- [Program Output](#program-output)
- [Skills Highlight](#skills-highlight)

## Introduction

The simulator, called `cachesim`, takes the following input parameters on the command line: name of the file holding the loads and stores, cache size (not including tags or valid bits) in kB, associativity, and the block size in bytes. For example, `cachesim tracefile 1024 4 32` simulates a cache that is 1024kB (=1MB), 4-way set-associative, has 32-byte blocks, and uses LRU replacement.

## Important Assumptions

- Addresses are 24-bits (3 bytes), ranging from 0 to 2^24-1 (i.e., 16MB of address space).
- The machine is byte-addressed and big-endian.
- Cache size will be no larger than 2MB.
- Block size will be no larger than 1024 bytes.
- All cache blocks are initially invalid.
- All cache misses are satisfied by the main memory.
- The cache is write-back and write-allocate.
- Memory defaults to all zeroes on boot.

## Program Output

For every access, the file prints out what kind of access it is (load or store), what address it’s accessing (in base-16), and whether it is a hit or a miss. For each load, it prints out the value that is loaded (possibly after satisfying the miss from memory). If an access requires a valid block to first be evicted, the simulator prints out the address of the evicted block and whether it is dirty or clean.

## Skills Highlight

### C Programming

### Memory Management
  - Addressed a 24-bit address space (16MB) with byte-addressable memory.
  - Managed cache states with valid and dirty bits.
  - Handled write-back and write-allocate policies.

### File I/O
  - Parsed and processed memory access trace files with `fscanf` for reading whitespace-delimited tokens.
