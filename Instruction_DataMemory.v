`timescale 1ns / 1ps
module Instruction_DataMemory #(parameter N=32, DEPTH=32)
(input [N-1:0]address, input reset,
output reg [N-1:0] instruction , 
 reg [N-1:0] data,
output reg [N-1:0] mdr,
input clk , 
input memwrite, 
input irwrite, 
input [N-1:0]write_data); 
	reg [N-1:0] memory [DEPTH-1:0]; 

	initial begin
		memory [0] = 32'b000000_00001_00010_00000_00000_100000; //add $1, $2, $3
		memory [1] = 32'b100011_00100_00101_0000000000000000;  //lw
			memory [3] = 32'b000100_01001_01000_0000000000000100; //beq
		memory [2] = 32'b000000_00001_00101_00000_00000_100010; //sub
		memory [4] = 32'b000000_00001_00010_00000_00000_100100;//and
		memory [5] = 32'b000000_00001_00010_00000_00000_100101; //or
		memory [6] = 32'b001000_00001_00010_0000000001100100; //addui
	
		memory [7] = 32'b101011_00110_00011_0000000000000001;  //sw
		memory [8] = 32'b000010_00000000000000000000000001;//j label
		memory [9] = 32'b000011_000000000000000000000010; //jal
		memory[10]= 32'd40;
	   memory[11]= 32'd50;
      memory[12]= 32'd60;
	   memory[13]= 32'd70;
	   memory[14]= 32'd80;
	   memory[15]= 32'd90;
	   memory[16]= 32'd100;
	   memory[17]= 32'd10;
	   memory[18]= 32'd20;
	   memory[19]= 32'd30;
	  memory[20]= 32'd45;
		
	end
	
	always@(posedge clk)
	begin
	case(memwrite)
		1'b1: memory[address]<=write_data;
		endcase
	end
	always@(* )
	begin
	data <= memory [address];
	case (irwrite)
	    1'b1: instruction <= memory [address];
		 //1'b1:  data <= memory [address];
	endcase
		
	end
	always@(posedge clk or posedge reset)begin
		if(reset)
			mdr<=0;
		else
			mdr<=data;
	end
	
endmodule 
