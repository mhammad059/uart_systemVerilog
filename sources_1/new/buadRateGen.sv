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
    input logic [1:0] sel_baud, // 0:4800, 1:9600, 2:19200, 3:38400
    output logic bclk,
    output logic bclkx8    
    );
    
    logic bclkx8_4800, bclkx8_9600, bclkx8_19200, bclkx8_38400;
    
    // 4800 * 8
    clockDiv #(.DIV(SYS_CLK_FREQ/38400)) bclkx8_4800_gen(.inp_clk(sys_clk), .out_clk(bclkx8_4800));
    // 9600 * 8
    clockDiv #(.DIV(SYS_CLK_FREQ/76800)) bclkx8_9600_gen(.inp_clk(sys_clk), .out_clk(bclkx8_9600));
    // 19200 * 8
    clockDiv #(.DIV(SYS_CLK_FREQ/153600)) bclkx8_19200_gen(.inp_clk(sys_clk), .out_clk(bclkx8_19200));
    // 38400 * 8
    clockDiv #(.DIV(SYS_CLK_FREQ/307200)) bclkx8_38400_gen(.inp_clk(sys_clk), .out_clk(bclkx8_38400));
    
    always_comb begin
        case(sel_baud)
            2'b00: bclkx8 =  bclkx8_4800;
            2'b01: bclkx8 =  bclkx8_9600;
            2'b10: bclkx8 =  bclkx8_19200;
            2'b11: bclkx8 =  bclkx8_38400;
            default: bclkx8 = 0;
        endcase
    end
    
    
    // 0:4800, 1:9600, 2:19200, 3:38400
    clockDiv #(.DIV(8)) bclk_gen(.inp_clk(bclkx8), .out_clk(bclk));
    
    
endmodule
