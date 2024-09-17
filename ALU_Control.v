`timescale 1ns / 1ps
module ALU_Control( input [1:0] op , input [5:0]func , output reg [3:0] alu_control , input clk);
always@(op or func)
begin

case(op)
 2'b10: 
  begin
    case(func)
	      6'b100000 : alu_control= 4'b0010;
         6'b100010 : alu_control= 4'b0110;
         6'b100100 : alu_control= 4'b0000;
		   6'b100101 : alu_control= 4'b0001;
			default   : alu_control=  4'b0001;
			endcase
	end 
		  
        2'b01:alu_control= 4'b0110;
        2'b00:alu_control= 4'b0010;
        default: alu_control= 4'b0010;
    endcase
end
 











endmodule
