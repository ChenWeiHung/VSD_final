module ford_mux_4to1(
	input [31:0] datain_0,
	input [31:0] datain_1,
	input [31:0] datain_2,
	input [31:0] datain_3,
	input [1:0] sel,
	output reg [31:0] dataout
);

	always@(*)begin
		case(sel)
			2'd0:	dataout = datain_0;
			2'd1:	dataout = datain_1;
			2'd2:	dataout = datain_2;
			2'd3:	dataout = datain_3;
		endcase
	end

endmodule



