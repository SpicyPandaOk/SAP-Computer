| Opcode | Mnemonic | Operand | Description |
|--------| ---------|---------|------------|
|0x1| LDA | Address| loads RAM of adress into register A|
|0x2| ADD | address| loads RAM of adress into B, adds to register A and puts value into A|
|0x3| SUB | address| loads RAM of adress into B, subtracts to A and puts value to A|
|0x4| STA | Address| puts value of A into RAM of Adress|
|0x5| LDI | value | loads value of argument into A register|
|0x6| JMP | Counter step | Jumps the Program counter to the argument |
|0x7| JC | counter step | Jumps program counter to the argument if carry flag is high|
|0x8| JZ | Counter step | JUmps program counter to the argument if Zero flag is high | 
|0xE| OUT| no argument | outputs the bus to the display and latches that value in until changed| 
|0xF|HLT | no argument | puts the HLT signal high which stops the program | 
