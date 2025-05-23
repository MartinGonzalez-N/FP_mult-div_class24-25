module flipflop (
    input clk,
    input rst,
    input in,
    output reg out
);

    always @(posedge clk) begin
        if (rst) out <= 1'b0;
        else     out <= in;
    end

endmodule