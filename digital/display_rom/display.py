def generate_3digit_7seg_rom():
    # Standard Common Cathode patterns (0-9)
    patterns = [0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x6f]

    with open("rom_7seg_24bit.hex", "w") as f:
        f.write("v2.0 raw\n")
        
        # 8-bit data means 256 possible values (0 to 255)
        for i in range(256):
            # Extract individual digits
            hundreds = i // 100
            tens = (i // 10) % 10
            ones = i % 10
            
            # Map digits to their segment patterns
            h_pat = patterns[hundreds]
            t_pat = patterns[tens]
            o_pat = patterns[ones]
            
            # Combine into a 24-bit word
            # Hundreds in high byte, Tens in middle, Ones in low
            out = (h_pat << 16) | (t_pat << 8) | o_pat
            
            f.write(f"{out:06x}\n")


generate_3digit_7seg_rom()
print("3-digit 8-bit decoder ROM generated!")
