`timescale 1ns / 1ps

/*
	This module handles the exponent logic, 
	where the logic for the multiplier and 
	the divider is unified. In this module, 
	two N-bit numbers are input, and a 10-bit
	output is produced due to the carry from 
	the addition.
*/

module exponent_logic(
    input [7:0] e_a, e_b, //Exponent of number A and exponent of number B, respectively.
    input clk, arst, en, sel, // clock signal, asynchronous reset, enable signal and operation selector bit
    output [9:0] e //Output exponent
    );
    //Internal variables
		//Internal variables for combinational operations
	wire [7:0] temp1,temp2; 
    wire [8:0] temp3;
		// buffers to synchronize the output signal
	reg [7:0] buffer1, buffer2;
    reg [8:0] buffer3, buffer4;

    assign temp1 = ~e_b + 1'b1; //assigns to temp1 the negative of the exponent of B (a2's complement)
    assign temp2 = (sel)? temp1 : e_b; //MUX for routing B or its complement a2
    assign temp3 = (sel)? 9'h07f : 9'h181; //MUX for routing bias equal to 127 or -127
    
    always@(posedge clk or posedge arst)begin
        if(arst) begin
            buffer1 <= 8'h00;
            buffer2 <= 8'h00;
            buffer3 <= 9'h000;
        end else if(en) begin
            buffer1 <= temp2;
            buffer2 <= e_a;
            buffer3 <= buffer1+buffer2;//Addition or subtraction of exponents
        end
    end
    assign e = buffer3+temp3;//Addition or subtraction of bias
endmodule
