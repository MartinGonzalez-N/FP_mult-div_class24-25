`timescale 1ns / 1ps

module mul_div(
    input [31:0] a, b,
    input clk, arst, en, sel,
    output [31:0] R,
    output io_flag, dz_flag, of_flag, uf_flag, i_flag
    );
    
    wire [9:0] temp1;
    wire [47:0] temp2;
    wire [25:0] temp3;
    
    sign_logic sign_logic_i(
        .s_a(a[31]),
        .s_b(b[31]),
        .clk(clk),
        .arst(arst), 
        .en(en),
        .s_r(R[31])
    );
    
    exponent_logic exponent_logic_i(
        .e_a(a[30:23]), 
        .e_b(b[30:23]),
        .clk(clk),
        .arst(arst),
        .en(en),
        .sel(sel),
        .e(temp1)
    );
    
    mul_cascode #(.N(24)) mul_cascode_i (
        .x({1'b1,a[22:0]}),
        .y({1'b1,b[22:0]}),
        .z(temp2)
    );
    
    normalizer normalizer_i(
        .mantissa_mul(temp2),
        .exponent_add(temp1),
        .sel(sel),
        .clk(clk),
        .arst(arst),
        .en(en),
        .mantissa_normalize(temp3),
        .exponent_single(R[30:23])
    );
    
    rounding rounding_i(
        .mul_normalize(temp3),
        .clk(clk),
        .arst(arst),
        .en(en),
        .mul_single(R[22:0])
    );
       
endmodule
