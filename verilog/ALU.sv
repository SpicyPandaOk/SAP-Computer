// Code your design here
module alu (
  input [31:0] a,b,
  input [2:0] sel,
  output reg [31:0] result,
  output reg carry, zero, negative, overflow);
  
  wire[31:0] add_out, sub_out, and_out, or_out, xor_out, not_out, left_out, right_out;
  wire carry_add, carry_sub;
  
  add add1(.a(a), .b(b), .cout(carry_add), .sum(add_out));
  sub sub1(.a(a), .b(b), .cout(carry_sub), .sum(sub_out));
  ander and1(.a(a), .b(b), .result(and_out));
  orer or1 (.a(a), .b(b),  .result(or_out));
  xorer xor1 (.a(a), .b(b), .result(xor_out));
  noter not1 (.a(a), .not_a(not_out));
  l_shift left1 (.a(a), .result(left_out));
  r_shift right1 (.a(a), .result(right_out));
  always @(*) begin
    case(sel)
      3'b0: result = add_out;
      3'b1: result = sub_out;
      3'b10: result = and_out;
      3'b11: result = or_out;
      3'b100: result = xor_out;
      3'b101: result = not_out;
      3'b110: result = left_out;
      3'b111: result = right_out;
      default: result = 0;
    endcase
    carry = (sel == 3'b0) ?  carry_add: (sel == 3'b1) ? carry_sub : 1'b0;
    zero = result == 1'd0;
    negative =  result[31];
    overflow = (sel == 3'b0) ? (a[31] == b[31]) && (result[31] != a[31]): (sel== 3'b1) ? (a[31] != b[31]) && (result[31] != a[31]): 1'd0;
  end
endmodule


module l_shift(
  input [31:0] a,
  output [31:0] result);
  assign result = {a[30:0], 1'b0};
endmodule

module r_shift(
  input [31:0] a,
  output [31:0] result);
  assign result = {1'b0, a[31:1]};
endmodule
    

module ander (
  input [31:0] a, b,
  output [31:0] result);
  
  assign result = a & b;
endmodule

module orer (
  input [31:0] a, b,
  output [31:0] result);
  
  assign result = a | b;
endmodule

module xorer(
  input [31:0] a, b,
  output [31:0] result);
  
  assign result = a ^ b;
endmodule

module noter(
  input[31:0] a,
  output [31:0] not_a);
  
  assign not_a = ~a;
endmodule
 

module add(
  input[31:0] a, b,
  output [31:0] sum,
  output cout);
  
  wire[7:0] c_outs;
  
  genvar i;
  generate
    for(i = 0; i < 8; i = i + 1) begin : add_block
      if(i  == 0) begin
        cla_bloc cla1 (
          .a(a[3:0]), 
          .b(b[3:0]), 
          .cin(1'b0), 
          .cout(c_outs[0]), 
          .sum(sum[3:0]));
      end
      else begin
        cla_bloc cla_inst (
          .a(a[i*4 +:4]),
          .b(b[i*4 +: 4]),
          .cin(c_outs[i-1]),
          .cout(c_outs[i]),
          .sum(sum[i*4 +: 4]));
      end
    end
    assign cout = c_outs[7];
  endgenerate
        
  
endmodule

module sub(
  input [31:0] a, b,
  output [31:0] sum,
  output cout);
  
  wire[7:0] c_outs;
  
  genvar i;
  generate 
    for(i = 0; i < 8; i = i + 1) begin : sub_block;
      if(i == 0) begin
        cla_bloc cla1 (
          .a(a[3:0]), 
          .b(~b[3:0]),
          .cin(1'b1),
          .sum(sum[3:0]),
          .cout(c_outs[0]));
      end else begin
        cla_bloc cla_inst (
          .a(a[i*4 +: 4]),
          .b(~b[i*4 +: 4]),
          .cin(c_outs[i - 1]),
          .sum(sum[i*4 +: 4]),
          .cout(c_outs[i]));
      end
    end
  endgenerate
  assign cout = c_outs[7];
endmodule


module cla_bloc(
  input [3:0] a, b,
  input cin,
  output [3:0] sum,
  output cout);
  
  wire [3:0] g, p,c;
  assign g = a&b;
  assign p = a ^b;
  
  assign c[0] = cin;
  assign c[1] = g[0] | (p[0] & c[0]);
  assign c[2] = g[1] | (p[1] & g[0] ) | (p[1] & p[0] & c[0]);
  assign  c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c[0]);
  assign cout = g[3] | (p[3] & c[3]);
  assign sum = p ^ c;
endmodule
