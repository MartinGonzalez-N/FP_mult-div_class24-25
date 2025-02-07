module mul_tb;
    
    bit clk;
    mul_div_if #() i_f(clk);
    
    mul_div #() DUT (
        .clk(i_f.clk), 
        .arst(i_f.arst),          
        .a(i_f.a),  
        .b(i_f.b),
        .sel(i_f.sel),
        .en(i_f.en),
        .R(i_f.R),
        .io_flag(i_f.io_flag), 
        .dz_flag(i_f.dz_flag), 
        .of_flag(i_f.of_flag), 
        .uf_flag(i_f.uf_flag),
        .i_flag(i_f.i_flag)
    );

    initial begin
        $shm_open("shm_db");
        $shm_probe("ASMTR");
    end

    always #10 clk = ~clk;
    
    /* always @(posedge clk) begin
    
    end */
    
    initial begin
    i_f.test_full_random();
    $finish;
    end

endmodule

interface mul_div_if (input logic clk);
    logic [31:0] a, b;
    logic arst, en, sel;
    logic [31:0] R;
    logic io_flag, dz_flag, of_flag, uf_flag, i_flag;
    
    initial begin
        sel = '0;
        a = '0;
        b = '0;
        en = '1;
        arst = 0;
    end
    
  function automatic reset(input logic value);
  arst = value;
  endfunction
  
  function automatic reset_random();
  std::randomize(arst);
  endfunction

  function automatic a_random();
  std::randomize(a);
  endfunction
  
  function automatic a_greater_b_random();
  std::randomize(a, b) with{a >= b;};
  endfunction
  
  function automatic b_random();
  std::randomize(b);
  endfunction 
  
  function automatic b_greater_a_random();
  std::randomize(a, b) with{b >= a;};
  endfunction
  
  function automatic sel_random();
  std::randomize(sel);
  endfunction
  
  function automatic sel_value(input logic value);
  sel = value;
  endfunction
  
  function automatic enable_value(input logic value);
  en = value;
  endfunction
  
  
  //------------------------------- BFM for testing--------------------------------------------
  
  
  task automatic test_full_random();
    repeat (200)@(posedge clk)begin
    a_random();
    b_random();
    end
  endtask
  
  task automatic test_a_greater_than_b();
    repeat (100)@(posedge clk)begin
    a_greater_b_random();
    end
  endtask
  
  task automatic test_b_greater_than_a();
    repeat (100)@(posedge clk)begin
    b_greater_a_random();
    end
  endtask
  
endinterface
