`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2022 11:23:42 PM
// Design Name: 
// Module Name: decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder(i_clk, i_rst, i_instr_addr, o_signal, debug);
    input i_clk;                        //clock
    input i_rst;                        //reset
    input [31:0] i_instr_addr;          //Instruction Address (PC)
    output reg o_signal;                //"Zero_Risc" signal
    output reg [15:0] debug;            //for debug only, not used
    
//  Local Paremeter
localparam TableSize        = 32;       //Size of table of CGF
                    
//-------------------- Table Memory ---------------------------
wire    [31:0]    TableBranch       [TableSize-1:0];

//------------------------ Hardcoded Table (Just for proof of concept) ----------------------------------
        assign TableBranch[0]   = 32'h0000_0000;
        assign TableBranch[1]   = 32'h0000_0000;
        assign TableBranch[2]   = 32'h01d8_045c;
        assign TableBranch[3]   = 32'h0458_0180;
        assign TableBranch[4]   = 32'h0000_0000;
        assign TableBranch[5]   = 32'h0000_0000;
        assign TableBranch[6]   = 32'h0000_0000;
        assign TableBranch[7]   = 32'h0000_0000;
        assign TableBranch[8]   = 32'h0000_0000;
        assign TableBranch[9]   = 32'h0000_0000;
        assign TableBranch[10]  = 32'h0000_0000;
        assign TableBranch[11]  = 32'h0000_0000;
        assign TableBranch[12]  = 32'h0000_0000;
        assign TableBranch[13]  = 32'h0000_0000;
        assign TableBranch[14]  = 32'h0000_0000;
        assign TableBranch[15]  = 32'h0000_0000;
        assign TableBranch[16]  = 32'h0000_0000;
        assign TableBranch[17]  = 32'h0000_0000;
        assign TableBranch[18]  = 32'h0000_0000;
        assign TableBranch[19]  = 32'h0000_0000;
        assign TableBranch[20]  = 32'h0000_0000;
        assign TableBranch[21]  = 32'h0000_0000;
        assign TableBranch[22]  = 32'h0000_0000;
        assign TableBranch[23]  = 32'h0000_0000;
        assign TableBranch[24]  = 32'h0000_0000;
        assign TableBranch[25]  = 32'h0000_0000;
        assign TableBranch[26]  = 32'h0000_0000;
        assign TableBranch[27]  = 32'h0000_0000;
        assign TableBranch[28]  = 32'h0000_0000;
        assign TableBranch[29]  = 32'h0000_0000;
        assign TableBranch[30]  = 32'h0000_0000;
        assign TableBranch[31]  = 32'h0000_0000;



//----------- always local variables -----------------
    reg [31:0]  PC_now = 0;
    reg [31:0]  PC_f = 0;
    reg [31:0]  PC_d = 0;
    reg [31:0]  PC_e = 0;
    reg [31:0]  PC_before = 0;

    reg         flush;

    reg [2:0]   cycleCount;

    reg match_sig = 0;
    reg isJump;
    reg [4:0]db_cnt = 0;

   always @(posedge i_clk) begin
    if(i_rst)begin
        PC_now      <= 0;
        PC_f        <= 0;
        PC_d        <= 0;
        PC_e        <= 0;
        PC_before   <= 0;
        
        cycleCount  <= 3;
        db_cnt      <=0;
    end
    else begin
        
        db_cnt <= db_cnt + 1; 
        if(i_instr_addr != PC_now || flush)begin
             if(flush)begin
                flush <= 0;
                PC_now      <= 0;
                PC_f        <= 0;
                PC_d        <= 0;
                PC_e        <= 0;
                PC_before   <= 0;
            end
            else begin
                PC_now      <= i_instr_addr;
                PC_f        <= PC_now;
                PC_e        <= PC_f;
                PC_d        <= PC_e;
                PC_before   <= PC_d;
            end
        end
        if(cycleCount > 0)
            cycleCount = cycleCount - 1;
    end
    
    if(i_rst || cycleCount)begin
        o_signal <= 0;
        isJump <= 0;
        flush <= 0;
    end
    
    else begin

        match_sig = 0;
        isJump = 0;
        
        for(idAddr = 0; idAddr < TableSize; idAddr = idAddr+1)begin                                         //for thw whole table
            
            if(PC_before[15:0] == TableBranch[idAddr][31:16] && PC_before[15:0] != 0)begin                  //compares more significant 16 bits  (Jump_Addr)
                isJump = 1;
                flush <= 1;
                PC_before   <= 0;
                if((PC_now[15:0] == TableBranch[idAddr][15:0]  ||                                           //compares more significant 16 bits  (Jump_to_Addr)
                    PC_f[15:0]   == TableBranch[idAddr][15:0]  ||
                    PC_e[15:0]   == TableBranch[idAddr][15:0]) &&
                    PC_before[15:0] != 0)begin
                    
                    match_sig = 1;
                end
            end
        end
        

        //If detects a jump intruction and there is not a match for the "jumped to" address then there was a flow redirection 
        if(isJump & !match_sig)            
            o_signal <= 1;
    end
end
  
endmodule
