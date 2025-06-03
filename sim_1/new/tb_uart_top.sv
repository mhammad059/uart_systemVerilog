`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 12:50:55 PM
// Design Name: 
// Module Name: tb_uart_top
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


module tb_uart_top;

    // Testbench Signals
    reg rst;
    reg sys_clk;
    
    reg tx_en;
    reg [1:0] sel_baud;
    reg [7:0] tx_d_in;
    
    wire tx_data;
    reg rx_data; 

    assign rx_data = tx_data;
    
    wire [7:0] rx_d_out;
    
    wire rx_status;
    wire tx_status;
    

    // Instantiate the UART Top Module
    uart_top uut (
        .rst(rst),
        .sys_clk(sys_clk),
        .tx_en(tx_en),
        .sel_baud(sel_baud),
        .tx_d_in(tx_d_in),
        .rx_data(rx_data),
        .tx_data(tx_data),
        .rx_d_out(rx_d_out),
        .rx_status(rx_status),
        .tx_status(tx_status)
    );

    // Generate System Clock (100 MHz -> 10ns period)
    initial begin
        sys_clk = 0;
        forever #5 sys_clk = ~sys_clk;
    end

    // Simulating transmission and reception
    initial begin
        // Initialize
        rst = 1;
        tx_en = 0;
        sel_baud = 2'b01;  // 9600 baud
        tx_d_in = 8'b00000000;

        // Reset
        #50;
        rst = 0;
        #50;
        
        // Transmit first byte (0xA5)
        tx_d_in = 8'hA5;
        tx_en = 1;
        // #100;
        // tx_en = 0;

    end

    // Monitor UART data
    initial begin
        $monitor("Time=%0t | TX Data=%h | RX Data=%h | TX Status=%b | RX Status=%b",
                 $time, tx_d_in, rx_d_out, tx_status, rx_status);
    end

endmodule

