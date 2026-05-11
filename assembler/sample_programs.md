| Fibonacci  | Counter |
|------------|---------|
|LDI 0       |LDI 1|
| STA 14     |STA 15|
|LDI 1       |  LDI 15|
|STA 15      |SUB 15|
|LDA 14      |OUT|
|ADD 15      |JZ 7|
|STA 13      |JMP 3|
|OUT         |HLT|
|LDA 15      | NONE  |
|STA 14      |    NONE|
|LDA 13      |    NONE|
|STA 15      |    NONE|
|JMP 4|    NONE|
