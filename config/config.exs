# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hangman_liveview_client,
  namespace: Hangman.LiveView.Client

# Configures the endpoint
config :hangman_liveview_client, Hangman.LiveView.ClientWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base:
    "vUeAZyDDb4K+x5+1c4Ns00tHl5HZZ8kaOB9C4b0S27zQJcrfN50VKsdKpffGUx1H",
  render_errors: [
    view: Hangman.LiveView.ClientWeb.ErrorView,
    accepts: ~w(html json),
    layout: false
  ],
  pubsub_server: Hangman.LiveView.Client.PubSub,
  live_view: [signing_salt: "uGU1SkgZ"],
  # Allows Windows command => set port=4040 && mix phx.server
  http: [
    port:
      (System.get_env("PORT") || "4000")
      |> String.trim()
      |> String.to_integer()
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "config_logger.exs"
import_config "#{Mix.env()}.exs"
