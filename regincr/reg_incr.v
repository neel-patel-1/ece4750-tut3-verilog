`ifndef ECE4750_TUT3_VERILOG_REGINCR_REG_INCR_V
`define ECE4750_TUT3_VERILOG_REGINCR_REG_INCR_V

module ece4750_tut3_verilog_regincr_Reg_Incr
(
  input logic clk,
  input logic reset,
  input logic [7:0] in_,
  output logic [7:0] out
);

  logic [7:0] reg_out;
  always_ff @( posedge clk ) begin
    if ( reset )
      reg_out <= '0; // all bits zero
    else
      reg_out <= in_;
  end

  logic [7:0] temp_wire;
  always_comb begin
    temp_wire = reg_out + 1;
  end

  assign out = temp_wire;

endmodule

`endif // ECE4750_TUT3_VERILOG_REGINCR_REG_INCR_V