defmodule CrossComerceEtlWeb.Router do
  use CrossComerceEtlWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CrossComerceEtlWeb do
    pipe_through :api
    resources "/numbers", NumberController, except: [:new, :edit]

  end
end
