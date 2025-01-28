`timescale 1ns / 1ps

/*
	This module implements rounding using the GRS bits
*/

module rounding(
    input [25:0] mul_normalize, //mantissa from the normalize block
    input clk, arst, en,
    output [22:0] mul_single//mantissa with the format of the IEEE 754 standard
    );
    
    assign mul_single = mul_normalize[25:3];
    //uncomment if sync is needed. If it is only 1 clk add reg to mul_single, if more add buffers
    /*always@(posedge clk or posedge arst)begin
        if(arst) begin
            mul_single <= 0;
        end else if(en) begin
            mul_single <= mul_normalize[25:3];
        end
    end
    */
endmodule
