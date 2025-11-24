#=========================================================================
# GcdUnitFL_test
#=========================================================================

import pytest
import random

from pymtl3 import *
from pymtl3.stdlib.test_utils import mk_test_case_table, run_sim
from pymtl3.stdlib.stream import StreamSourceFL, StreamSinkFL

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

    s.gcdctrl  = gcdctrl

    # Connect
    s.src.ostream_val //= s.gcd.istream_val
    s.gcd.ostream_rdy //= s.sink.istream_rdy
    s.gcd.ostream_val //= s.sink.istream_val
    s.src.ostream_rdy //= s.gcd.istream_rdy
