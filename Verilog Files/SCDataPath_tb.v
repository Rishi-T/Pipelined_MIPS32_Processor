`timescale 1ns / 1ps
module SCDataPath_tb;
    reg clk,reset;
    
    SCDataPath u1(clk,reset);
    
    initial // initializing the system
    begin
    clk = 1;
    reset = 0;
    #10
    reset = 1;
    #10
    reset = 0;
    end
    
    initial 
    begin
    #20
    repeat(100)
    #100
    clk = ~clk;
    
    //$finish;
    end

endmodule
