`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2025 01:56:19 PM
// Design Name: 
// Module Name: clockDiv
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


module clockDiv #(parameter DIV = 8)(
    input logic inp_clk,
    input logic rst,
    output logic out_clk
    );

    logic [$clog2(DIV)-1:0] count;
    always@(posedge inp_clk or posedge rst) begin
        if(rst) begin
            out_clk <= 0;
            count <= 0;
        end
        else begin
            if(count == DIV - 1) count <= 0;
            else count <= count + 1;
            out_clk <= (count<DIV/2) ? 1'b0 : 1'b1;
        end
    end
    
endmodule
