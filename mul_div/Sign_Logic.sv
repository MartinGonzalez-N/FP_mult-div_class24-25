`timescale 1ns / 1ps

module Sign_Logic(
    input sA, sB,
    input clk, arst, en,
    output sR
    );
    
    reg buffer1, buffer2, buffer3;
    wire s;
    
    assign s = sA^sB;
    
    always@(posedge clk or posedge arst) begin
        if (arst) begin
            buffer1 <= 1'b0;
            buffer2 <= 1'b0;
        end else if (en) begin
            buffer1 <= s;
            buffer2 <= buffer1;
        end
    end
    assign sR = buffer2;
endmodule