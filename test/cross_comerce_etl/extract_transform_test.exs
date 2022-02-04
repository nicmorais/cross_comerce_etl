defmodule CrossComerceEtl.ExtractTransformTest do
  alias CrossComerceEtl.ExtractTransform
  use CrossComerceEtl.DataCase
  use ExUnit.Case, async: false

  import Mox

  test "quicksort/1 sorts list" do
    list = [0.9826104916223434, 2, 7, 4, 0.047163845168786564, 0.0000092338012657]
    assert ExtractTransform.quicksort(list) == [0.0000092338012657,
                                                0.047163845168786564,
                                                0.9826104916223434,
                                                2, 4, 7]
  end

  test "fetch_numbers/2" do
    expect(HTTPoison.BaseMock, :get!, fn (_url) -> %HTTPoison.Response{body: "{\"numbers\":[2,3]}", status_code: 500 }  end)
    assert [] = ExtractTransform.fetch_numbers("")
  end

end

