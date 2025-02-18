


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
    



//////////////////////////////////////////// BFM //////////////////////////////////////////////

  function automatic set_arst_to(input int value);
  arst = value;
  endfunction
  
  function automatic randomize_arst();
  std::randomize(arst);
  endfunction

  function automatic randomize_normal_a();
    bit [31:0] temp;
    std::randomize(temp);
    a = {1'b0, temp[30:23] != 8'hFF ? temp[30:23] : 8'hFE, temp[22:0]};
  endfunction

  function automatic randomize_normal_b();
    bit [31:0] temp;
    std::randomize(temp);
    b = {1'b0, temp[30:23] != 8'hFF ? temp[30:23] : 8'hFE, temp[22:0]};
  endfunction
  
  function automatic randomize_normal_ab_greater_a();
    bit [31:0] temp_a, temp_b;
    real real_a, real_b;
    do begin
      std::randomize(temp_a);
      std::randomize(temp_b);
      a = {1'b0, temp_a[30:23] != 8'hFF ? temp_a[30:23] : 8'hFE, temp_a[22:0]};
      b = {1'b0, temp_b[30:23] != 8'hFF ? temp_b[30:23] : 8'hFE, temp_b[22:0]};
      real_a = $bitstoreal(a);
      real_b = $bitstoreal(b);
    end while (real_a > real_b);
  endfunction

  function automatic randomize_normal_ab_greater_b();
    bit [31:0] temp_a, temp_b;
    real real_a, real_b;
    do begin
      std::randomize(temp_a);
      std::randomize(temp_b);
      a = {1'b0, temp_a[30:23] != 8'hFF ? temp_a[30:23] : 8'hFE, temp_a[22:0]};
      b = {1'b0, temp_b[30:23] != 8'hFF ? temp_b[30:23] : 8'hFE, temp_b[22:0]};
      real_a = $bitstoreal(a);
      real_b = $bitstoreal(b);
    end while (real_b > real_a);
  endfunction
  
  function automatic void set_a_to(input int value);
    real r; 
    r = $itor(value);
    $cast(a, r);
  endfunction

  function automatic void set_b_to(input int value);
    real r; 
    r = $itor(value);
    $cast(b, r);
  endfunction

  function automatic sel_random();
  std::randomize(sel);
  endfunction
  
  function automatic sel_value(input int value);
  sel = value;
  endfunction
  
  function automatic enable_value(input int value);
  en = value;
  endfunction
  
  
////////////////////////////////////////////// TASKS FOR TESTS //////////////////////////////////////////////
  
  
  task automatic test_full_random(input int value);
    repeat (value)@(posedge clk)begin
    a_random();
    b_random();
    end
  endtask
  
  task automatic test_a_greater_than_b(input int value);
    repeat (value)@(posedge clk)begin
    a_greater_b_random();
    end
  endtask
  
  task automatic test_b_greater_than_a(input int value);
    repeat (value)@(posedge clk)begin
    b_greater_a_random();
    end
  endtask
  
endinterface