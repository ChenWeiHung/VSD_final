`include "Top.v"
`include "/home/summer/cell_library/SAED/14/io/lib/io_std/verilog/include/common.v"
`include "/home/summer/cell_library/SAED/14/io/lib/io_std/verilog/saed14nm_stdio_fc.v"

module Chip (
    input clk,
    input rst,
    input [31:0] im_read_data,
    input [31:0] dm_read_data,
    output [15:0] im_address,
    output [3:0] dm_w_en,
    output [15:0] dm_address,
    output [31:0] dm_write_data
);

    // 定義內部信號
    wire clk_buf, rst_buf;
    wire [31:0] im_read_data_buf, dm_read_data_buf;
    wire [15:0] im_address_buf, dm_address_buf;
    wire [3:0] dm_w_en_buf;
    wire [31:0] dm_write_data_buf;

    // CPU 核心实例化
    Top cpu_inst (
        .clk(clk_buf),
        .rst(rst_buf),
        .im_read_data(im_read_data_buf),
        .dm_read_data(dm_read_data_buf),
        .im_address(im_address_buf),
        .dm_w_en(dm_w_en_buf),
        .dm_address(dm_address_buf),
        .dm_write_data(dm_write_data_buf)
    );

    // Input Pads
    I1025_NS clk_pad (.DOUT(clk_buf), .PADIO(clk), .R_EN(1'b1));
    I1025_NS rst_pad (.DOUT(rst_buf), .PADIO(rst), .R_EN(1'b1));

    // Data Input Pads
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : im_read_data_pads
            B16I1025_NS im_read_data_pad (
                .DOUT(im_read_data_buf[i]), 
                .PADIO(im_read_data[i]), 
                .DIN(1'b0), 
                .EN(1'b0), 
                .R_EN(1'b1), 
                .PULL_UP(1'b0), 
                .PULL_DOWN(1'b0)
            );
        end

        for (i = 0; i < 32; i = i + 1) begin : dm_read_data_pads
            B16I1025_EW dm_read_data_pad (
                .DOUT(dm_read_data_buf[i]), 
                .PADIO(dm_read_data[i]), 
                .DIN(1'b0), 
                .EN(1'b0), 
                .R_EN(1'b1), 
                .PULL_UP(1'b0), 
                .PULL_DOWN(1'b0)
            );
        end
    endgenerate

    // Output Pads
    generate
        for (i = 0; i < 16; i = i + 1) begin : im_address_pads
            B8I1025_NS im_address_pad (
                .DIN(im_address_buf[i]),
                .DOUT(), 
                .PADIO(im_address[i]), 
                .EN(1'b1), 
                .R_EN(1'b0), 
                .PULL_UP(1'b0), 
                .PULL_DOWN(1'b0)
            );
        end

        for (i = 0; i < 16; i = i + 1) begin : dm_address_pads
            B8I1025_EW dm_address_pad (
                .DIN(dm_address_buf[i]), 
                .DOUT(),
                .PADIO(dm_address[i]), 
                .EN(1'b1), 
                .R_EN(1'b0), 
                .PULL_UP(1'b0), 
                .PULL_DOWN(1'b0)
            );
        end

        for (i = 0; i < 4; i = i + 1) begin : dm_w_en_pads
            B8I1025_NS dm_w_en_pad (
                .DIN(dm_w_en_buf[i]), 
                .DOUT(),
                .PADIO(dm_w_en[i]), 
                .EN(1'b1), 
                .R_EN(1'b0), 
                .PULL_UP(1'b0), 
                .PULL_DOWN(1'b0)
            );
        end

        for (i = 0; i < 32; i = i + 1) begin : dm_write_data_pads
            B8I1025_EW dm_write_data_pad (
                .DIN(dm_write_data_buf[i]), 
                .DOUT(),
                .PADIO(dm_write_data[i]), 
                .EN(1'b1), 
                .R_EN(1'b0), 
                .PULL_UP(1'b0), 
                .PULL_DOWN(1'b0)
            );
        end
    endgenerate

endmodule
