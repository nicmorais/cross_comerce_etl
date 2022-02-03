defmodule CrossComerceEtl.NumbersTest do
  use CrossComerceEtl.DataCase

  alias CrossComerceEtl.Numbers

  describe "numbers" do
    alias CrossComerceEtl.Numbers.Number

    @valid_attrs %{value: 120.5}
    @update_attrs %{value: 456.7}
    @invalid_attrs %{value: nil}

    def number_fixture(attrs \\ %{}) do
      {:ok, number} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Numbers.create_number()

      number
    end

    test "list_numbers/0 returns all numbers" do
      number = number_fixture()
      assert Numbers.list_numbers() == [number]
    end

    test "get_number!/1 returns the number with given id" do
      number = number_fixture()
      assert Numbers.get_number!(number.id) == number
    end

    test "create_number/1 with valid data creates a number" do
      assert {:ok, %Number{} = number} = Numbers.create_number(@valid_attrs)
      assert number.value == 120.5
    end

    test "create_number/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Numbers.create_number(@invalid_attrs)
    end

    test "update_number/2 with valid data updates the number" do
      number = number_fixture()
      assert {:ok, %Number{} = number} = Numbers.update_number(number, @update_attrs)
      assert number.value == 456.7
    end

    test "update_number/2 with invalid data returns error changeset" do
      number = number_fixture()
      assert {:error, %Ecto.Changeset{}} = Numbers.update_number(number, @invalid_attrs)
      assert number == Numbers.get_number!(number.id)
    end

    test "delete_number/1 deletes the number" do
      number = number_fixture()
      assert {:ok, %Number{}} = Numbers.delete_number(number)
      assert_raise Ecto.NoResultsError, fn -> Numbers.get_number!(number.id) end
    end

    test "change_number/1 returns a number changeset" do
      number = number_fixture()
      assert %Ecto.Changeset{} = Numbers.change_number(number)
    end
  end
end
