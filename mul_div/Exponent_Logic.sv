`timescale 1ns / 1ps

module Exponent_Logic(
    input [7:0] eA, eB,
    input clk, arst, en, sel,
    output [9:0] e
    );
    wire [7:0] temp1,temp2;
    wire [8:0] temp3;
    reg [7:0] buffer1, buffer2;
    reg [8:0] buffer3, buffer4;
    //reg [9:0] buffer4;

    assign temp1 = ~eB + 1'b1;
    assign temp2 = (sel)? temp1 : eB;
    assign temp3 = (sel)? 9'h07f : 9'h181; 
    
    always@(posedge clk or posedge arst)begin
        if(arst) begin
            buffer1 <= 8'h00;
            buffer2 <= 8'h00;
            buffer3 <= 9'h000;
        end else if(en) begin
            buffer1 <= temp2;
            buffer2 <= eA;
            buffer3 <= buffer1+buffer2;
        end
    end
    assign e = buffer3+temp3;;
endmodule
