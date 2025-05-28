`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2025 12:46:10 PM
// Design Name: 
// Module Name: tb_universalReg
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


`timescale 1ns / 1ps

module tb_universalReg;
    
    reg clk, clear, sr_inRS, sr_inLS;
    reg [1:0] mode;
    reg [3:0] d;
    wire [3:0] q;
    
    // Instantiate the module under test
    universalReg uut (
        .clk(clk),
        .clear(clear),
        .sr_inRS(sr_inRS),
        .sr_inLS(sr_inLS),
        .mode(mode),
        .d(d),
        .q(q)
    );
    
    // Clock generation
    always #5 clk = ~clk; // 10 ns period (100 MHz)
    
    initial begin
        // Initialize signals
        clk = 0;
        clear = 0;
        sr_inRS = 0;
        sr_inLS = 0;
        mode = 2'b00;
        d = 4'b0000;
        
        // Apply reset
        #10 clear = 1;
        #10 clear = 0;
        
        // Hold state
        mode = 2'b00;
        #10;
        
        // Load parallel data
        d = 4'b1010;
        mode = 2'b11;
        #10;
        
        // Right shift test
        mode = 2'b01;
        sr_inRS = 1;
        #10;
        sr_inRS = 0;
        #10;
        
        // Left shift test
        mode = 2'b10;
        sr_inLS = 1;
        #10;
        sr_inLS = 0;
        #10;
        
        // Hold state again
        mode = 2'b00;
        #10;
        
        // End simulation
        $stop;
    end
endmodule