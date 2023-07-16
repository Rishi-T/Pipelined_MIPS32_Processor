`timescale 1ns / 1ps

module Control(
    output RegDst,
    output Jump,
    output Branch,
    output Branchinv,
    output MemRead,
    output MemtoReg,
    output [3:0] ALUOp,
    output MemWrite,
    output ALUSrc,
    output RegWrite,
    input [5:0] Opcode,
    input [5:0] funct
    );
    
    wire br,notrtype;
    wire [3:0] opinst,aluc;
    
    assign br = ~(Opcode[5]|Opcode[3]) & ~Opcode[4];
    assign notrtype = |Opcode;
    
    assign ALUSrc = notrtype & ~Branch;
    assign RegDst = ~notrtype;
    assign Jump = br & Opcode[1];
    assign Branch = br & Opcode[2];
    assign Branchinv = Opcode[0];
    assign MemRead = Opcode[5] & ~Opcode[3];
    assign MemtoReg = MemRead;
    assign MemWrite = Opcode[5] & Opcode[3];
    assign RegWrite = RegDst | Opcode[4] | MemRead;
    
    assign opinst = {3'b100,Branch};
    assign aluc = Opcode[4] ? Opcode[3:0] : opinst;
    assign ALUOp = RegDst ? funct[3:0] : aluc;
    
endmodule

//module mux_2x1_4b #(parameter N = 4)(in0, in1, sel, out);

 //   input [N - 1:0] in0, in1;
 //   input sel;
 //   output [N - 1:0] out;
    
 //   assign out  = sel ? in1 : in0;

//endmodule
