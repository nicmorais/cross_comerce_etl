defmodule CrossComerceEtl.Numbers.Number do
  use Ecto.Schema
  import Ecto.Changeset

  schema "numbers" do
    field :value, :float

  end

  @doc false
  def changeset(number, attrs) do
    number
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
