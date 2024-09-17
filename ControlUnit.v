`timescale 1ns / 1ps

module ControlUnit(
    input [5:0] opcode,
    input clk,
    input rst,
    input zero,
    output reg regdst,
    output reg jump,
    output reg branch,
    output reg memread,
    output reg memtoreg,
    output reg [1:0] aluop,
    output reg memwrite,
    output reg alusrcA ,
    output reg [1:0]alusrcB,
    output reg IRWrite,
    output reg IorD,
    output reg [1:0]PCsrc,
    output reg PCwrite,
    output reg PCEn,
    output reg regwrite,
	 output reg [3:0] state,
   output reg [3:0] nextstate

);

always@(*) begin
PCEn = (branch & zero) | PCwrite;
end


parameter IDLE = 4'b1000;
parameter FETCH = 4'b0000;
parameter DECODE = 4'b0001;
parameter MEMADR = 4'b0010;
parameter MEMREAD = 4'b0011;
parameter MEMWRITEBACK = 4'b0100;
parameter MEMWRITE = 4'b0101;
parameter ALUWRITEBACK = 4'b0110;
parameter EXECUTE = 4'b0111;
parameter ADDIEXECUTE = 4'b1000;
parameter ADDIWRITEBACK = 4'b1001;
parameter BRANCH = 4'b1010;
parameter JUMP =4'b1100;

initial begin
    regdst = 1'b0;
    jump = 1'b0;
    branch = 1'b0;
    memread = 1'b0;
    memtoreg = 1'b0;
    aluop = 2'b00;
    memwrite = 1'b0;
    alusrcA = 1'b0;
    alusrcB = 2'b00;
    IRWrite = 1'b0;
    IorD = 1'b0;
    PCsrc = 2'b00;
    PCwrite = 1'b0;
    PCEn = 1'b0;
    regwrite = 1'b0;
	 state=4'b1000;
		nextstate=0;
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= FETCH;
    end
    else begin
        state <= nextstate;
    end
end

always @(state or opcode) begin
    case (state)
			IDLE: nextstate = FETCH;
        FETCH: nextstate = DECODE;
		  DECODE: 
		  begin
		      case ( opcode)
				   6'b000000:  nextstate= EXECUTE;//r-type  
					6'b000100 :  nextstate= BRANCH; //branch
					6'b100011 :  nextstate=MEMADR;//lw
					6'b101011 :  nextstate=MEMADR;///sw
					6'b000010 :  nextstate=JUMP;// jump
					6'b001000 :  nextstate=ADDIEXECUTE;//addi

					endcase
			end
			EXECUTE: nextstate= ALUWRITEBACK;
			BRANCH:  nextstate= FETCH;
			MEMADR:
             begin
		      case ( opcode)
				  
					6'b100011 :  nextstate=MEMREAD;//lw
					6'b101011 :  nextstate=MEMWRITE;///sw
					endcase
			end			
			JUMP: begin
			nextstate=FETCH; 
			end
			ADDIEXECUTE:  nextstate=ADDIWRITEBACK;
			MEMWRITEBACK:  nextstate=FETCH; 
			MEMWRITE:     nextstate=FETCH;
			ALUWRITEBACK:  nextstate=FETCH;
			ADDIWRITEBACK:  nextstate=FETCH;
			MEMREAD: nextstate=MEMWRITEBACK;
    endcase
end

always @(state)
begin
regdst = 1'b0;
    jump = 1'b0;
    branch = 1'b0;
    memread = 1'b0;
    memtoreg = 1'b0;
    aluop = 2'b00;
    memwrite = 1'b0;
    alusrcA = 1'b0;
    alusrcB = 2'b00;
    IRWrite = 1'b0;
    IorD = 1'b0;
    PCsrc = 2'b00;
    PCwrite = 1'b0;
    PCEn = 1'b0;
    regwrite = 1'b0;
    case (state)
        FETCH: begin
				aluop <= 2'b00;
				alusrcA <= 1'b0;
				alusrcB <= 2'b01;
				IRWrite <= 1'b1;
				IorD <= 1'b0;
				PCwrite <= 1'b1;
		  end
		  DECODE: begin
    aluop <= 2'b00;
    alusrcA <= 1'b0;
    alusrcB <= 2'b11;
	 
			end
			EXECUTE:  begin
    aluop <= 2'b10;
    alusrcA <= 1'b1;
    alusrcB <= 2'b00;
	 
	 end
			BRANCH:   begin
    branch <= 1'b1;
    aluop <= 2'b01;
    alusrcA <= 1'b1;
    alusrcB <= 2'b00;

	 end
			MEMADR:
             begin
    aluop = 2'b00;
    alusrcA = 1'b1;
    alusrcB = 2'b10;
	 
				 end
			JUMP: begin
			aluop = 2'b00;
    alusrcA = 1'b1;
    alusrcB = 2'b10;
	PCwrite <= 1'b1;			
	end
			ADDIEXECUTE:  begin
			aluop = 2'b00;
    alusrcA = 1'b1;
    alusrcB = 2'b10;
	 
			end
			MEMWRITEBACK:  begin
			regdst = 1'b0;
    memtoreg = 1'b1;
    regwrite = 1'b1;
	 
	 aluop = 2'b00;
    alusrcA = 1'b1;
    alusrcB = 2'b10;
			end
			MEMWRITE:  begin
			memwrite = 1'b1;
			IorD = 1'b1;
			
	 

			end
			
			ALUWRITEBACK:  begin
			regdst = 1'b1;
    memtoreg = 1'b0;
    regwrite = 1'b1;
	 
			end
			MEMREAD:  begin
			IorD = 1'b1;
			end
			ADDIWRITEBACK:  begin
			regdst = 1'b0;
    memtoreg = 1'b0;
    regwrite = 1'b1;
	 
			end
			endcase
			end
endmodule
