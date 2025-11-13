module top;
  logic [8:0] A;
  logic [8:0] B;
  logic [8:0] C;

  initial begin
    A = 9'd200;
    B = 9'd400;
    C = A + B; $display( "9'd200 + 9'd400 = %d", C );
    C = C + B; $display( "(9'd200 + 9'd400) + 9'd200 = %d", C );
    C = C - B; $display( "((9'd200 + 9'd400) + 9'd200) - 9'd400 = %d", C );
    C = C - B; $display( "(((9'd200 + 9'd400) + 9'd200) - 9'd400) - 9'd400 = %d", C );
  end

endmodule