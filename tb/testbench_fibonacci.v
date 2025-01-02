`timescale 1ns/1ps
`include "Chip.v"
`include "Instruction_Memory.v"
`include "Data_Memory.v"

module CPU_Testbench;

    reg clk;
    reg rst;
    wire [15:0] rd_data;
    wire [15:0] pc;
    wire [31:0] instruction;
    wire [31:0] Mem_out;
    wire [3:0] MemWrite;
    wire MemRead;
    wire [31:0] Read_data_2;

    integer i;

    localparam ARRAY_OFFSET = 32'd4188;

    // Instantiate the DUT (Top Module)
    Chip dut (
        .clk(clk),
        .rst(rst),
        .im_read_data(instruction),
        .dm_read_data(Mem_out),
        .im_address(pc),
        .dm_w_en(MemWrite),
        .dm_address(rd_data),
        .dm_write_data(Read_data_2)
    );


    Data_Memory data_memory(
        .clk(clk), 
        .address({{16{1'b0}},rd_data}), 
        .write_data(Read_data_2), 
        .read_data(Mem_out),
        .MemRead(1'b1), 
        .MemWrite(MemWrite)
    );

    Instruction_Memory instruction_memory(
        .clk(clk), 
        .pc({{16{1'b0}},pc}), 
        .instruction(instruction)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    function int get_memory(input int index);
        if (index < 0 || index > 65535) begin
            return -1; // 錯誤處理
        end
        return {data_memory.sram.mem[index + 3], data_memory.sram.mem[index + 2], 
                data_memory.sram.mem[index + 1], data_memory.sram.mem[index]};
    endfunction



    initial begin
        $readmemh("fibonacci.hex", instruction_memory.sram.mem);
        $readmemh("fibonacci.hex", data_memory.sram.mem);

        rst = 1;
        #20 rst = 0;

        // 等待排序完成
        repeat (100000) @(posedge clk);

        // 顯示排序後的數據
        $display("fibonacci results:");
        for (int i = 0; i < 20; i++) begin
            $display("Index %0d: %0d", i+1, get_memory(ARRAY_OFFSET + i * 4)); // 將位址按字節對齊
        end
        $writememh("result.hex", data_memory.sram.mem);
        #50 $finish;
    end

        initial begin
            $fsdbDumpfile("CPU_Testbench.fsdb");
            $fsdbDumpvars(0, CPU_Testbench);
        end

/*        initial begin 
            $sdf_annotate("CPU.sdf", dut);
        end
*/
endmodule
