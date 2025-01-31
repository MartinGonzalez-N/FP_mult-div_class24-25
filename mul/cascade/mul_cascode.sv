`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/18/2025 06:51:11 PM
// Design Name: 
// Module Name: mul_cascode
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


module mul_cascode #(parameter N = 10) (
    input [N-1:0] x,
    input [N-1:0] y,
    input clk,
    output [2*N-1:0] z
);
    // Alambres
    wire [N-2:0] sx [N-1];
    wire [N-2:0] cx;
    
    //Registros 
    reg [N-2:0] sx_reg [N-1];
    reg [N-2:0] cx_reg;
    
    // Generar instancias
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : gen_step
            if (i == 0) begin
            
            step #(N) h (.X(x[N-1:0]),
                         .Y(y[i]),
                         .Si(0),
                         .Sx(0),
                         .So({sx[i],z[i]}),
                         .Co(cx[i]));
            
            end else if (i == N-1) begin
            
            step #(N) h (.X(x[N-1:0]),
                         .Y(y[i]),
                         .Si(cx_reg[i-1]),
                         .Sx(sx_reg[i-1]),
                         .So(z[i+N-1:i]),
                         .Co(z[2*N-1]));
                                                  
            end else begin
            
            step #(N) h (.X(x[N-1:0]),
                         .Y(y[i]),
                         .Si(cx_reg[i-1]),
                         .Sx(sx_reg[i-1]),
                         .So({sx[i],z[i]}),
                         .Co(cx[i]));
            end
            
            always@(posedge clk)begin
                sx_reg[i] <= sx[i];
                cx_reg[i] <= cx[i];
            end
        end
    endgenerate
    
endmodule