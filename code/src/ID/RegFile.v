module RegFile(
	input clk,
	input rd_en,
	input [4:0] rs1,
	input [4:0] rs2,
	input [4:0] rd,
	input [31:0] rd_datain,
	output [31:0] rs1_dataout,
	output [31:0] rs2_dataout
);
	reg [31:0] registers [0:31];
	
	// x0 always zero
	assign rs1_dataout = (rs1 == 5'd0)? 32'd0 : registers[rs1];
	assign rs2_dataout = (rs2 == 5'd0)? 32'd0 : registers[rs2];

	always@(posedge clk)begin
		if(rd_en)begin
			if(rd == 5'd0) registers[rd] <= 32'd0;
			else 		   registers[rd] <= rd_datain;
		end
	end


	
endmodule



