module program_counter(
	input clk,
	input rst,
	input stall,
	input [31:0] next_pc,
	output reg [31:0] curr_pc
);

	always@(posedge clk)begin
		if(rst)	        curr_pc <= 32'd0;
		else if(!stall)	curr_pc <= next_pc;
	end

endmodule

