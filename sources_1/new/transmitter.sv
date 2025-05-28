`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2025 12:37:41 PM
// Design Name: 
// Module Name: transmitter
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


module transmitter(
    input logic rst,
    input logic bclk,
    input logic [7:0] THR,
    input logic tx_en,
    output logic tx_status,
    output logic tx_data
    );
    
    parameter IDLE = 2'b00;
    parameter START = 2'b01;
    parameter DATA = 2'b10;
    parameter STOP = 2'b11;
    
    logic [1:0] PS;
    logic [9:0] TSR;
    logic [3:0] count;
    
    
    always_comb begin // combinational control logic
        case(PS)
            IDLE: begin
                tx_data = 1'b1;
                tx_status = 1'b0;
                end
            START: begin
                tx_data = 1'b1;
                tx_status = 1'b1;
            end    
            DATA: begin
                tx_data = TSR[0];
                tx_status = 1'b1;
                
            end
            STOP: begin
                tx_data = 1'b1; // idle/stop bit
                tx_status = 1'b0;
            end
        endcase
    end
    
    always_ff @(posedge bclk or posedge rst) begin
        if(rst) begin
            PS <= 0;
            TSR <= 0;
        end
        else begin
            case(PS)
                IDLE: begin
                    TSR <= THR;
                    count <= 0;
                    if(tx_en) PS <= START;
                    else PS <= IDLE;
                end
                START: begin
                    PS <= DATA;
                    TSR <= {1'b1, THR, 1'b0};
                end
                DATA: begin
                    TSR[8:0] <= TSR[9:1]; // shift right 
                    count <= count + 1;
                    if(count == 9) PS <= STOP;
                    else PS <= DATA;
                end
                STOP: PS <= IDLE;
            endcase
        end
    end
    
endmodule
