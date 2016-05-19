# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :blog_api, BlogApi.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "9utxpQ/KfvWGsVqnjA2BZ/GVk8X/yjqp2DWOX2Mg+5/3UDM4uVln52eY9W1Eu16m",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: BlogApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :plug, :mimes, %{
  "application/vnd.api+json" => ["json-api"]
}
