`timescale 1ns / 1ps

module ID_EX(
    output reg [31:0] PCIncr_out,
    output reg [31:0] Rd_dat_1_out,
    output reg [31:0] Rd_dat_2_out,
    output reg [31:0] SE_out,
    output reg [14:0] Instpart_out,
    output reg [11:0] WBMEX_out,
    //output reg init_out,
    input [31:0] PCIncr_in,
    input [31:0] Rd_dat_1_in,
    input [31:0] Rd_dat_2_in,
    input [31:0] SE_in,
    input [14:0] Instpart_in,
    input [11:0] WBMEX_in,
    //input init_in,
    input clk,
    input reset
    );
    
    always@(posedge clk or posedge reset)
    begin
    if (reset)
    begin
    PCIncr_out <= 0;
    Rd_dat_1_out <= 0;
    Rd_dat_2_out <= 0;
    SE_out <= 0;
    Instpart_out <= 0;
    WBMEX_out <= 0;
    //init_out <= 0;
    end
    else
    begin
    PCIncr_out <= PCIncr_in;
    Rd_dat_1_out <= Rd_dat_1_in;
    Rd_dat_2_out <= Rd_dat_2_in;
    SE_out <= SE_in;
    Instpart_out <= Instpart_in;
    WBMEX_out <= WBMEX_in;
    //init_out <= init_in;
    end
    end
    
endmodule
