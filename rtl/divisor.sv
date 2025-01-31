`timescale 1ns / 1ps


module divisor #(parameter WIDTH = 8) 
(
    input  bit clk,
    input  bit rst,
    input  bit [WIDTH-1:0] a, 
    input  bit [WIDTH-1:0] b,                 
    output logic [WIDTH-1:0] q, r                 
);

    logic [WIDTH-1:0] scaled_r, aux_r;
    logic [WIDTH-1:0] d;             
    logic q_i;
    
    integer i;
    
    //always @(posedge clk) begin
    //initial begin
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            q <= 0;
            r <= 0;
        end else begin
            scaled_r <= 0;
            q <= 0;
            r <= 0;
            for (i = WIDTH - 1; i >= 0; i = i -1) begin
                aux_r <= {scaled_r[WIDTH-2:0], a[i]};
                d <= aux_r - b;  
                if(d[WIDTH-1] == 1) begin
                //if(D[WIDTH-1]<0) begin
                    q_i <= 0;
                    scaled_r <= aux_r;
                end else begin
                    q_i <= 1;
                    scaled_r <= d;
                end
                
                q = {q[WIDTH-2:0], q_i};
            end
            r <= scaled_r;
        end
    end
endmodule

