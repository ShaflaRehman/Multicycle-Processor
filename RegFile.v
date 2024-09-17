`timescale 1ns / 1ps

module RegFile( input regdst,input [4:0] rs, input [4:0] rt, input [31:0] write_data, 
input [31:0] memory_data , input MemtoReg , input RegWrite,
input [4:0] rd, output reg [31:0] read_data1  , output [31:0] read_data3, 
output reg [31:0] read_data2 , input clk);
parameter N=32;
parameter DEPTH=32;
reg [4:0] destination_register;
reg [N-1:0] regmemory [DEPTH-1:0]; 

	initial begin
		regmemory [0] = 32'h23456341; //add $1, $2, $3
		regmemory [1] = 32'h20006341;
		regmemory [2] = 32'h00114560;
		regmemory [3] = 32'h23670000;
		regmemory [4] = 32'h00000001;
		regmemory [5] = 32'h20089701;
		regmemory [6] = 32'h20012301;
		regmemory [7] = 32'h29840001;
		regmemory [8] = 32'h00000001;
		regmemory [9] = 32'h00000001;
		regmemory [10] = 32'h00000001;
		end
		always@(*)
		begin
	  read_data1= regmemory[rs];
    read_data2= regmemory[rt];	
	 end 
	
always @(*)
begin
    case(regdst)
        1'b1: destination_register<=rd;
		   1'b0: destination_register<=rt;
    endcase
end

always @(posedge clk)
begin
    case(RegWrite)
        1'b1: begin
		  case(MemtoReg)
		  1'b1: begin 
		  regmemory[destination_register]=memory_data;	
		  end
		  1'b0:
		  begin
		  regmemory[destination_register]=write_data;
		  end
		  
		  endcase	
end
endcase
		  
end		
assign read_data3= regmemory[destination_register];	

endmodule

