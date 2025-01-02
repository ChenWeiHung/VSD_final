module IF_reg_ID(
	input clk,
	input rst,
	input stall,
	input [31:0] if_pc,
	input [31:0] if_instr,
	output reg [31:0] id_pc,
    output reg [31:0] id_instr
);


	always@(posedge clk)begin
		// rst??
		if(!stall)begin
			id_pc <= if_pc;
			id_instr <= if_instr;	
		end
	end

endmodule



