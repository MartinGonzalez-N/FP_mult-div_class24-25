`timescale 1ns / 1ps

module tb_divisor;

    parameter WIDTH = 8;
    bit clk;
    bit rst;
    bit [WIDTH-1:0] a, b;
    logic [WIDTH-1:0] q, r;


    divisor #(WIDTH) DUT (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .q(q),
        .r(r)
    );
    
    always #10 clk = !clk;

    initial begin 
        rst = 1;
        rst = 0;
        #20
        repeat(10) begin 
            std::randomize(a);
            std::randomize(b);  
            $display("A = %0d (binario: %b), B = %0d (binario: %b)", a, a, b, b);  
            #10;
            $display("Cociente: %0d (binario: %b), Residuo: %0d (binario: %b)", q, q, r, r);
        end
        $finish;
    end
    
    initial begin
        $shm_open("shm_db");
        $shm_probe("ASMTR");
    end

endmodule

