`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2025 11:08:08 AM
// Design Name: 
// Module Name: tb
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


module tb;

    parameter N = 10;
    logic [N-1:0] x;
    logic [N-1:0] y;
    logic [2*N-1:0] z;

    
    initial begin
        //$dumpfile("dump.vcd"); 
        //$dumpvars;

        repeat (10) begin
            x = $random;
            y = $random;
            #10;
            $display("x = %d", x);
            $display("y = %d", y);
            //#10;
            //$display("z = %d", z);
        end
    end
    mul_cascode #(N) mul (.x(x), .y(y), .z(z));
endmodule
