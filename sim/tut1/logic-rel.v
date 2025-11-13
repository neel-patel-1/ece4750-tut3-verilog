module top;
  logic [3:0] A;
  logic [3:0] B;
  logic c;

  initial begin
    A = 4'b011X; $display("A=4'b%b", A);
    B = 4'b0010; $display("B=4'b%b", B);
    c = A <= B; $display("A <= B: c=%b", c);


  end

endmodule