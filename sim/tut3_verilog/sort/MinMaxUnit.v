//========================================================================
// MinMaxUnit
//========================================================================
// This module takes two inputs, compares them, and outputs the larger
// via the "max" output port and the smaller via the "min" output port.

`ifndef TUT3_VERILOG_SORT_MIN_MAX_UNIT_V
`define TUT3_VERILOG_SORT_MIN_MAX_UNIT_V

`include "vc/trace.v"
`include "vc/regs.v"

module tut3_verilog_sort_MinMaxUnit
#(
  parameter p_nbits = 1
)(
  input  logic [p_nbits-1:0] in0,
  input  logic [p_nbits-1:0] in1,
  output logic [p_nbits-1:0] out_min,
  output logic [p_nbits-1:0] out_max
);
  always_comb begin
    if (in0 <= in1) begin
      out_min = in0;
      out_max = in1;
    end
    else begin
      out_min = in1;
      out_max = in0;
    end
  end

  `ifndef SYNTHESIS
  logic [`VC_TRACE_NBITS-1:0] str;
  `VC_TRACE_BEGIN
  begin
    $sformat( str, "in0=%x,in1=%x,min=%x,max=%x", in0, in1, out_min, out_max );
  end
  `VC_TRACE_END
  `endif /* SYNTHESIS */

endmodule

`endif /* TUT3_VERILOG_SORT_MIN_MAX_UNIT_V */

