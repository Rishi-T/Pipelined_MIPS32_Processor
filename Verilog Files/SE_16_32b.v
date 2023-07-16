`timescale 1ns / 1ps

module SE_16_32b(
    output [31:0] out,
    input [15:0] in
    );
    
    wire [15:0] ext;
    
    assign ext = in[15] ? 16'hFFFF : 16'h0;
    assign out = {ext, in};
    
endmodule