`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2025 09:55:21 PM
// Design Name: 
// Module Name: receiver
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


module receiver(
    input logic sys_clk,
    input logic rst,
    input logic bclkx8,
    input logic rx_data,
    output logic rx_status,
    output logic [7:0] RHR    
    );
    
    logic [3:0] bit_count;
    logic [2:0] count;
    logic bclkx8_old;

    parameter IDLE = 2'b00;
    parameter START = 2'b01;
    parameter DATA = 2'b10;
    parameter STOP = 2'b11;
    
    logic [1:0] PS;
    
    logic [9:0] RSR;
      
    always_comb begin // combinational control logic
        case(PS)
            IDLE: begin;
                rx_status = 1'b0;
                end
            START: begin
                rx_status = 1'b1;                
            end    
            DATA: begin
                rx_status = 1'b1;
            end
            STOP: begin
                rx_status = 1'b0;
            end
        endcase
    end

    always_ff @(posedge sys_clk or posedge rst) begin
        if(rst) begin
            RHR <= 0;
            RSR <= 0;
            PS <= 0;
            count <= 0;
            bit_count <= 0;
            bclkx8_old <= bclkx8;
        end else begin
            bclkx8_old <= bclkx8;
            if (bclkx8 & ~bclkx8_old) begin // positive change
                case(PS)
                    IDLE: begin
                        count <= 0;
                        bit_count <=0;
                        if(rx_data) PS <= IDLE;
                        else PS <= START; // if rx_data == 0 -> start receiving
                        end
                    START: begin
                        bit_count <=0;
                        if(count == 3) begin // sample if count == 3 (4 clk cycles)
                            RSR[9:0] <= {RSR[8:0], rx_data}; // shift right
                            PS <= DATA;
                            count <= 0;
                        end else begin 
                            PS <= START;
                            count <= count + 1;
                        end
                    end
                    DATA: begin
                        if(count == 7) begin // sample if count == 7 (8 clk cycles)
                            bit_count <= bit_count + 1;
                            count <= 0;
                            RSR[9:0] <= {rx_data, RSR[9:1]}; // shift right
                        end else begin
                            count <= count + 1; 
                            if(bit_count == 9) PS <= STOP; // if complete, stop reading
                            else begin
                                PS <= DATA;
                            end
                        end
                    end
                    STOP: begin
                        RHR <= RSR[8:1];
                        PS <= IDLE;
                        count <= 0;
                        bit_count <=0;
                    end
                endcase
            end
        end
    end
        
endmodule
