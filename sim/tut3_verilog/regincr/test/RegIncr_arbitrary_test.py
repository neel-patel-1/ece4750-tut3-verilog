#=========================================================================
# RegIncr_test
#=========================================================================

from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim
from ..RegIncr import RegIncr

#-------------------------------------------------------------------------
# test_small
#-------------------------------------------------------------------------

def test_directed( cmdline_opts ):
  run_test_vector_sim( RegIncr(), [
    ('in_   out*'),
    [ 0x07, '?'  ],
    [ 0x11, 0x08 ],
    [ 0xde, 0x12 ],
    [ 0xad, 0xdf ],
  ], cmdline_opts )
