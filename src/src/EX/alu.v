module alu(
	input [31:0] op1,
	input [31:0] op2,
	input [4:0] opcode,
	input [2:0] func3,
	input func7,
	output reg [31:0] compute_result,
	output reg compute_jb
);
	reg equal_signal, less_signal;

	always@(*)begin
		compute_result = 32'd0;
		compute_jb = 0;
		equal_signal = 0;
		less_signal = 0;
		case(opcode)
			//R-type 
			5'b01100:begin
				case(func3)
					3'b000:begin
						if(func7)	compute_result = op1 - op2; // sub
						else	    compute_result = op1 + op2; // add
					end

					3'b001:	compute_result = op1 <<op2[4:0]; // sll
					
					3'b101:begin
						if(func7)	compute_result = $signed(op1) >>>op2[4:0]; // sra
						else		compute_result = $signed(op1) >>op2[4:0]; // srl
					end

					3'b010:	compute_result = ($signed(op1) < $signed(op2))? 32'd1 : 32'd0; // slt

					3'b011: compute_result = (op1 < op2)? 32'd1 : 32'd0; // sltu

					3'b100:	compute_result = op1 ^ op2; // xor

					3'b110: compute_result = op1 | op2; // or

					3'b111: compute_result = op1 & op2; // and

				endcase
			end

			// I-type
			5'b00100:begin
				case(func3)
					3'b000:	compute_result = op1 + op2; // addi

					3'b001:	compute_result = op1 <<op2[4:0]; // slli	

					3'b101:begin
						if(func7)	compute_result = $signed(op1) >>>op2[4:0]; // srai
						else 		compute_result = $signed(op1) >>op2[4:0]; // srli
					end

					3'b010:	compute_result = ($signed(op1) < $signed(op2))? 32'd1 : 32'd0; // slti

					3'b011:	compute_result = (op1 < op2)? 32'd1 : 32'd0; // sltiu

					3'b100:	compute_result = op1 ^ op2; // xori

					3'b110:	compute_result = op1 | op2; // ori

					3'b111: compute_result = op1 & op2; // andi

				endcase
			end
			5'b11001:begin	// jalr
				compute_result = op1 + 32'd4;
				compute_jb = 1;
			end
			5'b00000: compute_result = op1 + op2; // load

			// S-type
			5'b01000: compute_result = op1 + op2; // store

			// B-type
			5'b11000:begin
				case(func3)
					3'b000,3'b001:begin	// beq,bne
						equal_signal = (op1 == op2)? 1'b1 : 1'b0;
						compute_jb = func3[0]^equal_signal;
					end	 

					3'b100,3'b101:begin // blt,bge
						less_signal = ($signed(op1) < $signed(op2))? 1'b1 : 1'b0; 
						compute_jb = func3[0]^less_signal;
					end	

					3'b110,3'b111:begin	// bltu,bgeu
						less_signal = (op1 < op2)? 1'b1 : 1'b0;
						compute_jb = func3[0]^less_signal;
					end

				endcase
			end

			// U-type
			5'b01101: compute_result = {op2[31:12],12'b0}; // lui

			5'b00101: compute_result = op1 + {op2[31:12],12'b0}; // auipc
				
			// J-type
			5'b11011:begin // jal
				compute_result = op1 + 32'd4;
				compute_jb = 1;
			end	

		endcase
	end

endmodule



