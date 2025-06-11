`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2025 11:33:14 AM
// Design Name: 
// Module Name: tb_baudRateGen
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


module tb_buadRateGen;

    // Testbench signals
    reg rst;
    reg sys_clk;
    reg [1:0] sel_baud;
    wire bclk, bclkx8;
    
    // Instantiate the DUT (Device Under Test)
    buadRateGen dut (
        .sys_clk(sys_clk),
        .sel_baud(sel_baud),
        .bclk(bclk),
        .bclkx8(bclkx8),
        .rst(rst)
    );

    // Generate a 100 MHz system clock (10 ns period)
    always #5 sys_clk = ~sys_clk;

    // Test procedure
    initial begin
        // Initialize signals

        rst = 1; #5
        rst = 0;

        sys_clk = 0;
        sel_baud = 2'b00;  // Start with 4800 baud

        #10000000; 
        sel_baud = 2'b01;  // Start with 4800 baud

        #10000000; 
        sel_baud = 2'b10;  // Start with 4800 baud

        #10000000; 
        sel_baud = 2'b11;  // Start with 4800 baud

        #10000000; 
        
        // End simulation
        $stop;
    end

    // Monitor output
    initial begin
        $monitor("Time=%0t | sel_baud=%b | bclkx8=%b | bclk=%b", 
                  $time, sel_baud, bclkx8, bclk);
    end

endmodule

