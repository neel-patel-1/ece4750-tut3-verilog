#=========================================================================
# GCD Unit RTL Model
#=========================================================================

from pymtl3 import *
from pymtl3.passes.backends.verilog import *

#=========================================================================
# GCD Unit RTL Model
#=========================================================================

class GcdUnitCtrl( VerilogPlaceholder, Component ):
  def construct( s ):
    s.istream_val = InPort(1)
    s.istream_rdy = OutPort(1)
    s.ostream_val = OutPort(1)
    s.ostream_rdy = InPort(1)

    s.is_b_zero = InPort(1)
    s.a_lt_b = InPort(1)

    s.a_reg_en = OutPort(1)
    s.b_reg_en = OutPort(1)
    s.a_mux_sel = OutPort(1)
    s.b_mux_sel = OutPort(1)
    s.swap_mux_sel = OutPort(1)


