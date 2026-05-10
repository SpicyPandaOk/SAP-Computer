HLT: inverse is anded with clock so when high stops the clock and therefore the program\

MI: latches the [3:0] bits of the bus into the MAR register as an address for RAM\

RI: latches [7:0] of the bus into the RAM of the address currently output by MAR\

RO: puts the value of the selected RAM onto the bus\

II: loads [7:0] of the bus into the instruction register\

IO: puts [3:0] argument of the instruction register onto the bus \

AI: loads the value of the bus into the A register\

AO: puts the value of the A register onto the bus\

EI: loads the value of the adder into the accumulator\

EO: puts the accumulator onto the bus\

SU: puts the subtract signal high which is xored with B register and input to the Carry in\

BI: loads the bus into the B register\

BO: puts the B register value onto the bus\

OI: loads the value of the bus into the display register\

CE: increments the program counter\

CO: puts the program counter onto [3:0] of the bus\

J: jumps the program counter to [3:0] of the bus\

FI: loads the flags register based on current accumulator\
