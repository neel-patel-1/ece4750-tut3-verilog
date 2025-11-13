module top;
  logic a;
  logic b;
  logic c_in;
  logic c_out;
  logic s;

  initial begin
    a = 1'b0; $display( "1'b0 = %x ", a );
    b = 1'b1; $display( "1'b1 = %x ", b );
    c_in = 1'b0; $display( "1'b0 = %x ", c_in );

    s = a ^ b ^ c_in; $display( "1'b(a^b) = %x ", s );
    c_out = (a & b) | (b & c_in) | (a & c_in); $display( "1'b(a&b) = %x ", c_in );
  end

endmodule