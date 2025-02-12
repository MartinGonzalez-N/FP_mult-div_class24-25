module tb;

    parameter N = 23;
    bit [N-1:0] x;
    bit [N-1:0] y;
    bit clk;
    logic [2*N-1:0] z;

    initial begin
        $shm_open("shm_db");
        $shm_probe("ASMTR");
    end

    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        //$dumpfile("dump.vcd"); 
        //$dumpvars;
        //x = $random;
        //y = $random;

        repeat (1000) begin

            @(posedge clk)
            //@(posedge clk)
            //@(posedge clk)
            //@(posedge clk)
            //x = 4'b1111;
            std::randomize(y);
            std::randomize(x);
            //std::randomize(y);
            //$display("x = %d", x);
            //$display("y = %d", y);
            //#10;
            //$display("z = %d", z);

        end
        $finish;
    end
    mul_cascode #(N) mul (.x(x), .y(y), .clk(clk), .z(z));
endmodule
