module jb_unit(
	input [31:0] op1,
	input [31:0] op2,
	// input [6:0] opcode,
	output [31:0] jb_out
);
	assign jb_out = $signed(op1) + $signed(op2);
	// assign jb_out = (opcode == 7'b1101111)? ((op1 + op2)&(~32'd1)): op1 + op2;	 -->  for 16-bit instr.

endmodule



