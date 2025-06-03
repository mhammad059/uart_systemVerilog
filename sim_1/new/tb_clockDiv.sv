`timescale 1ns / 1ps

module tb_clockDiv;

    logic inp_clk;
    logic out_clk;
    logic rst;

    clockDiv uut (
    .inp_clk(inp_clk),
    .rst(rst),
    .out_clk(out_clk)
    );

    always #5 inp_clk = ~inp_clk;

    initial begin
        inp_clk = 0;
        rst = 1;
        #10 rst = 0;
    end
    
endmodule
