`timescale 1ns / 1ps

/*
	This module normalizes the mantissa if necessary and adjusts
	the exponent due to the normalization.
*/ 

module normalizer(
    input [47:0] mantissa_mul,//mantissa from the multiplier
    input [9:0] exponent_add, //exponent coming from exponent logic
    input sel, clk, arst, en, //operation selector bit, clock signal, asynchronous reset and enable signal
    output [25:0] mantissa_normalize, //output mantissa already normalized
    output [7:0] exponent_single //output exponent already adjusted
    );
    
    wire [10:0] temp1;
    reg [47:0] buffer1, buffer2;
    
    
    assign mantissa_normalize = (buffer2[47]) ? buffer2[46:21] : buffer2[45:20]; //MUX that normalizes the mantissa 
    assign temp1 = (buffer2[47]) ? exponent_add + 1'b1 : exponent_add;//MUX that adjusts the exponent
    assign exponent_single = temp1[7:0]; //adjusts the exponent to the IEEE 754 standard format
	
	// buffers to synchronize the output signal
    always@(posedge clk or posedge arst)begin
        if(arst) begin
            buffer1 <= 0;
            buffer2 <= 0;
        end else if(en) begin
            buffer1 <= mantissa_mul;
            buffer2 <= buffer1;
        end
    end
    
endmodule
