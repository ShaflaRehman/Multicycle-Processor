`timescale 1ns / 1ps
module ALU (
input clk, 
    input [31:0] pc_out, input[25:0] jump_address,
    input alusrcA, input [1:0] alusrcB,
	 input  [15:0] immediate ,
    input [31:0] read_data1,
    input [31:0] read_data2,
    input [3:0] alu_control,
    output reg [31:0] alu_out,
	 output reg [31:0] alu_result,
	 output [31:0] sign_extend, output reg zero_flag, output reg [31:0]  sign_extend_jump 
);

reg [27:0]jump_shift;
//reg [31:0] sign_extend_jump; 
always@(*)
begin
jump_shift=jump_address<<2;
   sign_extend_jump={ pc_out[31:28], jump_shift};
	end
reg [31:0] operand1;
reg [31:0] operand2;
assign 	  sign_extend= { {16{immediate[15]}} , immediate[15:0]};  
always @(* )
begin
case (alusrcA)
  1'b0: operand1= pc_out;
  1'b1: operand1= read_data1;
  endcase
  case (alusrcB)
  2'b00: operand2= read_data2;
  2'b01: operand2= 1;
  2'b10: operand2=sign_extend;
  2'b11: operand2=sign_extend_jump;
  endcase
  case(alu_control)
        4'b0010: alu_result = operand1 + operand2;
        4'b0110: begin 
		  alu_result = operand1 - operand2;
		  if(alu_result==0)
					zero_flag=1;
					else
					zero_flag=0;
					
		  end
        4'b0000: alu_result = operand1 & operand2;
        4'b0001: alu_result = operand1 | operand2;
        default: alu_result= 32'b0;
    endcase
  end
  always@(posedge clk)
  alu_out<=alu_result;
  begin
  end
  
endmodule
