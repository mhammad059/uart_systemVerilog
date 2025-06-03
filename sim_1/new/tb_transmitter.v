`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2025 09:22:56 PM
// Design Name: 
// Module Name: tb_transmitter
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


module tb_transmitter;
    
    reg rst;
    reg bclk;
    reg [7:0] data_in;
    reg tx_en;
    wire tx_status;
    wire tx_data;
    
    // Instantiate the transmitter module
    transmitter uut (
        .rst(rst),
        .bclk(bclk),
        .THR(data_in),
        .tx_en(tx_en),
        .tx_status(tx_status),
        .tx_data(tx_data)
    );
    
    // Clock generation
    always #5 bclk = ~bclk; // 10ns clock period
    
    initial begin
        // Initialize signals
        rst = 1;
        bclk = 0;
        tx_en = 0;
        data_in = 8'b01101100;
        
        #5 rst = 0;
        
        // Apply stimulus
        #20 tx_en = 1; // Enable transmission
        
        // Wait for transmission to complete
        #200;
        
        // Apply another test case
        data_in = 8'b01101101;
        
        #200;
        
        // End simulation
        $stop;
    end
    
    // Monitor output
    initial begin
        $monitor("Time=%0t | tx_en=%b | data_in=%b | tx_status=%b | tx_data=%b", $time, tx_en, data_in, tx_status, tx_data);
    end
    
endmodule
