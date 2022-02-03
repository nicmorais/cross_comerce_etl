defmodule CrossComerceEtlWeb.NumberView do
  use CrossComerceEtlWeb, :view
  alias CrossComerceEtlWeb.NumberView

  def render("index.json", %{numbers: numbers}) do
    %{data: render_many(numbers, NumberView, "number.json")}
  end

  def render("show.json", %{number: number}) do
    %{data: render_one(number, NumberView, "number.json")}
  end

  def render("number.json", %{number: number}) do
    %{value: number.value}
  end
end
