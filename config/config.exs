# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :snagg,
  ecto_repos: [Snagg.Repo],
  generators: [binary_id: true]

# use UUIDs for database primary keys
config :snagg, Snagg.Repo, migration_primary_key: [name: :id, type: :binary_id]

# Configures the endpoint
config :snagg, SnaggWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a09959lShftpd04eQmLG+Aa4LruE84E1Snc6RLoBM/mmTjh4hwouZjVjjlZHvIUO",
  render_errors: [view: SnaggWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Snagg.PubSub,
  live_view: [signing_salt: "7QAaRRfm"]

config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [hd: "blvd.co", default_scope: "email profile"]}
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: {System, :get_env, ["GOOGLE_CLIENT_ID"]},
  client_secret: {System, :get_env, ["GOOGLE_CLIENT_SECRET"]}

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :snagg, Snagg.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
