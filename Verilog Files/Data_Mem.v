`timescale 1ns / 1ps

module Data_Mem(
    output reg [31:0] ReadData,
    input [31:0] Address,
    input [31:0] WriteData,
    input MemRead,
    input MemWrite,
    input clk,
    input reset
    );
    
    reg [7:0] mem [39:0]; //byte addressable memory with 40 locations
    
    always@(MemRead, Address)
    begin
    if(MemRead)
        ReadData = {mem[Address+3], mem[Address+2], mem[Address+1], mem[Address]};
    end
    
    always@(posedge clk, posedge reset)
    begin
    if(reset)
        $readmemh("Data.mem",mem);
    else if (MemWrite)
        begin
        mem[Address] <= WriteData[7:0];
        mem[Address+1] <= WriteData[15:8];
        mem[Address+2] <= WriteData[23:16];
        mem[Address+3] <= WriteData[31:24];
        $writememh("Data.mem", mem);
        end
    end
endmodule