`timescale 1ns / 1ps

module Forwarding_Unit(
    output [1:0] FwdA,
    output [1:0] FwdB,
    output FwdM,
    input RegWrite1,
    input RegWrite2,
    input MemWrite,     //ID/EX MemWrite
    input [4:0] IDEXRs,
    input [4:0] IDEXRt,
    input [4:0] IDEXRd,
    input [4:0] EXMEMRd,
    input [4:0] MEMWBRd
    );
    
    wire Zero1,Zero2,Rs1,Rs2,Rt1,Rt2,MemAcc;
    
    assign Zero1 = ~|(EXMEMRd);
    assign Zero2 = ~|(MEMWBRd);
    
    assign Rs1 = ~|(IDEXRs ^ EXMEMRd);
    assign Rs2 = ~|(IDEXRs ^ MEMWBRd);
    assign Rt1 = ~|(IDEXRt ^ EXMEMRd);
    assign Rt2 = ~|(IDEXRt ^ MEMWBRd);
    
    assign MemAcc = ~|(IDEXRd ^ EXMEMRd);
    
    assign FwdA[1] = RegWrite1 & ~Zero1 & Rs1;
    assign FwdA[0] = (RegWrite2 & ~Zero2 & Rs2) & ~FwdA[1];
    assign FwdB[1] = RegWrite1 & ~Zero1 & Rt1;
    assign FwdB[0] = (RegWrite2 & ~Zero2 & Rt2) & ~FwdB[1];
    
    assign FwdM = MemWrite & ~Zero1 & MemAcc;
    
endmodule
