module decoder(
	input [31:0] instruction,
	output [4:0] opcode_5bit,
	output [2:0] func3,
	output func7_1bit,
	output [4:0] rs1_index,rs2_index,rd_index
);
	assign opcode_5bit = instruction[6:2];
	assign rd_index = instruction[11:7];
	assign func3 = instruction[14:12];
	assign rs1_index = instruction[19:15];
	assign rs2_index = instruction[24:20];
	assign func7_1bit = instruction[30];

endmodule

