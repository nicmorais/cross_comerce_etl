defmodule CrossComerceEtl.Repo.Migrations.CreateNumbers do
  use Ecto.Migration

  def change do
    create table(:numbers) do
      add :value, :float
    end

  end
end
