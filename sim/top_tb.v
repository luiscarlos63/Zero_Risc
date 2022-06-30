`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2022 11:50:43 AM
// Design Name: 
// Module Name: top_tb
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


//table 1
//05000001
//90000102
//00000301
//02000401

//table 2
//250
//700
//4000
//600
//100

module top_tb(
   );



    reg clk;
    reg but;
    reg rst;
    reg [31:0] instr_addr;
    wire le;
    wire [15:0] debug;

    decoder dec(
    .i_clk(clk), 
    .i_rst(rst), 
    .i_instr_addr(instr_addr), 
    .o_signal(le),
    .debug(debug)
    );
    

	initial begin
		rst = 1;
		#8;
		rst = 0;
	end

   	initial begin
        
        #50;
        instr_addr = 32'h0000_0500;
            #10
            instr_addr = 32'h0000_0250;
		
		#40;
        instr_addr = 32'h0000_0200;
            #10;
            instr_addr = 32'h0000_0100;
        
        #40;
        instr_addr = 32'h0000_0220;
            
        #40;
        instr_addr = 32'h0000_033c;
            #10;
            instr_addr = 32'h0000_0348;
            
        #40;
        instr_addr = 32'h0000_9000;
            #10;
            instr_addr = 32'h0000_0700;
        
        #40;
        instr_addr = 32'h0000_0500;
            #10;
            instr_addr = 32'h0000_0250;
        
        #40;
        instr_addr = 32'h0000_9000;
            #10;
            instr_addr = 32'h0000_4000;
        
        #40;
        instr_addr = 32'h0000_0000;
            #10;
            instr_addr = 32'h0000_0600;
        
        #40;
        instr_addr = 32'h0000_9000;
            #10;
            instr_addr = 32'h0000_0000;
        
        #40;
        instr_addr = 32'h0000_0200;
            #10;
            instr_addr = 32'h0000_0100;
        
         
	end


	always begin
		clk <= 1;
		#(5)
			;
		clk <= 0;
		#(5)
			;
	end
endmodule



