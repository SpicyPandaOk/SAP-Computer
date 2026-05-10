def generate_rom():
    with open("control_unit.hex", "w") as f:
        f.write("v2.0 raw\n")

        # -------------------------------------------------
        # Bit layout (MSB -> LSB)
        # HLT MI RI RO IO II AI AO EI EO SU BI BO OI CE CO J FI
        # -------------------------------------------------

        HLT = 1 << 17
        MI  = 1 << 16
        RI  = 1 << 15
        RO  = 1 << 14
        IO  = 1 << 13
        II  = 1 << 12
        AI  = 1 << 11   # Reg A in
        AO  = 1 << 10   # Reg A out
        EI  = 1 << 9    # Result reg in
        EO  = 1 << 8    # Result reg out
        SU  = 1 << 7
        BI  = 1 << 6
        BO  = 1 << 5
        OI  = 1 << 4
        CE  = 1 << 3
        CO  = 1 << 2
        JU   = 1 << 1
        FI  = 1 << 0

        for addr in range(512):
            c = (addr >> 8) & 1
            z = (addr >> 7) & 1
            opcode = (addr >> 3) & 0xF
            step = addr & 0x7

            out = 0

            # ----------------------------
            # Fetch cycle
            # ----------------------------
            if step == 0:
                out = CO | MI
            elif step == 1:
                out = RO | II | CE

            # ----------------------------
            # 0001 = LDA addr
            # ----------------------------
            elif opcode == 1:
                if step == 2:
                    out = IO | MI 
                elif step == 3:
                    out = RO | AI

            # ----------------------------
            # 0010 = ADD addr
            # ----------------------------
            elif opcode == 2:
                if step == 2:
                    out = IO | MI 
                elif step == 3:
                    out = RO | BI
                elif step == 4:
                    out = EI | FI      # latch ALU result
                elif step == 5:
                    out = EO | AI      # write result into A

            # ----------------------------
            # 0011 = SUB addr
            # ----------------------------
            elif opcode == 3:
                if step == 2:
                    out = IO | MI 
                elif step == 3:
                    out = RO | BI
                elif step == 4:
                    out = EI | SU | FI
                elif step == 5:
                    out = EO | AI

            # ----------------------------
            # 0100 = STA addr
            # ----------------------------
            elif opcode == 4:
                if step == 2:
                    out = IO | MI
                elif step == 3:
                    out = AO | RI

            # ----------------------------
            # 0101 = LDI immediate
            # ----------------------------
            elif opcode == 5:
                if step == 2:
                    out = IO | AI

            # ----------------------------
            # 0110 = JMP
            # ----------------------------
            elif opcode == 6:
                if step in [2,3,4]:
                    out = IO | JU
            
                
                    

            # ----------------------------
            # 0111 = JC
            # ----------------------------
            elif opcode == 7:
                if step == 2:
                    out = (IO | JU) if c else 0
                
                    

            # ----------------------------
            # 1000 = JZ
            # ----------------------------
            elif opcode == 8:
                if step == 2:
                    out = (IO | JU)  if z else 0
                
            # ----------------------------
            # 1110 = OUT
            # ----------------------------
            elif opcode == 14:
                if step == 2:
                    out = AO | OI

            # ----------------------------
            # 1111 = HLT
            # ----------------------------
            elif opcode == 15:
                if step == 2:
                    out = HLT

            f.write(f"{out:x}\n")


generate_rom()
