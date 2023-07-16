`timescale 1ns / 1ps

module ALU_32b(
    output [31:0] ALUOut,
    output Zero,
    input [31:0] A,
    input [31:0] B,
    input [3:0] Control
    );
    
    wire [31:0] out00,out01,out0,out1,out20,out21,out2,out3,bin,w1,w2,result;
    wire mode, carry, set, bshft, err;
    
    assign mode = Control[1] | Control[0];
    assign err = (Control[3] & Control[2]) | (~Control[3] & ~Control[2] & Control[1]) | (~Control[2] & Control[1] & Control[0]) | (Control[2] & ~Control[1] & Control[0]);
    
    and_32b u1(out00,A,B);
    or_32b u2(out01,A,B);
    assign out0 = Control[0] ? out01 : out00;
    
    assign bshft = |B[31:6] | B[5];
    shifter shft(A,{bshft,B[4:0]},Control[1:0],out1);
    
    assign bin = B ^ {32{mode}};
    adder_32b u3(out20,carry,A,bin,mode);
    slt_32b u4(set,out20);
    assign out21 = {31'b0,set};
    assign out2 = Control[1] ? out21 : out20;
    
    assign out3 = 32'b0;
    
    assign w1 = Control[2] ? out1 : out0;
    assign w2 = Control[2] ? out3 : out2;
    assign result = Control[3] ? w2 : w1;
    
    assign Zero = ~|result;
    assign ALUOut = err ? 32'hFFFFFFFF : result;
    
    
endmodule

module and_32b(
    output [31:0] out,
    input [31:0] x,
    input [31:0] y
    );

assign out = x & y;
    
endmodule

module or_32b(
    output [31:0] out,
    input [31:0] x,
    input [31:0] y
    );

assign out = x | y;
    
endmodule


module slt_32b(
    output out,
    input [31:0] x
    );

assign out = x[31] ? 1'b1 : 1'b0;
    
endmodule
