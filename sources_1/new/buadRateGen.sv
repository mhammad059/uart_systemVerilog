`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2025 10:54:47 AM
// Design Name: 
// Module Name: buadRateGen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module buadRateGen #(parameter SYS_CLK_FREQ = 100000000)( 
    input logic sys_clk,
    input logic rst,
    input logic [1:0] sel_baud, // 0:4800, 1:9600, 2:19200, 3:38400
    output logic bclk,
    output logic bclkx8    
    );
    
    logic bclkx8_4800, bclkx8_9600, bclkx8_19200, bclkx8_38400;

    // logic [$clog2(SYS_CLK_FREQ/4800)-1:0] count;

    // always_ff @ (posedge sys_clk or posedge rst) begin
    //     if (rst) count <= 0;
    //     else begin
    //         if(count == bclkx8) count <= 0;
    //         else count <= count + 1;
    //     end
    // end

    // 4800 * 8
    clockDiv #(.DIV(SYS_CLK_FREQ/38400)) bclkx8_4800_gen(.inp_clk(sys_clk), .rst(rst), .out_clk(bclkx8_4800));
    // 9600 * 8
    clockDiv #(.DIV(SYS_CLK_FREQ/76800)) bclkx8_9600_gen(.inp_clk(sys_clk), .rst(rst), .out_clk(bclkx8_9600));
    // 19200 * 8
    clockDiv #(.DIV(SYS_CLK_FREQ/153600)) bclkx8_19200_gen(.inp_clk(sys_clk), .rst(rst), .out_clk(bclkx8_19200));
    // 38400 * 8
    clockDiv #(.DIV(SYS_CLK_FREQ/307200)) bclkx8_38400_gen(.inp_clk(sys_clk), .rst(rst), .out_clk(bclkx8_38400));

    // 4800
    clockDiv #(.DIV(SYS_CLK_FREQ/4800)) bclk_4800_gen(.inp_clk(sys_clk), .rst(rst), .out_clk(bclk_4800));
    // 9600
    clockDiv #(.DIV(SYS_CLK_FREQ/9600)) bclk_9600_gen(.inp_clk(sys_clk), .rst(rst), .out_clk(bclk_9600));
    // 19200
    clockDiv #(.DIV(SYS_CLK_FREQ/19200)) bclk_19200_gen(.inp_clk(sys_clk), .rst(rst), .out_clk(bclk_19200));
    // 38400
    clockDiv #(.DIV(SYS_CLK_FREQ/38400)) bclk_38400_gen(.inp_clk(sys_clk), .rst(rst), .out_clk(bclk_38400));

    
    always_comb begin
        case(sel_baud)
            2'b00: begin
                bclkx8 =  bclkx8_4800;
                bclk =  bclk_4800;
            end
            2'b01: begin
                bclkx8 =  bclkx8_9600;
                bclk =  bclk_9600;
            end
            2'b10: begin
                bclkx8 =  bclkx8_19200;
                bclk =  bclk_19200;
            end 
            2'b11: begin
                bclkx8 =  bclkx8_38400;
                bclk =  bclk_38400;
            end 
            default: begin
                bclkx8 = 0;
                bclk = 0;
            end
        endcase
    end
    
endmodule
