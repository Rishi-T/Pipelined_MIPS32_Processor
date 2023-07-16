`timescale 1ns / 1ps

module HzdDetection_Unit(
    output IF_IDWrite,
    output PCWrite,
    output MuxSel,
    input IDEX_MemRead,
    input [4:0] IDEXRt,
    input [4:0] IFIDRs,
    input [4:0] IFIDRt,
    input init
    );
    
    wire check1,check2,set;
    
    assign check1 = ~|(IDEXRt ^ IFIDRs);
    assign check2 = ~|(IDEXRt ^ IFIDRt);
    
    assign set = IDEX_MemRead & (check1 | check2);
    
    assign IF_IDWrite = ~set | init;
    assign PCWrite = ~set | init;
    assign MuxSel = set & ~init;
    
endmodule
