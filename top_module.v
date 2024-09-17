`timescale 1ns / 1ps

module top_module(input clk, input reset,output [25:0] jump_address,
    output [31:0] sign_extend_jump,
    output branch,
    output zero,
    output [31:0] sign_extend,
    output [1:0] pc_src,
    output PC_en,
    output IorD,
    output [31:0] alu_result,
   output[31:0] alu_out,
    output [15:0] immediate,
    output wire [31:0] pc_out ,
    output [31:0] adr ,
	 output[31:0] instruction ,
	 output [31:0] data, 
output memwrite, 
output memread, 
    output irwrite, 
	 output regdst,
	 output [4:0] rs,
	 output [4:0] rt, 	 
	 
	output MemtoReg ,
	output RegWrite,
output [4:0] rd, 
output [31:0] read_data1  , 
output [31:0] read_data3, 
output[31:0] read_data2  ,
output [4:0] shamt,
 output [5:0] func ,
 output  [5:0] opcode, 
 
  //decoder
  
    output  jump,
    output  [1:0] aluop,
    output  alusrcA ,
    output  [1:0]alusrcB,
	 output  PCwrite,
	   output  [3:0] alu_control  ,
		output [3:0] state,
		output [3:0] nextstate	
    );	 

PC pc_called (
    .sign_extend_jump(sign_extend_jump), 
    .branch(branch), 
    .zero(zero), 
    .pc_src(pc_src), 
    .PC_en(PC_en), 
    .IorD(IorD), 
    .alu_result(alu_result), 
    .alu_out(alu_out), 
    .immediate(immediate), 
    .clk(clk), 
    .rst(reset), 
    .pc_out(pc_out), 
    .adr(adr)
    );
	 
	 Instruction_DataMemory instruction_dataMemory (
    .address(adr), 
    .instruction(instruction), 
    .mdr(data), 
    .clk(clk), 
    .memwrite(memwrite), 
    .irwrite(irwrite), 
    .write_data(read_data2),
	 .reset(reset)
    );
	 
RegFile regfile (
    .regdst(regdst), 
    .rs(rs), 
    .rt(rt), 
    .write_data(alu_out), // ALU Result 
    .memory_data(data), 
    .MemtoReg(MemtoReg), 
    .RegWrite(RegWrite), 
    .rd(rd), 
    .read_data1(read_data1), 
    .read_data3(read_data3), 
    .read_data2(read_data2), 
    .clk(clk)
    );
	
// Instantiate the module
Decoder decoder ( 
    .instruction(instruction), 
    .rt(rt), 
    .rd(rd),
	 .rs(rs),
    .shamt(shamt), 
    .func(func), 
    .opcode(opcode), 
    .immediate(immediate), 
    .jump_address(jump_address),
	 .clk(clk)
    );	 
 
ControlUnit control_unit (
    .opcode(opcode), 
    .clk(clk), 
    .rst(reset), 
    .zero(zero), 
    .regdst(regdst), 
    .jump(jump), 
    .branch(branch), 
    .memread(memread), 
    .memtoreg(MemtoReg), 
    .aluop(aluop), 
    .memwrite(memwrite), 
    .alusrcA(alusrcA), 
    .alusrcB(alusrcB), 
    .IRWrite(irwrite), 
    .IorD(IorD), 
    .PCsrc(pc_src), 
    .PCwrite(PCwrite), 
    .PCEn(PC_en), 
    .regwrite(RegWrite),
	 .state(state),
	 .nextstate(nextstate)
    );


ALU_Control alu_Control (
    .op(aluop), 
    .func(func), 
    .alu_control(alu_control), 
    .clk(clk)
    );

ALU alu (
    .clk(clk), 
    .pc_out(pc_out), 
    .alusrcA(alusrcA), 
    .alusrcB(alusrcB), 
    .immediate(immediate), 
    .read_data1(read_data1), 
    .read_data2(read_data2), 
    .alu_control(alu_control), 
    .alu_out(alu_out), 
	 .alu_result(alu_result),
    .sign_extend(sign_extend), 
    .zero_flag(zero), 
    .sign_extend_jump(sign_extend_jump),
	 .jump_address(jump_address)
    );

endmodule
