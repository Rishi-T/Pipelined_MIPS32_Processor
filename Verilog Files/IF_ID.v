`timescale 1ns / 1ps

module IF_ID(
    output reg [31:0] Inst_out,
    output reg [31:0] PCIncr_out,
    output reg init_out,
    input [31:0] Inst_in,
    input [31:0] PCIncr_in,
    input init_in,
    input IF_IDWrite,
    input IF_IDFlush,
    input clk,
    input reset
    );
    
    always@(posedge clk or posedge reset)
    begin
    if (reset | IF_IDFlush)
    begin
    Inst_out <= 0;
    PCIncr_out <= 0;
    init_out <= 0;
    end
    else if (IF_IDWrite)
    begin
    Inst_out <= Inst_in;
    PCIncr_out <= PCIncr_in;
    init_out <= init_in;
    end
    end
    
endmodule
