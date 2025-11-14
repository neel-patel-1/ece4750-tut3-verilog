module top;
  logic [1:0] sel;
  logic [7:0] a;

  initial begin

    sel = 2'b01;

    case (sel)
      2'b00 : a = 8'h0a;
      2'b10 : a = 8'h0c;
    endcase

    $display( "sel = %b, a = %x", sel, a );

  end

endmodule

