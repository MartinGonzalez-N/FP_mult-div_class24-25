//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.01.2025 22:22:07
// Design Name: 
// Module Name: normalizer_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module normalizer_tb();
    bit clk;

    normalizerInterface norm_if(clk);                           //Normalizer interface instantiation

    Normalizer  DUT (                                           //DUT instantiation
        .mantisa_mul(norm_if.mantisa_mul),
        .exponent_add(norm_if.exponent_add),
        .sel(norm_if.sel),
        .clk(clk),
        .arst(norm_if.arst),
        .en(norm_if.en),
        .mantisa_normalize(norm_if.mantisa_normalize),
        .exponent_simple(norm_if.exponent_simple)
        );

    always #1 clk = !clk;                                       // General clock


    `ifdef TEST1 // 100 RANDOM NORMAL MANTISSAS
        initial begin
            norm_if.SET_ARST_TO(1'b0);
            norm_if.SET_ENABLE_TO(1'b1);
            norm_if.RANDOM_NORMAL_MANTISSA_TESTS(100);
        end
    `endif

    `ifdef TEST2 // 100 RANDOM UNNORMAL MANTISSAS
        initial begin
            norm_if.SET_ARST_TO(1'b0);
            norm_if.SET_ENABLE_TO(1'b1);
            norm_if.RANDOM_UNNORMAL_MANTISSA_TESTS(100);
        end
    `endif

endmodule





//_________________________________________  Interface  ______________________________________________________

interface normalizerInterface(input bit clk);
    logic [47:0] mantisa_mul;
    logic [9:0] exponent_add;
    logic sel, arst, en;
    logic [25:0] mantisa_normalize;
    logic [7:0] exponent_simple;


///////////////////////////  BFM  //////////////////////////

function SET_ARST_TO(input bit state);
    arst = state;
endfunction

function SET_ENABLE_TO(input bit state);
    en = state;
endfunction

function RANDOMIZE_NORMAL_MANTISSA;
    std::randomize(mantisa_mul) with {mantisa_mul[47] == 1;};
endfunction

function RANDOMIZE_UNNORMAL_MANTISSA;
    std::randomize(mantisa_mul) with {mantisa_mul[47] == 0;};
endfunction

task RANDOM_NORMAL_MANTISSA_TESTS(integer TESTS);

    repeat(TESTS) begin
        RANDOMIZE_NORMAL_MANTISSA;
        @(posedge clk);
    end
    
endtask

task RANDOM_UNNORMAL_MANTISSA_TESTS(integer TESTS);

    repeat(TESTS) begin
        RANDOMIZE_UNNORMAL_MANTISSA;
        @(posedge clk);
    end
    
endtask


endinterface

