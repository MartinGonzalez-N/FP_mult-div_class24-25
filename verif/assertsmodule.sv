module assertsmodule (
    input bit clk,
    input logic [31:0] a, b,
    input logic arst, en, sel,
    input logic [31:0] R,
    input logic io_flag, dz_flag, of_flag, uf_flag, i_flag
    );

    property check_exponent_infinite;
        @(posedge clk) ((a[30:23] + b[30:23] > 9'd382) && (sel == 0)) |-> (R == 32'h7f800000);
    endproperty

    assert property (check_exponent_infinite) 
    else begin
        $error("Overflow occurred, result should be infinite");
    end

    assert property check_exponent_result_mult; @(posedge clk) 
	((a[30:23] + b[30:23] < 9'd382) && (sel == 0)) |->  (R[30:23] == (a[30:23] + b[30:23] - 8'd127)) 
        else begin
            $error("The exponent result is wrong"); 
        end
    endproperty

    assert property check_exponent_result_div; @(posedge clk) 
	((b[30:0] != 31'b0) && (sel == 1)) |-> (R[30:23] == a[30:23] - b[30:23] + 8'd127) 
        else begin
            $error("The exponent result is wrong");
        end
    endproperty

    assert property check_div_b_0 @(posedge clk) 
	((b[30:0] == 31'b0) && (sel == 1)) |-> (dz_flag == 1) 
        else begin
            $error("The división by zero flag should have raised");
        end
    endproperty

    /************************Mantissa Block**************************************/

    assert property p_mantissa_zero;
        @(posedge clk) disable iff (reset)
        (mant_a == 0 || mant_b == 0) |=> mant_result == 0;
        else $error("Error: Product must be zero when one input is zero");
    endproperty

    assert property p_mantissa_overflow;
        @(posedge clk) disable iff (reset)
        (a[23:0] != 0 && b[23:0] != 0) |=> R[23:0] > 23'h0 && R[23:0] <= 23'hFFFFFFFFFFFF;
        $error("Error: Mantissa overflow detected");
    endproperty

    assert property p_mantissa_normalization;
        @(posedge clk) disable iff (reset)
        (R[22] == 1) |=> (R >> 1) == expected_mantissa; 
        else $error("Error: Mantissa's incorrect normalization");
    endproperty

    assert property p_mantissa_denormal;
        @(posedge clk) disable iff (reset)
        (R < 23'h800000 && R > 0) |=> is_subnormal_result;
        else $error("Error: Product must be denormalized");
    endproperty

    assert property p_sign_correctness;
        @(posedge clk) disable iff (reset)
        R[31] == (a[31] ^ b[31]);
         else $error("Error: incorrect result sign");
    endproperty


endmodule
