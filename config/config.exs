# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :wsc,
  ecto_repos: [Wsc.Repo]

# Configures the endpoint
config :wsc, WscWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+UFdbk5rMYqipE+LOKYIrY+fC9YWlvJS16MD8WBHHuPXwLcj1WNJWS/7p6OnzxdS",
  render_errors: [view: WscWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Wsc.PubSub,
  live_view: [signing_salt: "AM0Mepzn"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

#ja_serializer setup
config :phoenix, :format_encoders,
  "json-api": Jason

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

# geo_postgis to use Jason
config :geo_postgis,
  json_library: Jason

config :phoenix, WscWeb.Endpoint,
  render_errors: [view: WscWeb.ErrorView, accepts: ~w(json json-api)]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
