module SRAM(
	input clk,
	input  w_en,
	input [15:0] address, 
	input [31:0] write_data,
	output [31:0] read_data
);
	reg [31:0] mem [0:65535];	// 16-bit for this projec, size = 2^16 - 1 = 65535
								// little endian: instruction low index  <----> memory low addr.
								// word alignment
	
	assign read_data = mem[address];

	always@(posedge clk)begin			
		if(w_en) mem[address] <= write_data;
	end
	
endmodule
