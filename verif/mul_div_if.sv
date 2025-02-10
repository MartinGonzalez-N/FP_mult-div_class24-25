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