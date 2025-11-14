module top;
  logic [3:0] A;
  logic [3:0] B;
  logic [7:0] C;
  logic [15:0] D;

  initial begin
    A = 4'ha; $display("A=4'b%b", A);
    B = 4'hb; $display("B=4'b%b", B);
    C = {A, B}; $display("{ 8'hf0, 4'ha } = %x", C);
    D = {B, {3{A}}}; $display("{ B, 3{A} } = %x", D);


  end

endmodule