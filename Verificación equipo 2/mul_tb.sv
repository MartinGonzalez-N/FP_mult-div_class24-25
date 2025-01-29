module mul_tb #(
    );
    
    bit clk;
    mul_div_if #() I_F(clk);
    
    mul_div #() DUT (
        .clk(I_F.clk), 
        .arst(I_F.arst),          
        .A(I_F.A),  
        .B(I_F.B),
        .sel(I_F.sel),
        .en(I_F.enable),
        .R(I_F.R),
        .IO(I_F.IO), .DZ(I_F.DZ), .OF(I_F.OF), .UF(I_F.UF),
        .I(I_F.I)
    );

    always #10 clk = ~clk;
    
    always @(posedge clk) begin
    
    end
    
    initial begin
    I_F.test_full_random();
    end

endmodule

interface mul_div_if (input logic clk);
    logic [31:0] A, B;
    logic arst, enable, sel;
    logic [31:0] R;
    logic IO, DZ, OF, UF, I;
    
    initial begin
        sel = '0;
        A = '0;
        B = '0;
        enable = '1;
        arst = 0;
    end
    
  function automatic reset(input logic value);
  arst = value;
  endfunction
  
  function automatic reset_random();
  std::randomize(arst);
  endfunction

  function automatic a_random();
  std::randomize(A);
  endfunction
  
  function automatic a_greater_b_random();
  std::randomize(A, B) with{A >= B;};
  endfunction
  
  function automatic b_random();
  std::randomize(B);
  endfunction
  
  function automatic b_greater_a_random();
  std::randomize(A, B) with{B >= A;};
  endfunction
  
  function automatic sel_random();
  std::randomize(sel);
  endfunction
  
  function automatic sel_value(input logic value);
  sel = value;
  endfunction
  
  function automatic enable_value(input logic value);
  enable = value;
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
