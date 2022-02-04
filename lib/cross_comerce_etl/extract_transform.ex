defmodule CrossComerceEtl.ExtractTransform do
  alias CrossComerceEtl.Repo
  alias CrossComerceEtl.Numbers.Number

  def run() do
    baseUrl = "http://challenge.dienekes.com.br/api/numbers?page="

    append_numbers(baseUrl, 9999)
    |> quicksort
    |> Enum.map(fn val -> Repo.insert(%Number{value: val}) end)
  end

  def append_numbers(baseUrl, page) do
    IO.puts("Page: " <> Integer.to_string(page))
    url = baseUrl <> Integer.to_string(page)
    
    response = fetch_numbers(url)
    response_numbers = Poison.decode!(response.body)["numbers"]
        
    case response_numbers do
      resp when resp != [] -> response_numbers ++ append_numbers(baseUrl, page + 1)
      _ -> []
    end
  end

  def quicksort([]), do: []

  def quicksort([pivot|[]]), do: [pivot]

  def quicksort([pivot|tail]) do
    lower = Enum.filter(tail, fn(n) -> n < pivot  end)
    higher = Enum.filter(tail, fn(n) -> n > pivot  end)
    quicksort(lower) ++ [pivot] ++ quicksort(higher) 
  end

  def fetch_numbers(_, _retry = 0), do: []

  def fetch_numbers(url, retry \\ 3) do
    response = HTTPoison.get!(url)
    case response.status_code do
      200 -> response
      _ -> fetch_numbers(url, retry - 1)
    end
  end
end
