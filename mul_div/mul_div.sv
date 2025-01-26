`timescale 1ns / 1ps

module mul_div(
    input [31:0] A, B,
    input clk, arst, en, sel,
    output [31:0] R,
    output IO, DZ, OF, UF, I
    );
    
    wire [9:0] temp1;
    wire [47:0] temp2;
    wire [25:0] temp3;
    
    Sign_Logic Sign_Logic_i(
        .sA(A[31]),
        .sB(B[31]),
        .clk(clk),
        .arst(arst), 
        .en(en),
        .sR(R[31])
    );
    
    Exponent_Logic Exponent_Logic_i(
        .eA(A[30:23]), 
        .eB(B[30:23]),
        .clk(clk),
        .arst(arst),
        .en(en),
        .sel(sel),
        .e(temp1)
    );
    
    mul_cascode #(.N(24)) mul_cascode_i (
        .x({1'b1,A[22:0]}),
        .y({1'b1,B[22:0]}),
        .z(temp2)
    );
    
    Normalizer Normalizer_i(
        .mantisa_mul(temp2),
        .exponent_add(temp1),
        .sel(sel),
        .clk(clk),
        .arst(arst),
        .en(en),
        .mantisa_normalize(temp3),
        .exponent_simple(R[30:23])
    );
    
    Rounding Rounding_i(
        .mul_normalize(temp3),
        .clk(clk),
        .arst(arst),
        .en(en),
        .mul_simple(R[22:0])
    );
       
endmodule
