`timescale 1ns / 1ps
module Decoder(
    input [31:0] instruction,
    output reg [4:0] rs,
    output reg[4:0] rt,
    output reg[4:0] rd,
    output reg [4:0] shamt,
    output reg[5:0] func,
    output reg[5:0] opcode,
    output reg[15:0] immediate,
    output reg[25:0] jump_address,input clk
);

 
always@(posedge clk)
begin // Assign the fields based on the instruction format
    rs <= instruction[25:21];
    rt <= instruction[20:16];
     rd <= instruction[15:11];
     shamt <= instruction[10:6];
     func <= instruction[5:0];
     opcode <= instruction[31:26];
     immediate <= instruction[15:0];
     jump_address <= instruction[25:0];
end
endmodule
