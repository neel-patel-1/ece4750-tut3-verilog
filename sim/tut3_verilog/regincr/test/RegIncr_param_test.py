#=========================================================================
# Regincr3stage_test
#=========================================================================
import pytest
import collections

from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim, mk_test_case_table
from ..RegIncr import RegIncr
from random import sample, seed, randint

seed(0xdeadbeef)

@pytest.mark.parametrize( "n", [ 8] )
def test_random( n, cmdline_opts ):
  test_vector_table = [( 'in_   out*' )]
  last_result = '?'
  for _ in range(20):
    rand_value = Bits8( randint(0,0xff))
    test_vector_table.append( [rand_value, last_result] )
    last_result = Bits8( rand_value + 1, trunc_int=True)
  run_test_vector_sim( RegIncr(), test_vector_table, cmdline_opts )