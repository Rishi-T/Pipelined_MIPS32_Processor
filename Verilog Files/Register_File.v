`timescale 1ns / 1ps

module Register_File(
    output [31:0] Rd_dat_1,
    output [31:0] Rd_dat_2,
    input [31:0] WriteData,
    input [4:0] Rd_1,
    input [4:0] Rd_2,
    input [4:0] Wr,
    input RegWrite,
    input clk,
    input reset
    );
    
    reg [31:0] Register [31:0];
    
    localparam init = 32'hFFFFFFFF;
    integer i;
    
    always@(posedge reset)
    begin
        $readmemh("Registers.mem",Register);
    end
    
    always@(posedge clk)
    begin
    if (RegWrite & Wr != 0)
        Register[Wr] <= WriteData;
    end
    
    assign Rd_dat_1 = Register[Rd_1];
    assign Rd_dat_2 = Register[Rd_2];
endmodule
