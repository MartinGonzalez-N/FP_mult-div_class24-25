`timescale 1ns / 1ps

/*
    This module normalizes the mantissa if necessary and adjusts
    the exponent due to the normalization for both multiplication and division.
*/ 

module normalizer(
    input [47:0] mantissa_mul, // mantissa from the multiplier
    input [47:0] mantissa_div, // mantissa from the divisor
    input [9:0] exponent_add,  // exponent coming from exponent logic
    input sel, clk, arst, en,  // operation selector bit, clock signal, asynchronous reset, and enable signal
    output [25:0] mantissa_normalize, // output mantissa already normalized
    output [7:0] exponent_single // output exponent already adjusted
    );
    
    wire [10:0] temp1;
    //reg [47:0] buffer1, buffer2;
    reg [47:0] temp_mul, temp_div;

    // MUX to select between multiplication and division mantissas

    assign temp_mul = (mantissa_mul[47]) ? mantissa_mul[46:21] : mantissa_mul[45:20]; // MUX that normalizes the mantissa
    assign temp1 = (mantissa_mul[47]) ? exponent_add + 1'b1 : exponent_add; // MUX that adjusts the exponent
    assign exponent_single = temp1[7:0]; // Adjusts the exponent to the IEEE 754 standard format
	assign temp_div = (mantissa_div[47]) ? mantissa_div[46:21] :
                      (mantissa_div[47:46] == 2'b01) ? mantissa_div[45:20] :
                      (mantissa_div[47:45] == 3'b001) ? mantissa_div[44:19] :
                      (mantissa_div[47:44] == 4'b0001) ? mantissa_div[43:18] :
                      (mantissa_div[47:43] == 5'b00001) ? mantissa_div[42:17] :
                      (mantissa_div[47:42] == 6'b000001) ? mantissa_div[41:16] :
                      (mantissa_div[47:41] == 7'b0000001) ? mantissa_div[40:15] :
                      (mantissa_div[47:40] == 8'b00000001) ? mantissa_div[39:14] :
                      (mantissa_div[47:39] == 9'b000000001) ? mantissa_div[38:13] :
                      (mantissa_div[47:38] == 10'b0000000001) ? mantissa_div[37:12] :
                      (mantissa_div[47:37] == 11'b00000000001) ? mantissa_div[36:11] :
                      (mantissa_div[47:36] == 12'b000000000001) ? mantissa_div[35:10] :
                      (mantissa_div[47:35] == 13'b0000000000001) ? mantissa_div[34:9] :
                      (mantissa_div[47:34] == 14'b00000000000001) ? mantissa_div[33:8] :
                      (mantissa_div[47:33] == 15'b000000000000001) ? mantissa_div[32:7] :
                      (mantissa_div[47:32] == 16'b0000000000000001) ? mantissa_div[31:6] :
                      (mantissa_div[47:31] == 17'b00000000000000001) ? mantissa_div[30:5] :
                      (mantissa_div[47:30] == 18'b000000000000000001) ? mantissa_div[29:4] :
                      (mantissa_div[47:29] == 19'b0000000000000000001) ? mantissa_div[28:3] :
                      (mantissa_div[47:28] == 20'b00000000000000000001) ? mantissa_div[27:2] :
                      (mantissa_div[47:27] == 21'b000000000000000000001) ? mantissa_div[26:1] :
                      mantissa_div[25:0];
    
    assign mantissa_normalize = sel ? temp_div : temp_mul;
endmodule
