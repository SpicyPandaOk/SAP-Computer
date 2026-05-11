// compiler.cpp : This file contains the 'main' function. Program execution begins and ends there.
//


#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

#include <unordered_map>
#include <vector>

int main()
{
    std::unordered_map<std::string, int> values;
    values["LDA"] = 0x1;
	values["ADD"] = 0x2;
	values["SUB"] = 0x3;
	values["STA"] = 0x4;
	values["LDI"] = 0x5;
	values["JMP"] = 0x6;
	values["JC"] = 0x7;
	values["JZ"] = 0x8;
    values["OUT"] = 0xE;
	values["HLT"] = 0xF;

    std::ifstream myFile("code.txt");
    std::string output;

    if (!myFile.is_open())
    {
        std::cerr << "Error opening file!" << std::endl;
		return 1;
    }
    int counter = 0;
    std::string line;
    while (std::getline(myFile, line))
    {
        int opcode = 0;
        int arg = 0;
        std::vector<std::string> parts;
        std::istringstream iss(line);
        std::string token;
        while (iss >> token)
        {
            parts.push_back(token);
		}
        if (parts.empty())
        {
            continue;
		}
        
        if (values.contains(parts[0]))
        {
            opcode = values[parts[0]];

        }
        else
        {
            std::cerr << "Invalid instruction: " << parts[0] << std::endl;
            continue;
        }
        
        if (parts.size() > 1 && !parts[1].empty())
        {
			int val = std::stoi(parts[1]);
            if (val >= 0 && val < 16)
            {
                arg = val;
            }
            else
            {
				std::cerr << "Argument out of range (0-15): " << val << std::endl;
                continue;
            }
        }
		int out = (opcode << 4) | arg;
        std::stringstream ss;
		ss << std::hex << out;
        output += ss.str() + "\n";
        counter++;
    }
    myFile.close();
    while (counter < 16)
    {
        output += "0\n";
    }
	std::ofstream outFile("code.mem");
        if (!outFile.is_open())
        {
            std::cerr << "Error opening output file!" << std::endl;
            return 1;
		}

    outFile << output;
	outFile.close();
    return 0;
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu
