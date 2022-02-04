# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cross_comerce_etl,
  ecto_repos: [CrossComerceEtl.Repo]

# Configures the endpoint
config :cross_comerce_etl, CrossComerceEtlWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kshu3SF7Z58WP0/xk3TY0oTdKs3VSlPvXpmP4BofidH4wglAZL7VeLYLZJ4QqPDa",
  render_errors: [view: CrossComerceEtlWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CrossComerceEtl.PubSub,
  live_view: [signing_salt: "GIBCrIjb"]

config :cross_comerce_etl, :http_client, HTTPoison

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
