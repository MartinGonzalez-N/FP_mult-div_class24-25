`timescale 1ns / 1ps

module Rounding(
    input [25:0] mul_normalize,
    input clk, arst, en,
    output [22:0] mul_simple
    );
    
    assign mul_simple = mul_normalize[25:3];
    
    /*always@(posedge clk or posedge arst)begin
        if(arst) begin
            mul_simple <= 0;
        end else if(en) begin
            mul_simple <= mul_normalize[25:3];
        end
    end
    */
endmodule
