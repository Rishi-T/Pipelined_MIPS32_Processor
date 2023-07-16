`timescale 1ns / 1ps

module adder_32b(
    output [31:0] out,
    output co,
    input [31:0] x,
    input [31:0] y,
    input cin
    );

assign {co,out} = x + y + cin;
    
endmodule