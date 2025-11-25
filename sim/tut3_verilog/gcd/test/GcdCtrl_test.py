#=========================================================================
# GcdUnitFL_test
#=========================================================================

import pytest
import random

from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim

from tut3_verilog.gcd.GcdUnitCtrl import GcdUnitCtrl

# To ensure reproducible testing

random.seed(0xdeadbeef)

#-------------------------------------------------------------------------
# TestHarness
#-------------------------------------------------------------------------

class TestHarness( Component ):

  def construct( s, gcdctrl ):

    # Instantiate models
    s.src.ostream_val = OutPort(1)
    s.src.ostream_rdy = InPort(1)

    s.sink.istream_val = InPort(1)
    s.sink.istream_rdy = OutPort(1)

    s.sink.a_reg_en = InPort(1)
    s.sink.b_reg_en = InPort(1)
    s.sink.a_mux_sel = InPort(1)
    s.sink.b_mux_sel = InPort(1)
    s.sink.swap_mux_sel = InPort(1)

    s.src.is_b_zero = InPort(1)
    s.src.a_lt_b = InPort(1)

    s.gcdctrl  = gcdctrl

    # Connect
    s.src.ostream_val //= s.gcd.istream_val
    s.gcd.ostream_rdy //= s.sink.istream_rdy
    s.gcd.ostream_val //= s.sink.istream_val
    s.src.ostream_rdy //= s.gcd.istream_rdy

def test_swap( cmdline_opts ):
  run_test_vector_sim( GcdUnitCtrl(), [
    # istream_val istream_rdy ostream_val ostream_rdy is_b_zero a_lt_b | a_reg_en b_reg_en a_mux_sel b_mux_sel swap_mux_sel
    [     0,        '?',        0,        0,        0,      0  |    0,      0,      0,      0,      0 ],
    [     0,        '?',        0,        0,        0,      0  |    0,      0,      0,      0,      0 ],
  ])