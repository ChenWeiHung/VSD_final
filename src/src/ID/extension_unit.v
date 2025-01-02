module extension_unit(
	input [31:0] instr,
	output reg [31:0] ext_imm
);
	// In RV32I, opcode [1:0] alwaysd 2'b11.
	always@(*)begin
		case(instr[6:2])
			// I-type
			5'b00100,5'b11001,5'b00000: ext_imm = {{20{instr[31]}},instr[31:20]};

			// S-type
			5'b01000: ext_imm = {{20{instr[31]}},instr[31:25],instr[11:7]};

			// B-type
			5'b11000: ext_imm = {{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0};

			// U-type
			5'b01101,7'b00101: ext_imm = {instr[31:12],12'b0};

			// J-type
			5'b11011: ext_imm =  {{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0};

			// R-type or other don't care
			default: ext_imm = 32'd0;		
			
		endcase
	end



	
endmodule



