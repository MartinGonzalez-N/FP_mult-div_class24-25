`timescale 1ns / 1ps

module Normalizer(
    input [47:0] mantisa_mul,
    input [9:0] exponent_add,
    input sel, clk, arst, en,               // MESSAGE TO DESIGNERS: sel signal not used 
    output [25:0] mantisa_normalize,
    output [7:0] exponent_simple
    );
    
    wire [10:0] temp1;
    reg [47:0] buffer1, buffer2;
    //reg [25:0] buffer2; 
    
    
    assign mantisa_normalize = (buffer2[47]) ? buffer2[46:21] : buffer2[45:20];
    assign temp1 = (buffer2[47]) ? exponent_add + 1'b1 : exponent_add;
    assign exponent_simple = temp1[7:0];
    
    always@(posedge clk or posedge arst)begin
        if(arst) begin
            buffer1 <= 0;
            buffer2 <= 0;
            //buffer3 <= 0;
        end else if(en) begin
            buffer1 <= mantisa_mul;
            //buffer2 <= buffer1;
            buffer2 <= buffer1;
        end
    end
    
endmodule



task RANDOM_MANTISSA_TESTS();
    
endtask
