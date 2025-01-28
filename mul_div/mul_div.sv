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
        .sa(a[31]),
        .sb(b[31]),
        .clk(clk),
        .arst(arst), 
        .en(en),
        .sR(R[31])
    );
    
    exponent_logic exponent_logic_i(
        .ea(a[30:23]), 
        .eb(b[30:23]),
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
        .mantisa_mul(temp2),
        .exponent_add(temp1),
        .sel(sel),
        .clk(clk),
        .arst(arst),
        .en(en),
        .mantisa_normalize(temp3),
        .exponent_simple(R[30:23])
    );
    
    rounding rounding_i(
        .mul_normalize(temp3),
        .clk(clk),
        .arst(arst),
        .en(en),
        .mul_simple(R[22:0])
    );
       
endmodule
