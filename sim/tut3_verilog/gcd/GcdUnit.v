//========================================================================
// GCD Unit RTL Implementation
//========================================================================

`ifndef TUT3_VERILOG_GCD_GCD_UNIT_V
`define TUT3_VERILOG_GCD_GCD_UNIT_V

`include "vc/muxes.v"
`include "vc/regs.v"
`include "vc/arithmetic.v"
`include "vc/trace.v"

//========================================================================
// GCD Unit Datapath
//========================================================================

module tut3_verilog_gcd_GcdUnitDpath
(
  input  logic        clk,
  input  logic        reset,

  // Data signals

  input  logic [31:0] istream_msg,
  output logic [15:0] ostream_msg,

  // Control signals

  input  logic        a_reg_en,   // Enable for A register
  input  logic        b_reg_en,   // Enable for B register
  input  logic        a_mux_sel,  // Sel for mux in front of A reg
  input  logic        b_mux_sel,  // sel for mux in front of B reg
  input  logic        swap_mux_sel,

  // Status signals

  output logic        is_b_zero,  // Output of zero comparator
  output logic        is_a_lt_b   // Output of less-than comparator
);

  localparam c_nbits = 16;

  // Split out the a and b operands

  logic [c_nbits-1:0] istream_msg_a;
  assign istream_msg_a = istream_msg[31:16];

  logic [c_nbits-1:0] istream_msg_b;
  assign istream_msg_b = istream_msg[15:0];

  // A Mux

  logic [c_nbits-1:0] out_mux_out;

  logic [c_nbits-1:0] sub_out;
  logic [c_nbits-1:0] a_mux_out;

  vc_Mux2#(c_nbits) a_mux
  (
    .sel   (a_mux_sel),
    .in0   (istream_msg_a),
    .in1   (out_mux_out),
    .out   (a_mux_out)
  );

  // A register

  logic [c_nbits-1:0] a_reg_out;

  vc_EnReg#(c_nbits) a_reg
  (
    .clk   (clk),
    .reset (reset),
    .en    (a_reg_en),
    .d     (a_mux_out),
    .q     (a_reg_out)
  );

  // B Mux

  logic [c_nbits-1:0] b_mux_out;

  vc_Mux2#(c_nbits) b_mux
  (
    .sel   (b_mux_sel),
    .in0   (istream_msg_b),
    .in1   (b_swap_mux_out),
    .out   (b_mux_out)
  );

  // B register

  logic [c_nbits-1:0] b_reg_out;

  vc_EnReg#(c_nbits) b_reg
  (
    .clk   (clk),
    .reset (reset),
    .en    (b_reg_en),
    .d     (b_mux_out),
    .q     (b_reg_out)
  );

  // Less-than comparator

  vc_LtComparator#(c_nbits) a_lt_b
  (
    .in0   (a_reg_out),
    .in1   (b_reg_out),
    .out   (is_a_lt_b)
  );

  // B Swap Mux

  logic [c_nbits-1:0] b_swap_mux_out;

  vc_Mux2#(c_nbits) b_swap_mux
  (
    .sel   (swap_mux_sel),
    .in0   (b_reg_out),
    .in1   (a_reg_out),
    .out   (b_swap_mux_out)
  );


  // A Swap Mux

  logic [c_nbits-1:0] a_swap_mux_out;

  vc_Mux2#(c_nbits) a_swap_mux
  (
    .sel   (swap_mux_sel),
    .in0   (a_reg_out),
    .in1   (b_reg_out),
    .out   (a_swap_mux_out)
  );

  // B Zero comparator

  vc_ZeroComparator#(c_nbits) b_zero
  (
    .in    (b_reg_out),
    .out   (is_b_zero)
  );

  // Subtractor

  vc_Subtractor#(c_nbits) sub
  (
    .in0   (a_swap_mux_out),
    .in1   (b_swap_mux_out),
    .out   (sub_out)
  );

  // Connect to output port

  assign ostream_msg = a_swap_mux_out;

endmodule

//========================================================================
// GCD Unit Control
//========================================================================

module tut3_verilog_gcd_GcdUnitCtrl
(
  input  logic        clk,
  input  logic        reset,

  // Dataflow signals

  input  logic        istream_val,
  output logic        istream_rdy,
  output logic        ostream_val,
  input  logic        ostream_rdy,

  // Control signals

  output logic        a_reg_en,   // Enable for A register
  output logic        b_reg_en,   // Enable for B register
  output logic        a_mux_sel,  // Sel for mux in front of A reg
  output logic        b_mux_sel,  // sel for mux in front of B reg
  output logic        swap_mux_sel,

  // Data signals

  input  logic        is_b_zero,  // Output of zero comparator
  input  logic        is_a_lt_b   // Output of less-than comparator
);

  //----------------------------------------------------------------------
  // State Definitions
  //----------------------------------------------------------------------

  localparam STATE_IDLE = 2'd0;
  localparam STATE_CALC = 2'd1;

  //----------------------------------------------------------------------
  // State
  //----------------------------------------------------------------------

  logic [1:0] state_reg;
  logic [1:0] state_next;

  always_ff @( posedge clk ) begin
    if ( reset ) begin
      state_reg <= STATE_IDLE;
    end
    else begin
      state_reg <= STATE_CALC;
    end
  end

  //----------------------------------------------------------------------
  // State Transitions
  //----------------------------------------------------------------------

  logic req_go;
  logic resp_go;
  logic is_calc_done;
  logic done_and_next;

  assign req_go       = istream_val && istream_rdy;
  assign resp_go      = ostream_val && ostream_rdy;
  assign is_calc_done = is_b_zero && ostream_rdy;
  assign done_and_next = is_calc_done && istream_val;

  always_comb begin

    state_next = state_reg;

    case ( state_reg )

      STATE_IDLE: if ( req_go    )    state_next = STATE_CALC;
      STATE_CALC: if ( done_and_next ) state_next = STATE_CALC;
      else if ( is_calc_done ) state_next = STATE_IDLE;
      default:    state_next = 'x;

    endcase

  end

  //----------------------------------------------------------------------
  // State Outputs
  //----------------------------------------------------------------------

  localparam a_x   = 2'dx;
  localparam a_ld  = 2'd0;
  localparam a_sub = 2'd2;

  localparam b_x   = 1'dx;
  localparam b_ld  = 1'd0;
  localparam b_reg   = 1'd1;

  localparam swap_x   = 1'dx;
  localparam swap_0   = 1'd0;
  localparam swap_1   = 1'd1;

  function void cs
  (
    input logic       cs_istream_rdy,
    input logic       cs_ostream_val,
    input logic       cs_a_mux_sel,
    input logic       cs_a_reg_en,
    input logic       cs_b_mux_sel,
    input logic       cs_b_reg_en,
    input logic       cs_swap_mux_sel,
  );
  begin
    istream_rdy = cs_istream_rdy;
    ostream_val = cs_ostream_val;
    a_reg_en    = cs_a_reg_en;
    b_reg_en    = cs_b_reg_en;
    a_mux_sel   = cs_a_mux_sel;
    b_mux_sel   = cs_b_mux_sel;
    swap_mux_sel = cs_swap_mux_sel;
  end
  endfunction

  // Labels for Mealy transistions

  logic do_swap;
  logic do_sub;
  logic calc_done;
  logic next_ready;

  assign do_swap = is_a_lt_b;
  assign do_sub  = !is_b_zero;
  assign calc_done = is_b_zero;
  assign next_ready = istream_val;

  // Set outputs using a control signal "table"

  always_comb begin

    cs( 0, 0, a_x, 0, b_x, 0, 1);
    case ( state_reg )
      // istream ostream a_mux a_reg b_mux b_reg swap
      STATE_IDLE:                cs( 1,   0,   a_ld,  1, b_ld, 1, swap_x );
      STATE_CALC:
        if (calc_done) begin
          cs( next_ready,   calc_done,   a_ld,  1, b_ld,  1, swap_x);
        end
        else begin
          cs( next_ready,   calc_done,   a_sub, 1, b_reg, 1, do_swap);
        end
      default                    cs('x,  'x,   a_x,  'x, b_x, 'x, swap_x );

    endcase

  end

endmodule

//========================================================================
// GCD Unit
//========================================================================

module tut3_verilog_gcd_GcdUnit
(
  input  logic        clk,
  input  logic        reset,

  input  logic        istream_val,
  output logic        istream_rdy,
  input  logic [31:0] istream_msg,

  output logic        ostream_val,
  input  logic        ostream_rdy,
  output logic [15:0] ostream_msg
);

  //----------------------------------------------------------------------
  // Connect Control Unit and Datapath
  //----------------------------------------------------------------------

  // Control signals

  logic        a_reg_en;
  logic        b_reg_en;
  logic        a_mux_sel;
  logic        b_mux_sel;
  logic        swap_mux_sel;

  // Data signals

  logic        is_b_zero;
  logic        is_a_lt_b;

  // Control unit

  tut3_verilog_gcd_GcdUnitCtrl ctrl
  (
    .*
  );

  // Datapath

  tut3_verilog_gcd_GcdUnitDpath dpath
  (
    .*
  );

  //----------------------------------------------------------------------
  // Line Tracing
  //----------------------------------------------------------------------

  `ifndef SYNTHESIS

  logic [`VC_TRACE_NBITS-1:0] str;
  `VC_TRACE_BEGIN
  begin

    $sformat( str, "%x:%x", istream_msg[31:16], istream_msg[15:0] );
    vc_trace.append_val_rdy_str( trace_str, istream_val, istream_rdy, str );

    vc_trace.append_str( trace_str, "(" );

    $sformat( str, "%x", dpath.a_reg_out );
    vc_trace.append_str( trace_str, str );
    vc_trace.append_str( trace_str, " " );

    $sformat( str, "%x", dpath.b_reg_out );
    vc_trace.append_str( trace_str, str );
    vc_trace.append_str( trace_str, " " );

    case ( ctrl.state_reg )

      ctrl.STATE_IDLE:
        vc_trace.append_str( trace_str, "I " );

      ctrl.STATE_CALC:
      begin
        if ( ctrl.do_swap )
          vc_trace.append_str( trace_str, "Cs" );
        else if ( ctrl.do_sub )
          vc_trace.append_str( trace_str, "C-" );
        else
          vc_trace.append_str( trace_str, "C " );
      end

      default:
        vc_trace.append_str( trace_str, "? " );

    endcase

    vc_trace.append_str( trace_str, ")" );

    $sformat( str, "%x", ostream_msg );
    vc_trace.append_val_rdy_str( trace_str, ostream_val, ostream_rdy, str );

  end
  `VC_TRACE_END

  `endif /* SYNTHESIS */

endmodule

`endif /* TUT3_VERILOG_GCD_GCD_UNIT_V */

