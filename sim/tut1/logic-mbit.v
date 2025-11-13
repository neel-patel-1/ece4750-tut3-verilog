module top;
  logic a, b, c, d;

  initial begin
    a = 4'b0000; $display( "4'b0000 = %x ", a );
    a = 4'b1111; $display( "4'b1111 = %x ", a );
  end
endmodule