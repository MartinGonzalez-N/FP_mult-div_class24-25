`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2025 02:35:40 PM
// Design Name: 
// Module Name: TestBench
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



module mul_tb();
    
    bit clk;
    mul_div_if #() i_f(clk);
    
    mul_div #() DUT (
        .clk(i_f.clk), 
        .arst(i_f.arst),          
        .a(i_f.a),  
        .b(i_f.b),
        .sel(i_f.sel),
        .en(i_f.en),
        .R(i_f.R),
        .io_flag(i_f.io_flag), 
        .dz_flag(i_f.dz_flag), 
        .of_flag(i_f.of_flag), 
        .uf_flag(i_f.uf_flag),
        .i_flag(i_f.i_flag)
    );

    initial begin
        $shm_open("shm_db");
        $shm_probe("ASMTR");
    end

    always #10 clk = ~clk;
    
    /* always @(posedge clk) begin
    
    end */
    
    initial begin
    i_f.test_full_random();
    $finish;
    end

endmodule

