#=========================================================================
# SortReverseUnitFlat_test
#=========================================================================

import pytest

from random import randint

from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim

from .SortUnitFL_test import header_str,  x, \
                             tvec_stream, tvec_dups, tvec_sorted, tvec_random

from ..SortReverseUnitFlat import SortReverseUnitFlat

def mk_test_vector_table( nstages, inputs ):

  # Add initial invalid outputs to the list of output values

  outputs_val = [[0,x,x,x,x]]*nstages

  # Sort inputs and prepend valid bit to each list of inputs/outputs

  inputs_val  = []
  for input_ in inputs:
    inputs_val.append( [1] + input_ )
    outputs_val.append( [1] + deepcopy( sorted(input_, reverse=True) ) )

  # Add final invalid inputs to the list of input values

  inputs_val.extend( [[0,0,0,0,0]]*nstages )

  # Put inputs_val and outputs_val together to make test_vector_table

  test_vector_table = [ header_str ]
  for input_,output in zip( inputs_val, outputs_val ):
    test_vector_table.append( input_ + output )

  return test_vector_table

#-------------------------------------------------------------------------
# test_basic
#-------------------------------------------------------------------------

def test_basic( cmdline_opts ):
  run_test_vector_sim( SortReverseUnitFlat(), [ header_str,
    # in  in  in  in  in  out out out out out
    # val [0] [1] [2] [3] val [0] [1] [2] [3]
    [ 0,  0,  0,  0,  0,  0,  x,  x,  x,  x ],
    [ 1,  4,  2,  3,  1,  0,  x,  x,  x,  x ],
    [ 0,  0,  0,  0,  0,  0,  x,  x,  x,  x ],
    [ 0,  0,  0,  0,  0,  0,  x,  x,  x,  x ],
    [ 0,  0,  0,  0,  0,  1,  1,  2,  3,  4 ],
    [ 0,  0,  0,  0,  0,  0,  x,  x,  x,  x ],
  ], cmdline_opts )

#-------------------------------------------------------------------------
# test_stream
#-------------------------------------------------------------------------

def test_stream( cmdline_opts ):
  run_test_vector_sim( SortReverseUnitFlat(),
                       mk_test_vector_table( 3, tvec_stream ),
                       cmdline_opts )

#-------------------------------------------------------------------------
# test_dups
#-------------------------------------------------------------------------

def test_dups( cmdline_opts ):
  run_test_vector_sim( SortReverseUnitFlat(),
                       mk_test_vector_table( 3, tvec_dups ),
                       cmdline_opts )

#-------------------------------------------------------------------------
# test_sorted
#-------------------------------------------------------------------------

def test_sorted( cmdline_opts ):
  run_test_vector_sim( SortReverseUnitFlat(),
                       mk_test_vector_table( 3, tvec_sorted ),
                       cmdline_opts )

#-------------------------------------------------------------------------
# test_random
#-------------------------------------------------------------------------

@pytest.mark.parametrize( "nbits", [ 4, 8, 16, 32 ] )
def test_random( nbits, cmdline_opts ):
  tvec_random = [ [ randint(0,2**nbits-1) for _ in range(4) ] for _ in range(20) ]
  run_test_vector_sim( SortReverseUnitFlat(nbits),
    mk_test_vector_table( 3, tvec_random ), cmdline_opts )
