typedef enum logic [$clog2(4)-1:0] {
  STATE_IDLE,
  STATE_CALC,
  STATE_DONE
} state_t;

module top;
  // Declare variables

  state_t state;
  logic result;

  initial begin
    state = STATE_IDLE; $display("STATE_IDLE = %d", state);
    state = STATE_CALC; $display("STATE_CALC = %d", state);
    state = STATE_DONE; $display("STATE_DONE = %d", state);

    // result = (state == STATE_C); $display("state == STATE_C: result=%b", result);
    result = (state == STATE_CALC); $display("state == STATE_CALC: result=%b", result);
  end


endmodule