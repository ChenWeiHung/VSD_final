module forwarding_unit(
	input [4:0] ID_rs1,
	input [4:0] ID_rs2,
	input [4:0] EX_rs1,
	input [4:0] EX_rs2,
	input WB_regfile_en,
	input [4:0] WB_rd,
	input MEM_regfile_en,
	input [4:0] MEM_rd,
	input MEM_mux_w_reg,// if it is load instr, it will be 0. 
	input lock_forward_signal,
	input lock_forward_rs,
	output reg ID_ford_rs1_signal,
	output reg ID_ford_rs2_signal,
	output reg [1:0] EX_ford_rs1_signal,
	output reg [1:0] EX_ford_rs2_signal,
	output reg load_use_stall_flush,
	output reg load_use_wb_lock_signal,
	output reg load_use_rs_lock_num
);
	always@(*)begin
		ID_ford_rs1_signal = 0;
		ID_ford_rs2_signal = 0;
		EX_ford_rs1_signal =2'd0;
		EX_ford_rs2_signal = 2'd0;
		load_use_stall_flush = 0;
		load_use_wb_lock_signal = 0;
		load_use_rs_lock_num = 0;

		if(WB_regfile_en && (ID_rs1 == WB_rd) && (ID_rs1 != 5'd0))	ID_ford_rs1_signal = 1;	// 3 cycle data hazard
		if(WB_regfile_en && (ID_rs2 == WB_rd) && (ID_rs2 != 5'd0))	ID_ford_rs2_signal = 1; // 3 cycle data hazard


		if(MEM_regfile_en && (EX_rs1 == MEM_rd) && (EX_rs1 != 5'd0)) EX_ford_rs1_signal = 2'd2; // 1 cycle data hazard
		else if(WB_regfile_en && (EX_rs1 == WB_rd) && (EX_rs1 != 5'd0)) EX_ford_rs1_signal = 2'd1;  // 2 cycle data hazard

		if(MEM_regfile_en && (EX_rs2 == MEM_rd) && (EX_rs2 != 5'd0)) EX_ford_rs2_signal = 2'd2; // 1 cycle data hazard
		else if(WB_regfile_en && (EX_rs2 == WB_rd) && (EX_rs2 != 5'd0)) EX_ford_rs2_signal = 2'd1;  // 2 cycle data hazard

		// if 1 cycle data hazard is load-use case, need stall one cycle.
		if((MEM_mux_w_reg == 0)&&((EX_ford_rs1_signal == 2'd2)||(EX_ford_rs2_signal == 2'd2)))begin
			load_use_stall_flush = 1;
			//	another special case for 1 cycle load-use data hazard
			if((EX_ford_rs1_signal==2'd2)&&(EX_ford_rs2_signal==2'd1))begin
				load_use_wb_lock_signal = 1;
				load_use_rs_lock_num = 1;
			end else if((EX_ford_rs1_signal==2'd1)&&(EX_ford_rs2_signal==2'd2))begin
				load_use_wb_lock_signal = 1;
				load_use_rs_lock_num = 0;
			end 
		end

		if(lock_forward_signal)begin
			case(lock_forward_rs)
				0:	EX_ford_rs1_signal = 2'd3;
				1:	EX_ford_rs2_signal = 2'd3;
			endcase
		end


	end
		
endmodule



