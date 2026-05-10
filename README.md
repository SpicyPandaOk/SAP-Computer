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
whole computer:
<img width="1751" height="1254" alt="image" src="https://github.com/user-attachments/assets/d980fff0-d546-4005-936e-3b08344458cb" />

PC:
<img width="1262" height="831" alt="image" src="https://github.com/user-attachments/assets/cc587008-e114-42e3-812d-f7a2e47862d4" />

MAR, RAM and Boot ROM:
<img width="2305" height="842" alt="image" src="https://github.com/user-attachments/assets/46dff00c-5340-4fe3-8ff8-f38659346fda" />

ALU and Flags:
<img width="1131" height="1167" alt="image" src="https://github.com/user-attachments/assets/d5caf4ca-bd1a-4b83-9043-c522bb391b9c" />

Step counter, Control, and Instruction register:
<img width="2265" height="839" alt="image" src="https://github.com/user-attachments/assets/1e45bdef-cb57-45bf-a8a6-5ad1abe974a3" />

7-segment display ROM and register:
<img width="924" height="905" alt="image" src="https://github.com/user-attachments/assets/118c6c1b-5b42-4a39-b5a0-49a4ede79d43" />







