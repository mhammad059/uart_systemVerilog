`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2025 10:47:59 PM
// Design Name: 
// Module Name: tb_receiver
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


module tb_receiver;
    
    reg rst;
    reg bclkx8;
    reg rx_data;
    wire rx_status;
    wire [7:0] d_out;
    
    receiver uut (
        .rst(rst),
        .bclkx8(bclkx8),
        .rx_data(rx_data),
        .rx_status(rx_status),
        .RHR(d_out)
    );
    
    // Clock generation
    initial begin
        bclkx8 = 0;
        rst = 1;
        #5 rst = 0;
        forever #5 bclkx8 = ~bclkx8; // 10ns period
    end
    
    // Task to send a byte serially
    task send_byte;
        input [7:0] data;
        integer i;
        begin
            // Start bit
            rx_data = 0;
            #80; // 8 clock cycles
            
            // Data bits (LSB first)
            for (i = 0; i < 8; i = i + 1) begin
                rx_data = data[i];
                #80; // 8 clock cycles per bit
            end
            
            // Stop bit
            rx_data = 1;
            #80;
        end
    endtask
    
    // Test sequence
    initial begin
        // Initialize signals
        rx_data = 1;
        
        // Wait a bit before sending data
        #100;
        
        // Send test bytes
        send_byte(8'hA6); // 1010_0101
        #200;
        send_byte(8'h3C); // 0011_1100
        #200;
        
        // Finish simulation
        #500;
        $finish;
    end
    
    // Monitor outputs
    initial begin
        $monitor("Time=%0t | rx_status=%b | d_out=%h", $time, rx_status, d_out);
    end
    
endmodule
