module top;
  logic [3:0] A;
  logic [3:0] B;
  logic c;

  initial begin
    // Exercise: Implementing Equality
    A = 4'b0111; $display("A=4'b%b", A);
    B = 4'b0110; $display("B=4'b%b", B);
    c = ~(|(A ^ B)); $display( "4'b%b == 4'b%b: %x", A, B, c);

    // Shifting intricacies: Logical shift shifts in zero, arithmetic right shift replicates MSB, left-hand operand to arithmetic shift must be "signed"
    B = A << 1; $display( "4'b0111 << 1 = %b", B);
    B = A <<< 1; $display( "4'b0111 <<< 1 = %b", B);
    A = 4'b1100;
    B = A >>> 1; $display( "4'b1100 >>> 1 = %b", B);
    B = $signed(A) >>> 1; $display( "$signed(4'b1100) >>> 1 = %b", B);

  end

endmodule