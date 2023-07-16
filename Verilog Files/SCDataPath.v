`timescale 1ns / 1ps

module SCDataPath(
    input clk,
    input reset
    );
    reg [31:0] PC;
    reg init;
    wire [31:0] Instr,Instr_buf,Rd_dat_1,Rd_dat_1_buf,Rd_dat_2,Rd_dat_2_buf1,Rd_dat_2_buf2,WriteData,SE,SE_buf,ALUA,ALUB,ReadDat,ReadDat_buf,PCNext;
    wire [31:0] ALUOutput,ALUOutput_buf1,ALUOutput_buf2,temp1,temp2,temp3,DataMemIn,JumpAddr,BranchAddr,PCBranch,PCIncr,PCIncr_buf1,PCIncr_buf2;
    wire [11:0] WBMEX,WBMEX_in;
    wire [3:0] WBM;
    wire [1:0] FwdA,FwdB,WB;
    wire [14:0] Instpart;
    wire [4:0] DstReg,DstReg_buf1,DstReg_buf2;
    wire ALUSrc,RegDst,Jump,Branch,Branchinv,MemRead,MemtoReg,MemWrite,RegWrite,Zero,Zeroproc,branchcond;
    wire PCWrite,IF_IDWrite,MuxSel,init_buf,init_used,FwdM;
    wire [3:0] ALUOp;
    
    always@(posedge clk or posedge reset)
    begin
    if (reset)
        init <= 1;
    else
        init <= 0;
    end
    
    always@(posedge clk or posedge reset)
    begin
    if (reset)
        PC <= 0;
    else if (PCWrite)
        PC <= PCNext;
    end
    
    Instr_Mem im(Instr,PC,reset);
    
    assign PCIncr = PC + 4;
    assign JumpAddr = {PCIncr_buf1[31:28],Instr_buf[25:0],1'b0,1'b0};
    assign PCBranch = branchcond ? BranchAddr : PCIncr;
    assign PCNext = (Jump & ~branchcond) ? JumpAddr : PCBranch;
    
    
    IF_ID stg1(Instr_buf,PCIncr_buf1,init_buf,Instr,PCIncr,init,IF_IDWrite,Jump | branchcond,clk,reset);
    
    
    Control ctrl(RegDst,Jump,Branch,Branchinv,MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite,Instr_buf[31:26],Instr_buf[5:0]);
    Register_File rf(Rd_dat_1,Rd_dat_2,WriteData,Instr_buf[25:21],Instr_buf[20:16],DstReg_buf2,WB[0],clk,reset);
    SE_16_32b se(SE,Instr_buf[15:0]);
    
    assign init_used = init | init_buf;
    HzdDetection_Unit hzd(IF_IDWrite,PCWrite,MuxSel,WBMEX[8],Instpart[9:5],Instr_buf[25:21],Instr_buf[20:16],init_used);
    assign WBMEX_in = (MuxSel | branchcond) ? {12'b0} : {MemtoReg,RegWrite,MemWrite,MemRead,Branch,Branchinv,ALUSrc,ALUOp,RegDst};
    
    
    ID_EX stg2(PCIncr_buf2,Rd_dat_1_buf,Rd_dat_2_buf1,SE_buf,Instpart,WBMEX,PCIncr_buf1,Rd_dat_1,Rd_dat_2,SE,Instr_buf[25:11],WBMEX_in,clk,reset);
    
    
    assign temp1 = FwdA[0] ? WriteData : Rd_dat_1_buf;
    assign ALUA = FwdA[1] ? ALUOutput_buf1 : temp1;
    assign temp2 = FwdB[0] ? WriteData : Rd_dat_2_buf1;
    assign temp3 = FwdB[1] ? ALUOutput_buf1 : temp2;
    assign ALUB = WBMEX[5] ? SE_buf : temp3;
    
    ALU_32b alu(ALUOutput,Zero,ALUA,ALUB,WBMEX[4:1]);
    assign Zeroproc = Zero ^ WBMEX[6];
    assign BranchAddr = PCIncr_buf2 + {SE_buf[29:0],1'b0,1'b0};
    assign DstReg = WBMEX[0] ? Instpart[4:0] : Instpart[9:5]; 
    assign branchcond = Zeroproc & WBMEX[7];
    
    Forwarding_Unit fwd(FwdA,FwdB,FwdM,WBM[3],WB[0],WBMEX[8],Instpart[14:10],Instpart[9:5],DstReg,DstReg_buf1,DstReg_buf2);
    assign DataMemIn = FwdM ? ALUOutput_buf2 : Rd_dat_2_buf1;
    
    
    EX_MEM stg3(ALUOutput_buf1,Rd_dat_2_buf2,DstReg_buf1,WBM,ALUOutput,DataMemIn,DstReg,WBMEX[11:8],clk,reset);

    
    Data_Mem dm(ReadDat,ALUOutput_buf1,Rd_dat_2_buf2,WBM[0],WBM[1],clk,reset);
    
    
    MEM_WB stg4(ReadDat_buf,ALUOutput_buf2,DstReg_buf2,WB,ReadDat,ALUOutput_buf1,DstReg_buf1,WBM[3:2],clk,reset);
    
    
    assign WriteData = WB[1] ? ReadDat_buf : ALUOutput_buf2;
    
endmodule