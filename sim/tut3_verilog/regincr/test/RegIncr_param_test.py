#=========================================================================
# Regincr3stage_test
#=========================================================================
import pytest
import collections

from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim, mk_test_case_table
from ..RegIncr import RegIncr
from random import sample, seed, randint

seed(0xdeadbeee)

@pytest.mark.parametrize( "n", [ 8, 2] )
def test_random( n, cmdline_opts ):
  test_vector_table = [( 'in_   out*' )]
  last_result = '?'
  max_val = (1 << n) - 1
  for _ in range(20):
    rand_value = Bits(n, randint(0,max_val))
    test_vector_table.append( [rand_value, last_result] )
    last_result = Bits(n, rand_value + 1, trunc_int=True)
  run_test_vector_sim( RegIncr(p_bitwidth=n), test_vector_table, cmdline_opts )