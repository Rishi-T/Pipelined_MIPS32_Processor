`timescale 1ns / 1ps

module EX_MEM(
    output reg [31:0] ALUOutput_out,
    output reg [31:0] Rd_dat_2_out,
    output reg [4:0] DstReg_out,
    output reg [4:0] WBM_out,
    input [31:0] ALUOutput_in,
    input [31:0] Rd_dat_2_in,
    input [4:0] DstReg_in,
    input [3:0] WBM_in,
    input clk,
    input reset
    );
    
    always@(posedge clk or posedge reset)
    begin
    if (reset)
    begin
    ALUOutput_out <= 0;
    Rd_dat_2_out <= 0;
    DstReg_out <= 0;
    WBM_out <= 0;
    end
    else
    begin
    ALUOutput_out <= ALUOutput_in;
    Rd_dat_2_out <= Rd_dat_2_in;
    DstReg_out <= DstReg_in;
    WBM_out <= WBM_in;
    end
    end
endmodule
