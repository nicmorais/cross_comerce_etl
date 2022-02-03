defmodule CrossComerceEtl.ExtractTransformTest do
alias CrossComerceEtl.ExtractTransform
use CrossComerceEtl.DataCase

test "quicksort/1 sorts list" do
    list = [5, 2, 7, 4, 9, 0]
    assert ExtractTransform.quicksort(list) == [0, 2, 4, 5, 7, 9]
  end
end