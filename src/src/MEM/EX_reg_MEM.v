module EX_reg_MEM(
	input clk,
	input rst,
	input flush,
	input [3:0] EX_controller_dm_en,
	input EX_controller_mux_rd,
	input EX_controller_regfile_en,
	input [2:0] EX_docoder_func3,
	input [4:0] EX_decoder_rd_index,
	input [31:0] EX_alu_result,
	input [31:0] EX_write_data,

	output reg [3:0] MEM_controller_dm_en,
	output reg MEM_controller_mux_rd,
	output reg MEM_controller_regfile_en,
	output reg [2:0] MEM_docoder_func3,
	output reg [4:0] MEM_decoder_rd_index,
	output reg [31:0] MEM_alu_result,
	output reg [31:0] MEM_write_data

);
	
	always@(posedge clk)begin
		if(rst)begin
			MEM_controller_dm_en <= 4'b0000;
			MEM_controller_regfile_en <= 0;
		end else begin
			// controller signal : mux sel, regfile write enable, memory write en enable
			if(flush)begin// flush nop(data hazard for load-use)
				MEM_controller_dm_en <= 4'b0000;
				MEM_controller_regfile_en <= 0;
			end else begin
				MEM_controller_dm_en <= EX_controller_dm_en;
				MEM_controller_regfile_en <= EX_controller_regfile_en;
			end
			MEM_controller_mux_rd <= EX_controller_mux_rd;

			// decoder :func bit, rd index
			MEM_docoder_func3 <= EX_docoder_func3;
			MEM_decoder_rd_index <= EX_decoder_rd_index;

			// datapath data
			MEM_alu_result <= EX_alu_result;
			MEM_write_data <= EX_write_data;
		end
	end

endmodule