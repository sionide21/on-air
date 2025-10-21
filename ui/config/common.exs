# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :on_air_ui,
  namespace: OnAirUI

# Configures the endpoint
config :on_air_ui, OnAirUIWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dZpoQ4ZwQN61OJeYVahmL+mTUZtBuDXPGBNHHrZE405expyG67VsGbqIu1gURgvN",
  render_errors: [view: OnAirUIWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: OnAirUI.PubSub,
  live_view: [signing_salt: "qG9foyLj"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
