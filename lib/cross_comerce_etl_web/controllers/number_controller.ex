defmodule CrossComerceEtlWeb.NumberController do
  use CrossComerceEtlWeb, :controller

  alias CrossComerceEtl.Numbers
  alias CrossComerceEtl.Numbers.Number

  action_fallback CrossComerceEtlWeb.FallbackController

  def index(conn, _params) do
    numbers = Numbers.list_numbers()
    render(conn, "index.json", numbers: numbers)
  end

  def create(conn, %{"number" => number_params}) do
    with {:ok, %Number{} = number} <- Numbers.create_number(number_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.number_path(conn, :show, number))
      |> render("show.json", number: number)
    end
  end

  def show(conn, %{"id" => id}) do
    number = Numbers.get_number!(id)
    render(conn, "show.json", number: number)
  end

  def update(conn, %{"id" => id, "number" => number_params}) do
    number = Numbers.get_number!(id)

    with {:ok, %Number{} = number} <- Numbers.update_number(number, number_params) do
      render(conn, "show.json", number: number)
    end
  end

  def delete(conn, %{"id" => id}) do
    number = Numbers.get_number!(id)

    with {:ok, %Number{}} <- Numbers.delete_number(number) do
      send_resp(conn, :no_content, "")
    end
  end
end
