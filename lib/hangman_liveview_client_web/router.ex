defmodule Hangman.LiveView.ClientWeb.Router do
  use Hangman.LiveView.ClientWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Hangman.LiveView.ClientWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Hangman.LiveView.ClientWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/hangman", HangmanLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", Hangman.LiveView.ClientWeb do
  #   pipe_through :api
  # end
end
