`timescale 1ns / 1ps

module tb_divisor;

    parameter WIDTH = 8;
    bit clk;
    bit arst;
    bit [WIDTH-1:0] a, b;
    logic [WIDTH-1:0] q, f, z;


    divisor #(WIDTH) DUT (
        .clk(clk),
        .arst(arst),
        .a(a),
        .b(b),
        .div_by_zero(div_by_zero),
        .q(q),
        .f(f),
        .z(z)
    );
    
    always #10 clk = !clk;

    initial begin 
        arst = 1;
        arst = 0;
        #20
        repeat(10) begin 
            std::randomize(a);
            std::randomize(b);  
            $display("A = %0d (binario: %b), B = %0d (binario: %b)", a, a, b, b);  
            #10;
            $display("Cociente: %0d (binario: %b), Residuo: %0d (binario: %b)", q, q, f, f);
        end
        $finish;
    end
    
    initial begin
        $shm_open("shm_db");
        $shm_probe("ASMTR");
    end

endmodule

