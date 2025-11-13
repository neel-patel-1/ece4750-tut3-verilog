module top;
  logic [0:3] A;
  logic [0:3] B;
  logic c;

  initial begin
    A = 4'b0111; $display("A=4'b%b", A);
    B = 4'b0110; $display("B=4'b%b", B);
    c = ~(|(A ^ B)); $display( "4'b%b == 4'b%b: %x", A, B, c);
  end

endmodule