module exponent_Logic_tb;

exponent_Logic_inf exponent_Logic_inf_i();

    //bit clk;
    
Exponent_Logic DUT(
 
    .eA(exponent_Logic_inf_i.eA), 
    .eB(exponent_Logic_inf_i.eB),
    .clk(exponent_Logic_inf_i.clk), 
    .arst(exponent_Logic_inf_i.arst), 
    .en(exponent_Logic_inf_i.en), 
    .sel(exponent_Logic_inf_i.sel),
    .e(exponent_Logic_inf_i.e) 
);

    always #1 exponent_Logic_inf_i.clk = ~exponent_Logic_inf_i.clk;    

    //`define TEST1
    `define TEST2    
    //`define TEST3
    //`define TEST2

    `ifdef TEST1
        // Prueba 1 - 
        //////////////////////////////////////////////
        // 1. Generar entradas aleatorias con       //
        // en 1 y sel 0; en = 1, sel = 1            //
        //////////////////////////////////////////////
        initial begin
            repeat(500) begin
                @(posedge exponent_Logic_inf_i.clk); 
                exponent_Logic_inf_i.radmon_inputs_enabled_sel_0();          
            end
            repeat(500) begin
                @(posedge exponent_Logic_inf_i.clk); 
                exponent_Logic_inf_i.radmon_inputs_enabled_sel_1();          
            end
                #2 $finish;   
        end
        
    `endif
      `ifdef TEST2
        // Prueba 1 - 
        //////////////////////////////////////////////
        // 1. Generar entradas aleatorias           //
        // e incorpora un resteo                    //
        //////////////////////////////////////////////
        initial begin
            repeat(200) begin
                @(posedge exponent_Logic_inf_i.clk); 
                exponent_Logic_inf_i.radmon_inputs();          
            end
            exponent_Logic_inf_i.arst = 1;
            #5 exponent_Logic_inf_i.arst = 0;
            repeat(100) begin
                @(posedge exponent_Logic_inf_i.clk); 
                exponent_Logic_inf_i.radmon_inputs();          
            end
            exponent_Logic_inf_i.arst = 1;
            #3 exponent_Logic_inf_i.arst = 0;            
            repeat(200) begin
                @(posedge exponent_Logic_inf_i.clk); 
                exponent_Logic_inf_i.radmon_inputs();          
            end            
                #2 $finish;   
        end
        
    `endif  
    
    
endmodule

interface exponent_Logic_inf ();

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
 
     function radmon_inputs_enabled_sel_1();
        en=1;
        sel=1;
        std::randomize(eA);
        std::randomize(eB);    
    endfunction
       
    function radmon_inputs();
        std::randomize(en);
        std::randomize(sel);
        std::randomize(eA);
        std::randomize(eB);    
    endfunction
    
endinterface: exponent_Logic_inf
