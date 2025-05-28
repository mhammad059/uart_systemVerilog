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


module clockDiv #(parameter DIV = 100000000)(
    input logic inp_clk,
    output logic out_clk
    );

    logic [26:0] count = 0;
    always@(posedge inp_clk) begin
        if(count == DIV - 1) count <= 0;
        else count <= count + 1;
        out_clk <= (count<DIV/2) ? 1'b0 : 1'b1;
    end
    
endmodule
