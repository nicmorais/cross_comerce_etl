defmodule CrossComerceEtl.Repo do
  use Ecto.Repo,
    otp_app: :cross_comerce_etl,
    adapter: Ecto.Adapters.SQLite3
end
