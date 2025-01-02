module ID_reg_EX(
	input clk,
	input rst,
	input stall,
	input flush,
	input ID_controller_mux_jb,
	input ID_controller_mux_op1,
	input ID_controller_mux_op2,
	input ID_controller_jb_prepare,
	input [3:0] ID_controller_dm_en,
	input ID_controller_mux_rd,
	input ID_controller_regfile_en,
	input [31:0] ID_pc,
	input [4:0] ID_decoder_opcode,
	input [2:0] ID_decoder_func3,
	input ID_decoder_func7,
	input [4:0] ID_decoder_rs1_index,
	input [4:0] ID_decoder_rs2_index,
	input [4:0] ID_decoder_rd_index,
	input [31:0] ID_rs1_data,
	input [31:0] ID_rs2_data,
	input [31:0] ID_extension_imm,
	
	output reg EX_controller_mux_jb,
	output reg EX_controller_mux_op1,
	output reg EX_controller_mux_op2,
	output reg EX_controller_jb_prepare,
	output reg [3:0] EX_controller_dm_en,
	output reg EX_controller_mux_rd,
	output reg EX_controller_regfile_en,
	output reg [31:0] EX_pc,
	output reg [4:0] EX_decoder_opcode,
	output reg [2:0] EX_decoder_func3,
	output reg EX_decoder_func7,
	output reg [4:0] EX_decoder_rs1_index,
	output reg [4:0] EX_decoder_rs2_index,
	output reg [4:0] EX_decoder_rd_index,
	output reg [31:0] EX_rs1_data,
	output reg [31:0] EX_rs2_data,
	output reg [31:0] EX_extension_imm 
);
	reg flush_buffer;

	always@(posedge clk)begin
		if(rst)begin
			EX_controller_dm_en <= 4'b0000;
			EX_controller_regfile_en <= 0;
			EX_controller_jb_prepare <= 0;
			flush_buffer <= 1;
		end else if(!stall)begin
			// flush signal store(control hazard need 2 cycle nop)
			if(flush)	flush_buffer <= 1;
			else	 	flush_buffer <= 0;

			// controller signal: mux sel, regfile write enable, memory write en enable
			EX_controller_mux_jb <= ID_controller_mux_jb;
			EX_controller_mux_op1 <= ID_controller_mux_op1;
			EX_controller_mux_op2 <= ID_controller_mux_op2;
			if(flush|flush_buffer)begin// flush nop(control hazard)
				EX_controller_jb_prepare <= 0;
				EX_controller_dm_en <= 4'b0000;
				EX_controller_regfile_en <= 0;
			end else begin
				EX_controller_jb_prepare <= ID_controller_jb_prepare;
				EX_controller_dm_en <= ID_controller_dm_en;
				EX_controller_regfile_en <= ID_controller_regfile_en;
			end
			EX_controller_mux_rd <= ID_controller_mux_rd;

			// program counter
			EX_pc <= ID_pc;

			// decoder: opcode, func bit, rs,rd index
			EX_decoder_opcode <= ID_decoder_opcode;
			EX_decoder_func3 <= ID_decoder_func3;
			EX_decoder_func7 <= ID_decoder_func7;
			EX_decoder_rs1_index <= ID_decoder_rs1_index;
			EX_decoder_rs2_index <= ID_decoder_rs2_index;
			EX_decoder_rd_index <= ID_decoder_rd_index;

			// datapath data: RegFile data, immediate value
			EX_rs1_data <= ID_rs1_data;
			EX_rs2_data <= ID_rs2_data;
			EX_extension_imm <= ID_extension_imm;
		end
	end

endmodule