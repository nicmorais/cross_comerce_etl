defmodule CrossComerceEtl.ExtractTransformTest do
  alias CrossComerceEtl.ExtractTransform
  alias CrossComerceEtl.Repo
  alias CrossComerceEtl.Numbers.Number

  use CrossComerceEtl.DataCase
  use ExUnit.Case, async: false
  import Ecto.Query
  import Mox

  test "quicksort/1 sorts list" do
    list = [0.9826104916223434, 2, 7, 4, 0.047163845168786564, 0.0000092338012657]
    assert ExtractTransform.quicksort(list) == [0.0000092338012657,
                                                0.047163845168786564,
                                                0.9826104916223434,
                                                2, 4, 7]
  end

  test "fetch_numbers/2" do
    expect(HTTPoison.BaseMock, :get!, 1, fn _ -> %HTTPoison.Response{body: "{\"numbers\":[2, 3]}", status_code: 200 }  end)
    assert %HTTPoison.Response{body: "{\"numbers\":[2, 3]}", status_code: 200} = ExtractTransform.fetch_numbers("")

    verify!()
  end

  test "fetch_numbers/2 with error" do
    expect(HTTPoison.BaseMock, :get!, 3, fn _ -> %HTTPoison.Response{body: "{\"numbers\":[]}", status_code: 500 }  end)
    assert [] = ExtractTransform.fetch_numbers("http://example.com")
    
    verify!()
  end

  test "append_numbers/2 with error" do
    expect(HTTPoison.BaseMock, :get!, 1, fn _ -> %HTTPoison.Response{body: "{\"numbers\": [1, 2, 3]}", status_code: 200} end)
    expect(HTTPoison.BaseMock, :get!, 1, fn _ -> %HTTPoison.Response{body: "{\"error\": \"error\"}", status_code: 500} end)
    expect(HTTPoison.BaseMock, :get!, 1, fn _ -> %HTTPoison.Response{body: "{\"numbers\": []}", status_code: 200} end)

    assert [1, 2, 3] = ExtractTransform.append_numbers("http://example.com", 1)
    verify!()
  end

  test "append_numbers/2 no errors" do
    expect(HTTPoison.BaseMock, :get!, 1, fn _ -> %HTTPoison.Response{body: "{\"numbers\": [0.4, 0.5, 0.6]}", status_code: 200} end)
    expect(HTTPoison.BaseMock, :get!, 1, fn _ -> %HTTPoison.Response{body: "{\"numbers\": [0.7, 0.8, 0.9]}", status_code: 200} end)
    expect(HTTPoison.BaseMock, :get!, 1, fn _ -> %HTTPoison.Response{body: "{\"numbers\": []}", status_code: 200} end)

    assert [0.4, 0.5, 0.6, 0.7, 0.8, 0.9] = ExtractTransform.append_numbers("http://example.com", 1)
    verify!()
  end

  test "run/0" do
    expect(HTTPoison.BaseMock, :get!, 1, fn _ -> %HTTPoison.Response{body: "{\"numbers\": [0.4, 0.5, 0.6]}", status_code: 200} end)
    expect(HTTPoison.BaseMock, :get!, 1, fn _ -> %HTTPoison.Response{body: "{\"numbers\": [0.7, 0.8, 0.9]}", status_code: 200} end)
    expect(HTTPoison.BaseMock, :get!, 1, fn _ -> %HTTPoison.Response{body: "{\"numbers\": []}", status_code: 200} end)

    ExtractTransform.run
    query = from n in Number, select: count()
    count = Repo.one(query)
    assert count = 6
  end
end

