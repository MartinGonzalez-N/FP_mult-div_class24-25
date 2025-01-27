//////////////////////////////////////////////////////////////////////////////////


module Exponent_Logic_tb;

Exponent_Logic_inf Exponent_Logic_inf_i();

    //bit clk;
    
Exponent_Logic DUT(
 
    .eA(Exponent_Logic_inf_i.eA), 
    .eB(Exponent_Logic_inf_i.eB),
    .clk(Exponent_Logic_inf_i.clk), 
    .arst(Exponent_Logic_inf_i.arst), 
    .en(Exponent_Logic_inf_i.en), 
    .sel(Exponent_Logic_inf_i.sel),
    .e(Exponent_Logic_inf_i.e) 
);

    always #1 Exponent_Logic_inf_i.clk = ~Exponent_Logic_inf_i.clk;    

    `define TEST1

    `ifdef TEST1
        // Prueba 1 - 
        //////////////////////////////////////////////
        // 1. Generar entradas aleatorias con       //
        // en 1 y sel 0                             //
        //////////////////////////////////////////////
        initial begin
            repeat(500) begin
                @(posedge Exponent_Logic_inf_i.clk); 
                Exponent_Logic_inf_i.radmon_inputs_enabled_sel_0(); 
                $display("e_a: %0d", Exponent_Logic_inf_i.eA);
                $display("e_b: %0d", Exponent_Logic_inf_i.eB); 
                $display("Result: %0d", Exponent_Logic_inf_i.e);            
            end
                #2 $finish;   
        end
        
    `endif
endmodule

interface Exponent_Logic_inf ();

    logic [7:0] eA, eB;
    logic clk, arst, en, sel;
    logic [9:0] e;
    bit clk;

    //always #1 clk = ~clk; 
       
    initial begin
    eA = 0;
    eB = 0;
    clk = 0;
    e = 0;
    en = 0;
    sel = 0;
    end
    
    function radmon_inputs_enabled_sel_0();
        en=1;
        sel=0;
        std::randomize(eA);
        std::randomize(eB);    
    endfunction
endinterface: Exponent_Logic_inf