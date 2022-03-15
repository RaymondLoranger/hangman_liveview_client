import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hangman_liveview_client, Hangman.LiveView.ClientWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "3WYx9kONkGZuMNNu1cx957872ruyRUJlqfwSRpVlvCoDtMN6zIt8EMcdBKgCMhIW",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
