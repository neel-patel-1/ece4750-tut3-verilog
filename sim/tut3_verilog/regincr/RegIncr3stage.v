//========================================================================
// RegIncr3stage
//========================================================================

`ifndef TUT3_VERILOG_REGINCR_REG_INCR_3STAGE_V
`define TUT3_VERILOG_REGINCR_REG_INCR_3STAGE_V

`include "tut3_verilog/regincr/RegIncr.v"
`include "tut3_verilog/regincr/RegIncr2stage.v"

module tut3_verilog_regincr_RegIncr3stage
(
  input  logic       clk,
  input  logic       reset,
  input  logic [7:0] in_,
  output logic [7:0] out
);

  // First stage

  logic [7:0] reg_incr_0_out;

  tut3_verilog_regincr_RegIncr2stage reg_incr_0
  (
    .clk    (clk),
    .reset  (reset),
    .in_    (in_),
    .out    (reg_incr_0_out)
  );

  tut3_verilog_regincr_RegIncr reg_incr_1
  (
    .clk (clk),
    .reset (reset),
    .in_ (reg_incr_0_out),
    .out (out)
  );

  `ifndef SYNTHESIS

  logic [`VC_TRACE_NBITS-1:0] str;
  `VC_TRACE_BEGIN
  begin
    $sformat( str, "in1:%x out1:%x in2:%x out2:%x ", in_, reg_incr_0_out, reg_incr_0_out, out );
    vc_trace.append_str( trace_str, str );
  end
  `VC_TRACE_END

  `endif /* SYNTHESIS */

endmodule

`endif /* TUT3_VERILOG_REGINCR_REG_INCR_3STAGE_V */

