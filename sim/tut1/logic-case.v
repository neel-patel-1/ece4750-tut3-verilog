module top;
  logic [1:0] sel;
  logic [2:0] lsel;
  logic [7:0] a;

  initial begin

    sel = 2'b01;

    case (sel)
      2'b00 : a = 8'h0a;
      2'b10 : a = 8'h0c;
    endcase

    $display( "sel = %b, a = %x", sel, a );

    sel = 2'bxx;
    case (sel)
      2'b00 : a = 8'h0a;
      2'b01 : a = 8'h0b;
      2'b10 : a = 8'h0c;
      2'b11 : a = 8'h0d;
      default : a = 8'h0e;
    endcase

    $display( "sel = %b, a = %b", sel, a );

    sel = 2'b0x;
    case (sel)
      2'b00 : a = 8'h0a;
      2'b01 : a = 8'h0b;
      2'b10 : a = 8'h0c;
      2'b11 : a = 8'h0d;
      default : a = 8'h0e;
    endcase
    $display( "sel = %b, a = %b", sel, a );

    sel = 2'bx0;
    case (sel)
      2'b00 : a = 8'h0a;
      2'b01 : a = 8'h0b;
      2'b10 : a = 8'h0c;
      2'b11 : a = 8'h0d;
      2'bx0 : a = 8'h0e;
      default : a = 8'h0f;
    endcase

    $display( "sel = %b, a = %b", sel, a );

    lsel = 3'b001;
    case (lsel)
      3'b000 : a = 8'h0a;
      3'b001 : a = 8'h0b;
      3'b010 : a = 8'h0c;
      3'b011 : a = 8'h0d;
      3'b100 : a = 8'h0e;
      3'b101 : a = 8'h0f;
      3'b110 : a = 8'h10;
      3'b111 : a = 8'h11;
    endcase
    $display( "lsel = %b, a = %x", lsel, a );

  end

endmodule

