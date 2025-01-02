module load_filter(
	input [31:0] load_data,
	input [2:0] func3,
	output reg [31:0] filter_data
);
	always@(*)begin
		case(func3)
			// lb (load byte signed)
			3'b000:begin
				filter_data[7:0] = load_data[7:0];
				if(load_data[7])	filter_data[31:8] = {24{1'b1}};
				else             	filter_data[31:8] = {24{1'b0}};
			end

			// lh (load half word signed)
			3'b001:begin
				filter_data[15:0] = load_data[15:0];
				if(load_data[15])	filter_data[31:16] = {16{1'b1}};
				else 			  	filter_data[31:16] = {16{1'b0}};
			end

			// lw (load word)
			3'b010:	filter_data = load_data;

			// lbu (load byte unsigned)
			3'b100:begin
				filter_data[7:0] = load_data[7:0];
				filter_data[31:8] = {24{1'b0}};
			end

			// lhu (load hlaf word unsigned)
			3'b101:begin
				filter_data[15:0] = load_data[15:0];
				filter_data[31:16] = {16{1'b0}};
			end
			
			default:filter_data = 32'd0;

		endcase
	end

endmodule



