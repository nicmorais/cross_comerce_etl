defmodule CrossComerceEtlWeb.NumberControllerTest do
  use CrossComerceEtlWeb.ConnCase

  alias CrossComerceEtl.Numbers

  @create_attrs %{
    value: 120.5
  }

  def fixture(:number) do
    {:ok, number} = Numbers.create_number(@create_attrs)
    number
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all numbers", %{conn: conn} do
      conn = get(conn, Routes.number_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end
end
