ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(CrossComerceEtl.Repo, :manual)
Mox.defmock(HTTPoison.BaseMock, for: HTTPoison.Base)
Application.put_env(:cross_comerce_etl, :http_client, HTTPoison.BaseMock)
