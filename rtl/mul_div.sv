`timescale 1ns / 1ps

module mul_div(
    input [31:0] a, b,
    input clk, arst, en, sel,
    output [31:0] R,
    output io_flag, dz_flag, of_flag, uf_flag, i_flag
    );
    
    wire [9:0] temp1;
    wire [47:0] temp2, temp3 , temp4;
    wire [25:0] temp5;

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
    
    mul #(.N(24)) mul_i (
        .x({1'b1,a[22:0]}),
        .y({1'b1,b[22:0]}),
        .clk(clk),
        .rst(arst),
        .z(temp2)
    );

    divisor #(.WIDTH(24)) divisor_i(
        .clk(clk),
        .arst(arst),
        .a({1'b1,a[22:0]}),
        .b({1'b1,b[22:0]}), 
        .div_by_zero(dz_flag), 
        .z(temp3)
    );

    assign temp4 = sel ? temp2 : temp3;

    normalizer normalizer_i(
        .mantissa_mul(temp4),
        .exponent_add(temp1),
        .sel(sel),
        .clk(clk),
        .arst(arst),
        .en(en),
        .mantissa_normalize(temp5),
        .exponent_single(R[30:23])
    );
    
    rounding rounding_i(
        .mul_normalize(temp5),
        .clk(clk),
        .arst(arst),
        .en(en),
        .mul_single(R[22:0])
    );
       
endmodule
