module mux_2to1(
	input [31:0] datain_0,
	input [31:0] datain_1,
	input sel,
	output [31:0] dataout
);
	assign dataout = (sel)? datain_1 : datain_0; 
		
endmodule



