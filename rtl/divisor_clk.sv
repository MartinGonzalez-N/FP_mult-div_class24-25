`timescale 1ns / 1ps

module divisor_clk #(parameter WIDTH = 24,
                 parameter WIDTHZ = (WIDTH*2)) 
(
    input logic clk,          
    input logic arst,         
    input logic start, 
    input logic [WIDTH-1:0] a, 
    input logic [WIDTH-1:0] b, 
    output logic done, 
    output logic div_by_zero,               
    output logic [WIDTH-1:0] q, 
    output logic [WIDTH-1:0] f,
    output logic [WIDTHZ-1:0] z
);

    typedef enum logic [1:0] {
        IDLE, COMPUTE_INT, COMPUTE_FRAC, DONE
    } state_t;

    state_t state, next_state;
    
    logic [WIDTH-1:0] part_r, next_part_r;
    logic [WIDTH-1:0] d, next_d;
    logic [WIDTH-1:0] q_i, next_q_i; 
    logic [WIDTH-1:0] next_q, next_f;
    logic [5:0] bit_counter, next_bit_counter;
    logic next_done, next_div_by_zero;
    logic [WIDTHZ-1:0] next_z;
    
    always_comb begin
        
        next_state = state;
        next_part_r = part_r;
        next_q_i = q_i;
        next_q = q;
        next_f = f;
        next_bit_counter = bit_counter;
        next_done = 0;
        next_div_by_zero = 0;
        next_d = d;
        next_z = z;
        
        case (state)
            IDLE: begin
                if (start) begin
                    if (b == 0) begin
                        next_div_by_zero = 1;
                        next_q = 0;
                        next_f = 0;
                        next_state = DONE;
                    end else if (a < b) begin
                        next_q = 0;
                        next_part_r = a; 
                        next_bit_counter = 0;
                        next_f = 0;
                        next_state = COMPUTE_FRAC;
                    end else begin
                        next_div_by_zero = 0;
                        next_part_r = 0;
                        next_q_i = 0;
                        next_bit_counter = WIDTH;
                        next_state = COMPUTE_INT;
                    end
                end
            end

            COMPUTE_INT: begin
                if (bit_counter > 0) begin
                    next_part_r = {part_r[WIDTH-2:0], a[bit_counter-1]};
                    next_d = next_part_r - b;
                    if (next_d[WIDTH-1] == 0) begin
                        next_q_i = {q_i[WIDTH-2:0], 1'b1};
                        next_part_r = next_d;
                    end else begin
                        next_q_i = {q_i[WIDTH-2:0], 1'b0};
                    end
                    next_bit_counter = bit_counter - 1;
                end else begin
                    next_q = q_i;
                    next_bit_counter = 0;
                    next_f = 0;
                    next_state = COMPUTE_FRAC;
                end
            end

            COMPUTE_FRAC: begin
                for (int i = 0; i < WIDTH; i = i + 1) begin
                    next_part_r = next_part_r << 1;
                    if (next_part_r >= b) begin
                        next_part_r = next_part_r - b;
                        next_f = {next_f[WIDTH-2:0], 1'b1};
                    end else begin
                        next_f = {next_f[WIDTH-2:0], 1'b0};
                    end
                end
                next_state = DONE;
            end

            DONE: begin
                next_done = 1;
                next_z = {next_q, next_f};
                if (!start) begin  
                    next_state = IDLE;
                end
            end
        endcase
    end

    always_ff @(posedge clk or posedge arst) begin
        if (arst) begin
            q <= 0;
            f <= 0;
            part_r <= 0;
            div_by_zero <= 0;
            done <= 0;
            state <= IDLE;
            bit_counter <= 0;
            z <= 0;
        end else begin
            q <= next_q;
            f <= next_f;
            part_r <= next_part_r;
            div_by_zero <= next_div_by_zero;
            done <= next_done;
            state <= next_state;
            bit_counter <= next_bit_counter;
            q_i <= next_q_i;
            d <= next_d;
            z <= next_z;
        end
    end
endmodule
