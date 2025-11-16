#=========================================================================
# Regincr3stage_test
#=========================================================================

from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim
from ..RegIncr3stage import RegIncr3stage

#-------------------------------------------------------------------------
# test_small
#-------------------------------------------------------------------------

def test_small( cmdline_opts ):
  run_test_vector_sim( RegIncr3stage(), [
    ('in_   out*'),
    [ 0x00, '?'  ],
    [ 0x03, '?'  ],
    [ 0x06, '?'  ],
    [ 0x09, 0x03 ],
    [ 0x00, 0x06 ],
    [ 0x00, 0x09 ],
    [ 0x00, 0x0c ],
  ], cmdline_opts )