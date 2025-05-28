`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2025 12:40:55 PM
// Design Name: 
// Module Name: universalReg
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


module universalReg(
    input logic clk, clear, sr_inRS, sr_inLS,
    input logic [1:0] mode,
    input logic [3:0] d,
    output logic [3:0] q
    );

    always @(negedge clk) begin        
        case(mode)
            2'b00: q <= q;
            2'b01: begin //right shift
                q <= {sr_inRS, q[3:1]};
            end
            2'b10: begin // left shift
                q <= {q[2:0], sr_inLS};
            end
            2'b11: q <= d;
            default: q <= 0;
        endcase
    end //always
    
endmodule
