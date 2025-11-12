module top;
  logic a;
  logic b;
  logic c;

  initial begin
    a = 1'b0; $display( "1'b0 = %x ", a );
    a = 1'b1; $display( "1'b1 = %x ", a );
  end

endmodule