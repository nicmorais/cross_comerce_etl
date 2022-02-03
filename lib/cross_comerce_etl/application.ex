defmodule CrossComerceEtl.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias CrossComerceEtl.ExtractTransform
  
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      CrossComerceEtl.Repo,
      # Start the Telemetry supervisor
      CrossComerceEtlWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CrossComerceEtl.PubSub},
      # Start the Endpoint (http/https)
      CrossComerceEtlWeb.Endpoint
      # Start a worker by calling: CrossComerceEtl.Worker.start_link(arg)
      # {CrossComerceEtl.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CrossComerceEtl.Supervisor]
    ret = Supervisor.start_link(children, opts)
    ExtractTransform.run
    ret
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CrossComerceEtlWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
