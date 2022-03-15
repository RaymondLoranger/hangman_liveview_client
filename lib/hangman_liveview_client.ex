defmodule Hangman.LiveView.Client do
  @moduledoc """
  Hangman.LiveView.Client keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  require Logger

  alias Hangman.{Engine, Game}

  def new_game do
    game_name = Game.random_name()
    :ok = Logger.info("Starting game #{game_name}...")
    {:ok, _game_pid} = Engine.new_game(game_name)
    %{} = tally = Engine.tally(game_name)
    IO.inspect(tally, label: "T-A-L-L-Y")
  end
end
