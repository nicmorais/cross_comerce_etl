defmodule CrossComerceEtl.Numbers do
  @moduledoc """
  The Numbers context.
  """

  import Ecto.Query, warn: false
  alias CrossComerceEtl.Repo

  alias CrossComerceEtl.Numbers.Number

  @doc """
  Returns the list of numbers.

  ## Examples

      iex> list_numbers()
      [%Number{}, ...]

  """
  def list_numbers do
    Repo.all(Number)
  end

  @doc """
  Gets a single number.

  Raises `Ecto.NoResultsError` if the Number does not exist.

  ## Examples

      iex> get_number!(123)
      %Number{}

      iex> get_number!(456)
      ** (Ecto.NoResultsError)

  """
  def get_number!(id), do: Repo.get!(Number, id)

  @doc """
  Creates a number.

  ## Examples

      iex> create_number(%{field: value})
      {:ok, %Number{}}

      iex> create_number(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_number(attrs \\ %{}) do
    %Number{}
    |> Number.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a number.

  ## Examples

      iex> update_number(number, %{field: new_value})
      {:ok, %Number{}}

      iex> update_number(number, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_number(%Number{} = number, attrs) do
    number
    |> Number.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a number.

  ## Examples

      iex> delete_number(number)
      {:ok, %Number{}}

      iex> delete_number(number)
      {:error, %Ecto.Changeset{}}

  """
  def delete_number(%Number{} = number) do
    Repo.delete(number)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking number changes.

  ## Examples

      iex> change_number(number)
      %Ecto.Changeset{data: %Number{}}

  """
  def change_number(%Number{} = number, attrs \\ %{}) do
    Number.changeset(number, attrs)
  end
end
