import pytest
from random     import randint, seed
from ..MinMaxUnit import MinMaxUnit
from pymtl3.stdlib.test_utils import run_test_vector_sim

seed(0xdeadbeef)

x = '?'

tvec_random = [ [ randint(0,0xff) for _ in range(2) ] for _ in range(20) ]

def mk_test_vector_table( inputs ):
  headr_str = ("in0", "in1", "out_min", "out_max" )
  test_vector_table = [ headr_str ]

  inputs_val = []
  outputs_val = []
  for input_ in inputs:
      inputs_val.append( input_ )
      outputs_val.append( sorted( input_ ) )
  for input_,output in zip( inputs_val, outputs_val ):
    test_vector_table.append( input_ + output )
  return test_vector_table


def test_random():
  run_test_vector_sim( MinMaxUnit(p_nbits=8), mk_test_vector_table( tvec_random ) )