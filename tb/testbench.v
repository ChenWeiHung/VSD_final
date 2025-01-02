`timescale 1ns/10ps

`include "SRAM.v"
`ifdef syn
  `include "CPU_syn.v"
  `include "tsmc18.v"
`else
  `include "Top.v"
`endif

`define CYCLE 40.0    // Cycle time
`define MAX 100000    // Max cycle number
`define prog_path "sisc.prog"
`define gold_path "golden.hex"


`define mem_word(addr) \
  {dm.mem[addr]}



`define ANSWER_START 16'h9000



module testbench();

  reg clk;
  reg rst;
  wire [31:0] im_read, dm_read;
  wire [15:0] im_addr_line,dm_addr_line;
  wire dm_w_en;
  wire [31:0] dm_write_data;

  reg [31:0] GOLDEN [0:64];
  integer gf;               // pointer of golden file
  integer num;              // total golden data
  integer err;              // total number of errors compared to golden data
  integer i;

  Top u_cpu (
    .clk(clk),
    .rst(rst),
    .im_read_data(im_read),
	  .dm_read_data(dm_read),
	   //im_w_en,
	  .im_address(im_addr_line),
	   //im_write_data,
	  .dm_w_en(dm_w_en),
	  .dm_address(dm_addr_line),
	  .dm_write_data(dm_write_data)
  );

  SRAM im(
		.clk(clk),
		.w_en(),        //
		.address(im_addr_line),
		.write_data(),	//
		.read_data(im_read)
	);
  
	SRAM dm(
		.clk(clk),
		.w_en(dm_w_en),
		.address(dm_addr_line),
		.write_data(dm_write_data),
		.read_data(dm_read)
	);
  
  `ifdef syn
    initial $sdf_annotate("CPU_syn.sdf", u_cpu);
  `endif

  always #(`CYCLE/2) clk = ~clk;

  initial
  begin
    // Load program and preset data to im & dm 
    $readmemh(`prog_path, im.mem);
    $readmemh(`prog_path, dm.mem);


    // Load expect dm value
    num = 0;
    err = 0;
    gf = $fopen(`gold_path, "r");
    while(!$feof(gf))
    begin
      $fscanf(gf, "%h\n", GOLDEN[num]);
      num = num + 1;
    end
    $fclose(gf);


    // Check memory before execute test program
    $display("---------- before running sisc.prog ----------");
    $display("\nData Memory['h9000] ~ ['h90bc]:");
    for (i = 0; i < num; i = i + 1) $display("DM['h%4h] = %h", `ANSWER_START + i*4, `mem_word(`ANSWER_START + i*4));
    

    // execute sisc.prog
    $display("\n>>>Start running test program...");
    clk = 0;
    rst = 1;
    #`CYCLE rst = 0;

    wait(dm.mem[16'hfffc] == 8'hff);
    $display(">>>Done\n");


    // Check the execution result of RegFile & memory
    $display("---------- after running sisc.prog ----------");
    $display("\nData Memory['h9000] ~ ['h90bc]:");
    for (i = 0; i < num; i = i + 1)
    begin
      if(`ANSWER_START + i*4 =='h9000)      $display("\n< addi/slti/sltiu/andi/ori/xori/slli/srli/srai/lui/auipc >");
      else if(`ANSWER_START + i*4 =='h9040) $display("\n< add/sub/slt/sltu/and/or/xor/sll/srl/sra >");
      else if(`ANSWER_START + i*4 =='h9068) $display("\n< sw/sh/sb/lw/lh/lhu/lb/lbu >");
      else if(`ANSWER_START + i*4 =='h908c) $display("\n< beq/bne/blt/bltu/bge/bgeu/jal/jalr >");

      if (`mem_word(`ANSWER_START + i*4) !== GOLDEN[i])
      begin
        $display("DM['h%4h] = %h, expect = %h", `ANSWER_START + i*4, `mem_word(`ANSWER_START + i*4), GOLDEN[i]);
        err = err + 1;
      end
      else
        $display("DM['h%4h] = %h     =>ok !", `ANSWER_START + i*4, `mem_word(`ANSWER_START + i*4));
    end


    // Print result
    result(err);
    $finish;
  end

  task result;
    input integer err;
    begin
      if (err === 0)
      begin
        $display("============================================================================");
        $display("\n \\(^o^)/ CONGRATULATIONS!!  The simulation result is PASS!!!\n");
        $display("============================================================================");
      end
      else
      begin
        $display("============================================================================");
        $display("\n  (T_T) The simulation result is FAIL!! Totally has %d errors", err);
        $display("============================================================================");
      end
    end
  endtask
  
  // If CPU cannot finish test program normally
  initial
  begin
    #(`CYCLE*`MAX)
    $finish;  
  end

  initial 
  begin
    $dumpfile("filename.fsdb");
    $dumpvars;
  end

endmodule
