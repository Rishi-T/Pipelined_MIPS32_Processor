`timescale 1ns / 1ps

module Instr_Mem(
    output [31:0] Instr_Code,
    input [31:0] PC,
    input reset
    );
    
    reg [7:0] mem [63:0]; //byte addressable memory with 48 locations
    
    assign Instr_Code = {mem[PC+3], mem[PC+2], mem[PC+1], mem[PC]}; //BigEndian
    
    always@(reset)
    begin
    if(reset)
        $readmemh("Instructions.mem",mem);
    end
endmodule