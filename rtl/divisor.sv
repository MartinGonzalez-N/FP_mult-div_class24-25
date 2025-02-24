`timescale 1ns / 1ps

module divisor #(parameter WIDTH = 24) 
(
    input  clk,          
    input  arst,         
    input  [WIDTH-1:0] a, 
    input  [WIDTH-1:0] b, 
    output logic div_by_zero,               
    output logic [WIDTH-1:0] q, 
    output logic [WIDTH-1:0] f,
    output logic [WIDTH+5:0] z
);

    logic [WIDTH-1:0] part_r;
    logic [WIDTH-1:0] r;
    logic [WIDTH-1:0] d;    
    logic [WIDTH-1:0] temp_q;             
    logic q_i;
    integer i;

    always_comb begin
        part_r = 0;
        if (b == 0) begin
            div_by_zero = 1;
            q = 0;
            f = 0;
        end else if (a >= b) begin
            for (i = WIDTH - 1; i >= 0; i = i - 1) begin
                r = {part_r[WIDTH -2:0] , a[i]};
                d = r - b;  
                if (d[WIDTH-1] == 1) begin
                    q_i = 0;
                    part_r = r;
                end else begin
                    q_i = 1;
                    part_r = d;
                end
            q = {q[WIDTH-2:0], q_i};  
            end
            for (i = 0; i < WIDTH; i = i + 1) begin
                part_r = part_r << 1;
                if (part_r >= b) begin
                    part_r = part_r - b;
                    f = {f[WIDTH-2:0], 1'b1};
                end else begin
                    f = {f[WIDTH-2:0], 1'b0};
                end
            end         
        r = part_r;    
        end else if (b > a) begin
            q = 0;
            part_r = a;
            for (i = 0; i < WIDTH; i = i + 1) begin
                part_r = part_r << 1;
                if (part_r >= b) begin
                    part_r = part_r - b;
                    f = {f[WIDTH-2:0], 1'b1};
                end else begin
                    f = {f[WIDTH-2:0], 1'b0};
                end
            end 
        end    
    end
endmodule