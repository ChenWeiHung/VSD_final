module MEM_reg_WB(
	input clk,
	input rst,
	input MEM_controller_mux_rd,
	input MEM_controller_regfile_en,
	input [2:0] MEM_docoder_func3,
	input [4:0] MEM_decoder_rd_index,
	input [31:0] MEM_dm_dataout,
	input [31:0] MEM_alu_result,
	input fd_unit_lock_signal,
	input fd_unit_need_lock_num,
	input [31:0] forward_data_from_wb_mux,

	output reg WB_controller_mux_rd,
	output reg WB_controller_regfile_en,
	output reg [2:0] WB_docoder_func3,
	output reg [4:0] WB_decoder_rd_index,
	output reg [31:0] WB_dm_dataout,
	output reg [31:0] WB_alu_result,
	output reg [31:0] lock_data,
	output reg lock_ford_signal,
	output reg lock_ford_rs
);

	always@(posedge clk)begin
		if(rst)	WB_controller_regfile_en <= 0;
		else begin
			// controller signal : mux sel, regfile write enable
			WB_controller_mux_rd <= MEM_controller_mux_rd;
			WB_controller_regfile_en <= MEM_controller_regfile_en;

			// decoder :func bit, rd index
			WB_docoder_func3 <= MEM_docoder_func3;
			WB_decoder_rd_index <= MEM_decoder_rd_index;

			// datapath data
			WB_dm_dataout <= MEM_dm_dataout;
			WB_alu_result <= MEM_alu_result;
			
			// for load-use special case, lock data to ex_ford_mux input
			if(fd_unit_lock_signal)begin 
				lock_data <= forward_data_from_wb_mux;
				lock_ford_signal <= 1;
				lock_ford_rs <= fd_unit_need_lock_num;
			end else begin
				lock_ford_signal <= 0;
			end
		end
	end
	
endmodule