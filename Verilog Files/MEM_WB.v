`timescale 1ns / 1ps

module MEM_WB(
    output reg [31:0] ReadData_out,
    output reg [31:0] ALUOutput_out,
    output reg [4:0] DstReg_out,
    output reg [1:0] WB_out,
    input [31:0] ReadData_in,
    input [31:0] ALUOutput_in,
    input [4:0] DstReg_in,
    input [1:0] WB_in,
    input clk,
    input reset
    );
    
    always@(posedge clk or posedge reset)
    begin
    if (reset)
    begin
    ReadData_out <= 0;
    ALUOutput_out <= 0;
    DstReg_out <= 0;
    WB_out <= 0;
    end
    else
    begin
    ReadData_out <= ReadData_in;
    ALUOutput_out <= ALUOutput_in;
    DstReg_out <= DstReg_in;
    WB_out <= WB_in;
    end
    end
endmodule
