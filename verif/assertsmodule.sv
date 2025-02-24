module assertsmodule (
    logic clk,
    logic [31:0] a, b,
    logic arst, en, sel,
    logic [31:0] R,
    logic io_flag, dz_flag, of_flag, uf_flag, i_flag
    );

    logic [22:0] expected_mantissa;
    logic is_subnormal_result;


    property check_div_b_0;
        @(posedge clk) ((b[30:0] == 31'b0) && (sel == 1)) |-> ##1 (dz_flag == 1);
    endproperty
    assert property (check_div_b_0) 
    else begin
        $error("The division by zero flag should have raised");
    end
    
    /************************Exponent Block**************************************/

    property check_exponent_infinite;
        @(posedge clk) ((a[30:22] + b[30:22] > 9'd382) && (sel == 0)) |-> ##1 (R == 32'h7f800000);
    endproperty
    assert property (check_exponent_infinite) 
    else begin
        $error("Overflow occurred, result should be infinite");
    end

    property check_exponent_result_mult;
        @(posedge clk) ((a[30:22] + b[30:22] < 9'd382) && (sel == 0)) 
            |-> ##1 (R[30:22] == (a[30:22] + b[30:22] - 8'd127));
    endproperty
    assert property (check_exponent_result_mult) 
    else begin
        $error("The exponent result is wrong"); 
    end

    property check_exponent_result_div;
        @(posedge clk) ((b[30:0] != 31'b0) && (sel == 1)) 
            |-> ##1 (R[30:22] == a[30:22] - b[30:22] + 8'd127);
    endproperty
    assert property (check_exponent_result_div) 
    else begin
        $error("The exponent result is wrong");
    end

    /************************Mantissa Block**************************************/

    property p_mantissa_zero;
        @(posedge clk) disable iff (arst)
        (a[22:0] == 0 || b[22:0] == 0) |=> (R[22:0] == 0);
    endproperty
    assert property (p_mantissa_zero) 
    else $error("Error: Product must be zero when one input is zero");

    property p_mantissa_overflow;
        @(posedge clk) disable iff (arst)
        (a[22:0] != 0 && b[22:0] != 0) |=> (R[22:0] > 22'h0 && R[22:0] <= 22'h7FFFFF);
    endproperty
    assert property (p_mantissa_overflow) 
    else $error("Error: Mantissa overflow detected");

    property p_mantissa_normalization;
        @(posedge clk) disable iff (arst)
        (R[22] == 1) |=> ((R >> 1) == expected_mantissa);
    endproperty
    assert property (p_mantissa_normalization) 
    else $error("Error: Mantissa's incorrect normalization");

    property p_mantissa_denormal;
        @(posedge clk) disable iff (arst)
        (R < 22'h800000 && R > 0) |=> is_subnormal_result;
    endproperty
    assert property (p_mantissa_denormal) 
    else $error("Error: Product must be denormalized");

    property p_sign_correctness;
        @(posedge clk) disable iff (arst)
        (R[31] == (a[31] ^ b[31]));
    endproperty
    assert property (p_sign_correctness) 
    else $error("Error: Incorrect result sign");


endmodule
