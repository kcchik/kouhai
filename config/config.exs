# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :kouhai,
  ecto_repos: [Kouhai.Repo]

# Configures the endpoint
config :kouhai, KouhaiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oPMPt8dhEqYdwAibTD2+MPW/OWg1FK2r+K2F+CHFrJv2wZRWDarDSrWUKO4uNa25",
  render_errors: [view: KouhaiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Kouhai.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ex_aws,
  json_codec: Jason,
  region: {:system, "AWS_REGION"},
  access_key_id: {:system, "AWS_ACCESS_KEY_ID"},
  secret_access_key: {:system, "AWS_SECRET_ACCESS_KEY"}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
