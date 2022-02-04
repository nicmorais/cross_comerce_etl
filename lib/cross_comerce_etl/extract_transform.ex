defmodule CrossComerceEtl.ExtractTransform do
  alias CrossComerceEtl.Repo
  alias CrossComerceEtl.Numbers.Number
  alias CrossComerceEtl.Numbers

  def run(start_page \\ 1) do
    baseUrl = "http://challenge.dienekes.com.br/api/numbers?page="

    # get all numbers, sort them and insert into database
    numbers =
      append_numbers(baseUrl, start_page)
      |> quicksort
      |> Enum.map(fn number -> [value: number] end)

    Repo.insert_all(Number, numbers)
  end

  # recursively get list of numbers and append them
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
  # recursive quicksort algorithm implementation
  def quicksort([pivot|tail]) do
    lower = Enum.filter(tail, fn(n) -> n < pivot  end)
    higher = Enum.filter(tail, fn(n) -> n > pivot  end)
    quicksort(lower) ++ [pivot] ++ quicksort(higher) 
  end

  # if ran out of retries, returns empty list
  def fetch_numbers(_, _retry = 0), do: []

  def fetch_numbers(url, retry \\ 3) do
    response = http_client().get!(url)
    case response.status_code do
      200 -> response
      _ -> fetch_numbers(url, retry - 1)
    end
  end

  # if testing, get mocked HTTPoison
  defp http_client do
    Application.get_env(:cross_comerce_etl, :http_client)
  end
end
