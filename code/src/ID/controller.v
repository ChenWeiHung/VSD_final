module controller(
	input [4:0] opcode,
	input [2:0] func3,
	input func7,
	output reg im_w_en,
	output reg reg_w_en,
	output reg mux_jb_source,
	output reg mux_op1,
	output reg mux_op2,
	output reg mux_branch_prapare,
	output reg [3:0] dm_w_en,
	output reg mux_write_reg
);
	always@(*)begin
		im_w_en = 0;// unused
		reg_w_en = 0;
		mux_jb_source = 0;
		mux_op1 = 0;
		mux_op2 = 0;
		dm_w_en = 4'd0;
		mux_write_reg = 1;
		mux_branch_prapare = 0;

		case(opcode)
			//R-type 
			5'b01100:begin
				reg_w_en = 1'b1;
				mux_op1 = 1'b1;
				mux_op2 = 1'b0;
				dm_w_en = 4'd0;
				mux_write_reg = 1'b1;
				mux_branch_prapare = 0;
			end

			// I-type
			5'b00100:begin// computation instr.
				reg_w_en = 1'b1;
				mux_op1 = 1'b1;
				mux_op2 = 1'b1;
				dm_w_en = 4'd0;
				mux_write_reg = 1'b1;
				mux_branch_prapare = 0;
			end
			5'b11001:begin// jalr
				reg_w_en = 1'b1;
				mux_jb_source = 1'b1;
				mux_op1 = 1'b0;
				dm_w_en = 4'd0;
				mux_write_reg = 1'b1;
				mux_branch_prapare = 1;
			end
			5'b00000:begin// load instr.
				reg_w_en = 1'b1;
				mux_op1 = 1'b1;
				mux_op2 = 1'b1;
				dm_w_en = 4'd0;
				mux_write_reg = 1'b0;
				mux_branch_prapare = 0;
			end

			// S-type
			5'b01000:begin
				reg_w_en = 1'b0;
				mux_op1 = 1'b1;
				mux_op2 = 1'b1;
				case(func3)// sb,sh,sw
					3'b000:	dm_w_en = 4'b0001;
					3'b001: dm_w_en = 4'b0011;
					3'b010: dm_w_en = 4'b1111;
//					default: dm_w_en = 4'b0000;
				endcase
				mux_branch_prapare = 0;
			end

			// B-type
			5'b11000:begin
				reg_w_en = 1'b0;
				mux_jb_source = 1'b0; 
				mux_op1 = 1'b1;
				mux_op2 = 1'b0;
				dm_w_en = 4'd0;
				mux_branch_prapare = 1;
			end

			// U-type
			5'b01101:begin// lui
				reg_w_en = 1'b1;
				mux_op2 = 1'b1;
				dm_w_en = 4'd0;
				mux_write_reg = 1'b1;
				mux_branch_prapare = 0;
			end
			5'b00101:begin// auipc
				reg_w_en = 1'b1;
				mux_op1 = 1'b0;
				mux_op2 = 1'b1;
				dm_w_en = 4'd0;
				mux_write_reg = 1'b1;
				mux_branch_prapare = 0;
			end

			// J-type
			5'b11011:begin// jal
				reg_w_en = 1'b1;
				mux_jb_source = 1'b0;
				mux_op1 = 1'b0;
				dm_w_en = 4'd0;
				mux_write_reg = 1'b1;
				mux_branch_prapare = 1;
			end

		endcase
	end


endmodule



