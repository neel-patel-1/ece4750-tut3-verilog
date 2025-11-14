module top;
  logic [3:0] a;
  logic [7:0] b;
  logic [7:0] c;

  initial begin

    a = 4'b0100;

    casez ( a )

      4'b0000 : b = 8'd0;
      4'b???1 : b = 8'd1;
      4'b??10 : b = 8'd2;
      4'b?100 : b = 8'd3;
      4'b1000 : b = 8'd4;

      default : b = 8'hxx;
    endcase

    $display( "a = 4'b0100, b = %x", b );

    a = 4'b01xx;

    casez ( a )

      4'b0000 : b = 8'd0;
      4'b???1 : b = 8'd1;
      4'b??10 : b = 8'd2;
      4'b?100 : b = 8'd3;
      4'b1000 : b = 8'd4;

      default : b = 8'hxx;
    endcase

    $display( "a = 4'b01xx, b = %x", b );

    c = 8'b01001000;

    casez(c)
      8'b00000000 : b = 8'd0;
      8'b???????1 : b = 8'd1;
      8'b??????10 : b = 8'd2;
      8'b?????100 : b = 8'd3;
      8'b????1000 : b = 8'd8;
      8'b???10000 : b = 8'd5;
      8'b??100000 : b = 8'd6;
      8'b?1000000 : b = 8'd7;
      8'b10000000 : b = 8'd8;
      default : b = 8'hxx;
    endcase

    $display( "c = 8'b01001001, b = %x", b );

  end

endmodule


