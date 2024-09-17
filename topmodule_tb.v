`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:21:44 05/17/2024
// Design Name:   top_module
// Module Name:   C:/Users/sibgh/Desktop/Multicycle_Processor/topmodule_tb.v
// Project Name:  Multicycle_Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module topmodule_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [25:0] jump_address;
	wire [31:0] sign_extend_jump;
	wire branch;
	wire zero;
	wire [31:0] sign_extend;
	wire [1:0] pc_src;
	wire PC_en;
	wire IorD;
	wire [31:0] alu_result;
	wire [31:0] alu_out;
	wire [15:0] immediate;
	wire [31:0] pc_out;
	wire [31:0] adr;
	wire [31:0] instruction;
	wire [31:0] data;
	wire memwrite;
	wire memread;
	wire irwrite;
	wire regdst;
	wire [4:0] rs;
	wire [4:0] rt;
	wire MemtoReg;
	wire RegWrite;
	wire [4:0] rd;
	wire [31:0] read_data1;
	wire [31:0] read_data3;
	wire [31:0] read_data2;
	wire [4:0] shamt;
	wire [5:0] func;
	wire [5:0] opcode;
	wire jump;
	wire [1:0] aluop;
	wire alusrcA;
	wire [1:0] alusrcB;
	wire PCwrite;
	wire [3:0] alu_control;
	wire [3:0] state;
	wire [3:0] nextstate;

	// Instantiate the Unit Under Test (UUT)
	top_module uut (
		.clk(clk), 
		.reset(reset), 
		.jump_address(jump_address), 
		.sign_extend_jump(sign_extend_jump), 
		.branch(branch), 
		.zero(zero), 
		.sign_extend(sign_extend), 
		.pc_src(pc_src), 
		.PC_en(PC_en), 
		.IorD(IorD), 
		.alu_result(alu_result), 
		.alu_out(alu_out), 
		.immediate(immediate), 
		.pc_out(pc_out), 
		.adr(adr), 
		.instruction(instruction), 
		.data(data), 
		.memwrite(memwrite), 
		.memread(memread), 
		.irwrite(irwrite), 
		.regdst(regdst), 
		.rs(rs), 
		.rt(rt), 
		.MemtoReg(MemtoReg), 
		.RegWrite(RegWrite), 
		.rd(rd), 
		.read_data1(read_data1), 
		.read_data3(read_data3), 
		.read_data2(read_data2), 
		.shamt(shamt), 
		.func(func), 
		.opcode(opcode), 
		.jump(jump), 
		.aluop(aluop), 
		.alusrcA(alusrcA), 
		.alusrcB(alusrcB), 
		.PCwrite(PCwrite), 
		.alu_control(alu_control), 
		.state(state), 
		.nextstate(nextstate)
	);
	always
begin
    #20 clk=~clk;
	 end
	initial begin
		// Initialize Inputs
		clk=1;
		reset = 1;
		#100;
		reset=0;
        
		// Add stimulus here

	end
      
endmodule

