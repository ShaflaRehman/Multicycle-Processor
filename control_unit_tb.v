`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:07:47 05/07/2024
// Design Name:   ControlUnit
// Module Name:   C:/Users/sibgh/Desktop/Semester 4/CSA/Assignments/Multicycle_Processor/control_unit_tb.v
// Project Name:  Multicycle_Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ControlUnit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module control_unit_tb;

	// Inputs
	reg [5:0] opcode;
	reg clk;
	reg rst;
	reg zero;

	// Outputs
	wire regdst;
	wire jump;
	wire branch;
	wire memread;
	wire memtoreg;
	wire [1:0] aluop;
	wire memwrite;
	wire [1:0] alusrcA;
	wire [1:0] alusrcB;
	wire IRWrite;
	wire IorD;
	wire [1:0] PCsrc;
	wire PCwrite;
	wire PCEn;
	wire regwrite;
	wire [3:0] state;
	wire [3:0] nextstate;

	// Instantiate the Unit Under Test (UUT)
	ControlUnit uut (
		.opcode(opcode), 
		.clk(clk), 
		.rst(rst), 
		.zero(zero), 
		.regdst(regdst), 
		.jump(jump), 
		.branch(branch), 
		.memread(memread), 
		.memtoreg(memtoreg), 
		.aluop(aluop), 
		.memwrite(memwrite), 
		.alusrcA(alusrcA), 
		.alusrcB(alusrcB), 
		.IRWrite(IRWrite), 
		.IorD(IorD), 
		.PCsrc(PCsrc), 
		.PCwrite(PCwrite), 
		.PCEn(PCEn), 
		.regwrite(regwrite),
		.state(state),
		.nextstate(nextstate)
	);

	always begin
	#5 clk=~clk;
	end
	
	initial begin
		// Initialize Inputs
		opcode = 6'b000000;
		clk = 1;
		rst = 0;
		zero = 0;
		#30
		opcode = 6'b000100;
		clk = 1;
		rst = 0;
		zero = 1;
		#30
		rst=1;

	end
      
endmodule

