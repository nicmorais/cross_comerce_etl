defmodule CrossComerceEtl.ExtractTransform do
  alias CrossComerceEtl.Repo
  alias CrossComerceEtl.Numbers.Number
  import Ecto.Query

  def run() do
    IO.puts("Checking database...")
    numbers = from n in Number, limit: 10
    numbers = Repo.all(numbers)
    if length(numbers) < 1 do
      url = "http://challenge.dienekes.com.br/api/numbers?page="
      numbers = append_numbers(url, 9000)
      Enum.map(quicksort(numbers), fn val -> Repo.insert(%Number{value: val}) end)
    end
  end
  
  defp append_numbers(baseUrl, page) do
    IO.puts("Page: " <> Integer.to_string(page))
    url = baseUrl <> Integer.to_string(page)
    
    response = fetch_numbers(url)
    response_numbers = Poison.decode!(response.body)["numbers"]
    
    IO.inspect(response)
    
    case response_numbers do
      resp when resp != [] -> response_numbers ++ append_numbers(baseUrl, page + 1)
      _ -> []
    end
  end

  defp quicksort([]), do: []

  defp quicksort([pivot|[]]), do: [pivot]

  defp quicksort([pivot|tail]) do
    lower = Enum.filter(tail, fn(n) -> n < pivot  end)
    higher = Enum.filter(tail, fn(n) -> n > pivot  end)
    quicksort(lower) ++ [pivot] ++ quicksort(higher) 
  end

  defp fetch_numbers(_, _retry = 0), do: :ignore

  defp fetch_numbers(url, retry \\ 3) do
    response = HTTPoison.get!(url)
    case status_code = response.status_code do
      200 -> response
      _ -> fetch_numbers(url, retry - 1)
    end
  end
end
