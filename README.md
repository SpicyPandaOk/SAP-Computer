# SAP-Computer
8-bit microcoded CPU:
custom, 8-bit architecture in Digital, built with a 16 instruction set ISA, microcoded control unit, custom built assembler in c++, ROM based bootloading to bypass restrictions on RA, including use for conditional and looping programs

Architecture:
Program Counter puts value to bus, Memory Access Register reads in, puts RAM onto the bus, Instruction register reads in, control ROM reads in and puts out signals.

Features:
16 instruction ISA
16 * 8 RAM
ALU with add and sub
conditional jumps
bootloader ROM
custom assembler
3 digit 7 segment display out

Example: Fibonnaci sequence
LDI 0
STA 14
LDI 1
STA 15
LDA 14
ADD 15
STA 13
OUT
LDA 15
STA 14
LDA 13
STA 15
JMP 4

Converted to:
50
4e
51
4f
1e
2f
4d
e0
1f
4e
1d
4f
64
0
0
0 

and then bootloaded into RAM

Boot Process:
begins in boot mode, reads through Boot ROM memory loads to RAM until reaches the end of ROM and then switches to execution
