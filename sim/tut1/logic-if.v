module top;
  logic [7:0] a;
  logic [7:0] b;
  logic  sel;

  initial begin

    a = 8'd30;
    b = 8'd16;
    sel = 1'bx;

    if (sel == 1'b0) begin
      a = 8'h0a;
    end
    else begin
      a = 8'h0b;
    end

    $display( "sel = %b, a = %x", sel, a );

  end

endmodule
