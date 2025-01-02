`include "defines.v"
`include "Sram.v"

module Instruction_Memory(
    input         clk,
    input  [31:0] pc,
    output [31:0] instruction
);
    Sram sram(
        .clk(clk),
        .MemRead(1'b1),
        .MemWrite(4'b0),
        .address(pc),
        .write_data(32'bz),
        .read_data(instruction)
    );

endmodule
