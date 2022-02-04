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
    expect(HTTPoison.BaseMock, :get!, 3, fn (_url) -> %HTTPoison.Response{body: "{\"numbers\":[2, 3]}", status_code: 200 }  end)
    assert %HTTPoison.Response{body: "{\"numbers\":[2, 3]}", status_code: 200} = ExtractTransform.fetch_numbers("")
  end

  test "fetch_numbers/2 with error" do
    expect(HTTPoison.BaseMock, :get!, 3, fn (_url) -> %HTTPoison.Response{body: "{\"numbers\":[]}", status_code: 500 }  end)
    assert [] = ExtractTransform.fetch_numbers("")
  end

  test "append_numbers/2" do
    expect(HTTPoison.BaseMock, :get!, 10, fn (url) -> case String.slice(url, -1, 1) do
                                                      "1" -> "{\"numbers\": [1,2,3]}" 
                                                      "2" ->  "{\"numbers\": []}" end end)
    assert [] = ExtractTransform.append_numbers("http://challenge.dienekes.com.br/api/numbers?page=", 1)
  end
end

