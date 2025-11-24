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


