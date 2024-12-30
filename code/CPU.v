`include "./src/IF/program_counter.v"
`include "./src/ID/IF_reg_ID.v"
`include "./src/ID/decoder.v"
`include "./src/ID/controller.v"
`include "./src/ID/RegFile.v"
`include "./src/ID/extension_unit.v"
`include "./src/ID/ford_mux_2to1.v"
`include "./src/EX/ID_reg_EX.v"
`include "./src/EX/ford_mux_4to1.v"
`include "./src/EX/mux_2to1.v"
`include "./src/EX/jb_unit.v"
`include "./src/EX/alu.v"
`include "./src/MEM/EX_reg_MEM.v"
`include "./src/WB/MEM_reg_WB.v"
`include "./src/WB/load_filter.v"
`include "./src/forwarding/forwarding_unit.v"
// `include "./src/SRAM.v"

module CPU(
	input clk,
	input rst,
	input [31:0] im_read_data,
	input [31:0] dm_read_data,
	output [15:0] im_address,
	output [3:0] dm_w_en,
	output [15:0] dm_address,
	output [31:0] dm_write_data
);

/* 
	5 Pipeline stage: 
		IF (Instruction Fetch)
		ID (Instruction Decode)
		EX (Execution)
		MEM (Memory)
		WB (Write Back)	
*/

	// IF
	wire [31:0] if_pc;					// program_counter output
	wire [31:0] if_instr;				// instr memory output 
	wire [31:0] if_pc_plus_4;			// pc + 4

	// ID
	wire [31:0] id_pc;			// IF to ID
	wire [31:0] id_instr;		// IF to ID
	wire [4:0] id_opcode;				// decoder - opcode 5 bit           
	wire [2:0] id_func3;				// decoder - func3 3bit
	wire id_func7;						// decoder - func7 1bit
	wire [4:0] id_rs1_index;			// decoder - rs1 number
	wire [4:0] id_rs2_index;			// decoder - rs2 number
	wire [4:0] id_rd_index;				// decoder - rd number
	wire id_regfile_en;					// controller signal - regfile write enable
	wire id_mux_rd_sel;					// controller signal - mux select signal for rd writeback source 
	wire [3:0] id_dm_en; 				// controller signal - data memory write enable
	wire id_jb_base_sel;            	// controller signal - mux select signal for jb computing base source 
	wire id_op1_source_sel;				// controller signal - mux select signal for op1 input source 
	wire id_op2_source_sel;   			// controller signal - mux select signal for op2 input source 
	wire id_branch_prapare;         	// controller signal - prepare for mux_next_addr's select signal
	wire [31:0] id_rs1_data;			// RegFile output - rs1 word data
	wire [31:0] id_rs2_data;			// RegFile output - rs2 word data
	wire [31:0] id_ext_imm;		    	// extension_unit output 
	wire [31:0] id_forward_rs1_result;  // ID stage forwarding rs1 data(WB)
	wire [31:0] id_forward_rs2_result;  // ID stage forwarding rs2 data(WB)

	// EX
	wire [31:0] ex_pc;		    // ID to EX
	wire [4:0] ex_opcode;		// ID to EX
	wire [2:0] ex_func3;		// ID to EX
	wire ex_func7;				// ID to EX		
	wire [4:0] ex_rs1_index;	// ID to EX
	wire [4:0] ex_rs2_index;	// ID to EX
	wire [4:0] ex_rd_index;		// ID to EX	
	wire ex_regfile_en;			// ID to EX
	wire ex_mux_rd_sel;			// ID to EX
	wire [3:0] ex_dm_en;        // ID to EX
	wire ex_jb_base_sel;        // ID to EX
	wire ex_op1_source_sel;		// ID to EX
	wire ex_op2_source_sel;   	// ID to EX	
	wire ex_branch_prapare;     // ID to EX 
	wire [31:0] ex_rs1_data;	// ID to EX
	wire [31:0] ex_rs2_data;	// ID to EX		
	wire [31:0] ex_ext_imm;		// ID to EX
	wire [31:0] ex_forward_rs1_result;	// EX stage forwarding rs1 data(ID,WB,MEM,lock_MEM)
	wire [31:0] ex_forward_rs2_result;	// EX stage forwarding rs2 data(ID,WB,MEM,lock_MEM)
	wire [31:0] ex_mux_to_jb;			// jump_branch input base source  
	wire [31:0] ex_mux_to_op1;			// alu input 1
	wire [31:0] ex_mux_to_op2;			// alu input 2
	wire [31:0] ex_jump_addr;			// jump_branch output address  
	wire [31:0] ex_alu_result;			// alu output - compute result
	wire ex_alu_jb_signal;				// alu output - compute jb
	wire ex_next_pc_sel;				// mux select signal for next pc
	wire [31:0] ex_mux_to_pc;			// next pc address

	// MEM
	wire mem_regfile_en;		// EX to MEM
	wire mem_mux_rd_sel;		// EX to MEM
	wire [3:0] mem_dm_en;		// EX to MEM
	wire [2:0] mem_func3;		// EX to MEM
	wire [4:0] mem_rd_index;	// EX to MEM
	wire [31:0] mem_alu_result;	// EX to MEM
	wire [31:0] mem_write_data_from_rs2;// dm write data(EX to MEM)
	wire [31:0] mem_dm_data;			// data memory output
	
	// WB
	wire wb_regfile_en;			// MEM to WB
	wire wb_mux_rd_sel;			// MEM to WB
	wire [2:0] wb_func3;		// MEM to WB
	wire [4:0] wb_rd_index;		// MEM to WB
	wire [31:0] wb_dm_data;		// MEM to WB
	wire [31:0] wb_alu_result;	// MEM to WB
	wire [31:0] wb_filter_out;			// load_filter output
	wire [31:0] wb_mux_to_rd;			// RegFile write data 
	wire [31:0] wb_lock_data;			// lock forwarding data in special load-use case
	wire lock_ford_signal;				// lock ford rs number to ex stage forwarding mux(0:rs1 ,1:rs2)
	wire lock_ford_rs;					// lock ford rs number to ex stage forwarding mux(0:rs1 ,1:rs2)

	/* forwarding_unit output */
	wire forward_stall_flush;			// for load-use data hazard
	wire forward_rs1_mux_id_sel;		// ford ID rs1 mux 2to1 select signal
	wire forward_rs2_mux_id_sel;		// ford ID rs2 mux 2to1 select signal
	wire [1:0] forward_rs1_mux_ex_sel;	// ford EX rs1 mux 4to1 select signal
	wire [1:0] forward_rs2_mux_ex_sel;	// ford EX rs2 mux 4to1 select signal
	wire forward_load_use_lock;			// need lock rs number to MEM_stage_WB(0:rs1 ,1:rs2)
	wire forward_require_lock_rs;		// need lock rs number to MEM_stage_WB(0:rs1 ,1:rs2)

// =============================  IF  ===================================
	assign if_pc_plus_4 = if_pc + 32'd4;
	
	mux_2to1 mux_next_addr(
		.datain_0(if_pc_plus_4),
		.datain_1(ex_jump_addr),
		.sel(ex_next_pc_sel),
		.dataout(ex_mux_to_pc)
	);	
	
	program_counter u_pc(
		.clk(clk),
		.rst(rst),
		.stall(forward_stall_flush),
		.next_pc(ex_mux_to_pc),
		
		.curr_pc(if_pc)
	);

	// SRAM im(
	// 	.clk(clk), 
	// 	.w_en(), 
	// 	.address(pc_out[15:0]), 
	// 	.write_data(), 
	// 	.read_data(im_instr) 
	// );
	assign im_address = if_pc[15:0];	// CPU output
	assign if_instr = im_read_data;		// CPU input

// =============================  ID  =============================
	IF_reg_ID u_if_id_stage(
		.clk(clk),
		.rst(rst),
		.stall(forward_stall_flush),
		.if_pc(if_pc),
		.if_instr(if_instr),

		.id_pc(id_pc),
		.id_instr(id_instr)
	);

	decoder u_decoder(	
		.instruction(id_instr),
		.opcode_5bit(id_opcode),
		.func3(id_func3),
		.func7_1bit(id_func7),
		.rs1_index(id_rs1_index),
		.rs2_index(id_rs2_index),
		.rd_index(id_rd_index)
	);

	controller u_controller(
		.opcode(id_opcode),
		.func3(id_func3),
		.func7(id_func7),
		.im_w_en(),	//
		.reg_w_en(id_regfile_en),	
		.mux_jb_source(id_jb_base_sel),
		.mux_op1(id_op1_source_sel),
		.mux_op2(id_op2_source_sel),
		.mux_branch_prapare(id_branch_prapare),
		.dm_w_en(id_dm_en),
		.mux_write_reg(id_mux_rd_sel)
	);
	
	RegFile regfile(
		.clk(clk),
	    .rd_en(wb_regfile_en),
		.rs1(id_rs1_index),
		.rs2(id_rs2_index),
		.rd(wb_rd_index),
		.rd_datain(wb_mux_to_rd),
		.rs1_dataout(id_rs1_data),
		.rs2_dataout(id_rs2_data)
	);

	extension_unit u_ext(
		.instr(id_instr),
		.ext_imm(id_ext_imm)
	);


	ford_mux_2to1 ford_id_rs1(
		.datain_0(id_rs1_data),
		.datain_1(wb_mux_to_rd),
		.sel(forward_rs1_mux_id_sel),
		.dataout(id_forward_rs1_result)
	);

	ford_mux_2to1 ford_id_rs2(
		.datain_0(id_rs2_data),
		.datain_1(wb_mux_to_rd),
		.sel(forward_rs2_mux_id_sel),
		.dataout(id_forward_rs2_result)
	);

// =============================  EX  =============================
	ID_reg_EX u_id_ex_stage(
		.clk(clk),
		.rst(rst),
		.stall(forward_stall_flush),
		.flush(ex_next_pc_sel),
		.ID_controller_mux_jb(id_jb_base_sel),
		.ID_controller_mux_op1(id_op1_source_sel),
		.ID_controller_mux_op2(id_op2_source_sel),
		.ID_controller_jb_prepare(id_branch_prapare),
		.ID_controller_dm_en(id_dm_en),
		.ID_controller_mux_rd(id_mux_rd_sel),
		.ID_controller_regfile_en(id_regfile_en),
		.ID_pc(id_pc),
		.ID_decoder_opcode(id_opcode),
		.ID_decoder_func3(id_func3),
		.ID_decoder_func7(id_func7),
		.ID_decoder_rs1_index(id_rs1_index),
		.ID_decoder_rs2_index(id_rs2_index),
		.ID_decoder_rd_index(id_rd_index),
		.ID_rs1_data(id_forward_rs1_result),
		.ID_rs2_data(id_forward_rs2_result),
		.ID_extension_imm(id_ext_imm),

		.EX_controller_mux_jb(ex_jb_base_sel),
		.EX_controller_mux_op1(ex_op1_source_sel),
		.EX_controller_mux_op2(ex_op2_source_sel),
		.EX_controller_jb_prepare(ex_branch_prapare),
		.EX_controller_dm_en(ex_dm_en),
		.EX_controller_mux_rd(ex_mux_rd_sel),
		.EX_controller_regfile_en(ex_regfile_en),
		.EX_pc(ex_pc),
		.EX_decoder_opcode(ex_opcode),
		.EX_decoder_func3(ex_func3),
		.EX_decoder_func7(ex_func7),
		.EX_decoder_rs1_index(ex_rs1_index),
		.EX_decoder_rs2_index(ex_rs2_index),
		.EX_decoder_rd_index(ex_rd_index),
		.EX_rs1_data(ex_rs1_data),
		.EX_rs2_data(ex_rs2_data),
		.EX_extension_imm(ex_ext_imm) 
	);

	ford_mux_4to1 ford_ex_rs1(
		.datain_0(ex_rs1_data),
		.datain_1(wb_mux_to_rd),
		.datain_2(mem_alu_result),
		.datain_3(wb_lock_data),
		.sel(forward_rs1_mux_ex_sel),
		.dataout(ex_forward_rs1_result)
	);
	
	ford_mux_4to1 ford_ex_rs2(
		.datain_0(ex_rs2_data),
		.datain_1(wb_mux_to_rd),
		.datain_2(mem_alu_result),
		.datain_3(wb_lock_data),
		.sel(forward_rs2_mux_ex_sel),
		.dataout(ex_forward_rs2_result)
	);

	mux_2to1 mux_jump_source(
		.datain_0(ex_pc),
		.datain_1(ex_forward_rs1_result),
		.sel(ex_jb_base_sel),
		.dataout(ex_mux_to_jb)
	);
	mux_2to1 mux_pc_rs1(
		.datain_0(ex_pc),
		.datain_1(ex_forward_rs1_result),
		.sel(ex_op1_source_sel),
		.dataout(ex_mux_to_op1)
	);
	mux_2to1 mux_rs2_imm(
		.datain_0(ex_forward_rs2_result),
		.datain_1(ex_ext_imm),
		.sel(ex_op2_source_sel),
		.dataout(ex_mux_to_op2)
	);

	jb_unit u_jb(
		.op1(ex_mux_to_jb),
		.op2(ex_ext_imm),
		.jb_out(ex_jump_addr)
	);

	alu u_alu(
		.op1(ex_mux_to_op1),
		.op2(ex_mux_to_op2),
		.opcode(ex_opcode),
		.func3(ex_func3),
		.func7(ex_func7),
		.compute_result(ex_alu_result),
		.compute_jb(ex_alu_jb_signal)
	);

	and and_jb_sel(ex_next_pc_sel,ex_branch_prapare,ex_alu_jb_signal);

// ============================  MEM  ============================
	EX_reg_MEM u_ex_mem_stage(
		.clk(clk),
		.rst(rst),
		.flush(forward_stall_flush),
		.EX_controller_dm_en(ex_dm_en),
		.EX_controller_mux_rd(ex_mux_rd_sel),
		.EX_controller_regfile_en(ex_regfile_en),
		.EX_docoder_func3(ex_func3),
		.EX_decoder_rd_index(ex_rd_index),
		.EX_alu_result(ex_alu_result),
		.EX_write_data(ex_forward_rs2_result),

		.MEM_controller_dm_en(mem_dm_en),
		.MEM_controller_mux_rd(mem_mux_rd_sel),
		.MEM_controller_regfile_en(mem_regfile_en),
		.MEM_docoder_func3(mem_func3),
		.MEM_decoder_rd_index(mem_rd_index),
		.MEM_alu_result(mem_alu_result),
		.MEM_write_data(mem_write_data_from_rs2)
	); 

	// SRAM dm(
	// 	.clk(clk), 
	// 	.w_en(w_datamem_en), 
	// 	.address(alu_result[15:0]), 
	// 	.write_data(rs2_data), 
	// 	.read_data(dm_data) 
	// );

	assign dm_w_en = mem_dm_en;			            // CPU output
	assign dm_address = mem_alu_result[15:0];	    // CPU output
	assign dm_write_data = mem_write_data_from_rs2;	// CPU output
	assign mem_dm_data = dm_read_data;			    // CPU input

// =============================  WB  =============================
	MEM_reg_WB u_mem_wb_stage(
		.clk(clk),
		.rst(rst),
		.MEM_controller_mux_rd(mem_mux_rd_sel),
		.MEM_controller_regfile_en(mem_regfile_en),
		.MEM_docoder_func3(mem_func3),
		.MEM_decoder_rd_index(mem_rd_index),
		.MEM_dm_dataout(mem_dm_data),
		.MEM_alu_result(mem_alu_result),
		.fd_unit_lock_signal(forward_load_use_lock),
		.fd_unit_need_lock_num(forward_require_lock_rs),
		.forward_data_from_wb_mux(wb_mux_to_rd),

		.WB_controller_mux_rd(wb_mux_rd_sel),
		.WB_controller_regfile_en(wb_regfile_en),
		.WB_docoder_func3(wb_func3),
		.WB_decoder_rd_index(wb_rd_index),
		.WB_dm_dataout(wb_dm_data),
		.WB_alu_result(wb_alu_result),
		.lock_data(wb_lock_data),
		.lock_ford_signal(lock_ford_signal),
		.lock_ford_rs(lock_ford_rs)
	);	

	load_filter u_ld(
		.load_data(wb_dm_data),
		.func3(wb_func3),
		.filter_data(wb_filter_out)
	);
	
	mux_2to1 mux_ld_alu(
		.datain_0(wb_filter_out),
		.datain_1(wb_alu_result),
		.sel(wb_mux_rd_sel),
		.dataout(wb_mux_to_rd)
	);

// =========================  fordwarding  =====================================
	forwarding_unit u_forward(
		.ID_rs1(id_rs1_index),
		.ID_rs2(id_rs2_index),
		.EX_rs1(ex_rs1_index),
		.EX_rs2(ex_rs2_index),
		.WB_regfile_en(wb_regfile_en),
		.WB_rd(wb_rd_index),
		.MEM_regfile_en(mem_regfile_en),
		.MEM_rd(mem_rd_index),
		.MEM_mux_w_reg(mem_mux_rd_sel), 
		.lock_forward_signal(lock_ford_signal),
	 	.lock_forward_rs(lock_ford_rs),

		.ID_ford_rs1_signal(forward_rs1_mux_id_sel),
		.ID_ford_rs2_signal(forward_rs2_mux_id_sel),
		.EX_ford_rs1_signal(forward_rs1_mux_ex_sel),
		.EX_ford_rs2_signal(forward_rs2_mux_ex_sel),
		.load_use_stall_flush(forward_stall_flush),
		.load_use_wb_lock_signal(forward_load_use_lock),
		.load_use_rs_lock_num(forward_require_lock_rs)
	);

endmodule