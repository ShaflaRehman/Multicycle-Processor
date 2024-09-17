module PC (
    
    input [31:0] sign_extend_jump,
    input branch,
    input zero,    input [1:0] pc_src,
    input PC_en,
    input IorD,
    input [31:0] alu_result,
    input [31:0] alu_out,
    input [15:0] immediate,
    input clk,
    input rst,
    output reg [31:0] pc_out = 32'b0,
    output reg [31:0] adr
	 //output [31:0] adr//does not have to be a reg, infact maybe must be a wire
);

    always @(posedge clk) begin
        if (rst) begin
            pc_out <= 32'b00000000; // Reset to zero
        end 
		  else if (PC_en)
		  begin
            case (pc_src)
                2'b00: pc_out <= alu_result;
                2'b01: pc_out <= alu_out;
                2'b10: pc_out <= sign_extend_jump;
            endcase
        end
    end

    always @(*) begin
        case(IorD)
            1'b0: adr <= pc_out;
            1'b1: adr <= alu_out;
        endcase
    end

endmodule
