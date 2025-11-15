//========================================================================
// RegIncr Ad-Hoc Testing
//========================================================================

`include "RegIncr.v"

module top;

  // Clocking

  logic clk = 1;
  always #1 clk = ~clk;

  // Instaniate the design under test

  logic       reset = 1;
  logic [7:0] in_;
  logic [7:0] out;

  // ''' TUTORIAL TASK '''''''''''''''''''''''''''''''''''''''''''''''''''
  // This simulator script is incomplete. As part of the tutorial you
  // will need to instantiate and connect a RegIncr model here.
  // '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  tut3_verilog_regincr_RegIncr reg_incr
  (
    .clk (clk),
    .reset (reset),
    .in_ (in_),
    .out (out)
  );

  // Simulate the registered incrementer

  initial begin

    // Dump waveforms

    $dumpfile("regincr-adhoc-test.vcd");
    $dumpvars;

    // Reset
    // reset = 1'b0;
    // Cycle 1
    in_ = 8'h01;

    // shows variables at the end of a simtick
    $display(" t=%0t, clk=%x, reset=%x, in_=%x,  out=%x", $time, clk, reset, in_, out );
    #1;

    $display(" t=%0t, clk=%x, reset=%x, in_=%x,  out=%x", $time, clk, reset, in_, out );
    #1;

    $display(" t=%0t, clk=%x, reset=%x, in_=%x,  out=%x", $time, clk, reset, in_, out );
    #1;

    $display(" posedge, now out is 1");
    $display(" t=%0t, clk=%x, reset=%x, in_=%x,  out=%x", $time, clk, reset, in_, out );

    $display(" changing reset to enable further incremenents and in_ to 5");
    in_ = 8'h05;
    reset = 1'b0;

    $display(" t=%0t, clk=%x, reset=%x, in_=%x,  out=%x", $time, clk, reset, in_, out );

    $display(" advancing to after next posedge");
    #1;

    $display(" t=%0t, clk=%x, reset=%x, in_=%x,  out=%x", $time, clk, reset, in_, out );
    #1;

    $display(" t=%0t, clk=%x, reset=%x, in_=%x,  out=%x", $time, clk, reset, in_, out );


    // now  out is 1, time is 4, clk is going to be 1
    // unset reset so that increment will work


    $finish;
  end

endmodule

