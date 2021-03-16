defmodule Hangman.LiveView.ClientWeb.HangmanLive do
  use Hangman.LiveView.ClientWeb, :live_view

  require Logger

  alias Hangman.{Engine, Engine.Game}
  alias Phoenix.{HTML, LiveView, LiveView.Socket}
  alias Hangman.LiveView.ClientWeb.{DrawingComp, GuessLettersComp, NewGameComp}
  alias Hangman.LiveView.ClientWeb.{MessageComp, TurnsLeftComp, WordSoFarComp}

  @init %{letters: [], guesses: [], game_state: nil, turns_left: 7, message: ""}

  @spec mount(LiveView.unsigned_params(), map, Socket.t()) :: {:ok, Socket.t()}
  def mount(_params, _session, %Socket{connected?: false} = socket),
    do: {:ok, assign(socket, @init)}

  def mount(_params, _session, socket), do: {:ok, new_game(socket)}

  @spec handle_event(event :: binary, LiveView.unsigned_params(), Socket.t()) ::
          {:noreply, Socket.t()}
  def handle_event("new-game", _params, socket) do
    :ok = end_game(socket)
    {:noreply, new_game(socket)}
  end

  def handle_event("click", %{"guess" => guess}, socket),
    do: {:noreply, make_move(socket, guess)}

  def handle_event("keyup", %{"key" => <<code>> = key}, socket)
      when code in ?a..?z,
      do: {:noreply, make_move(socket, key)}

  def handle_event("keyup", _params, socket), do: {:noreply, socket}

  @spec terminate(term, Socket.t()) :: :ok
  def terminate(reason, %Socket{assigns: %{game_name: game_name}} = _socket) do
    :ok = Logger.warn("Ending game #{game_name}...")
    :ok = Logger.warn("Reason: #{inspect(reason)}")
    :ok = Engine.end_game(game_name)
  end

  ## Private functions

  @spec end_game(Socket.t()) :: :ok
  defp end_game(%Socket{assigns: %{game_name: game_name}} = _socket) do
    :ok = Logger.info("Ending game #{game_name}...")
    :ok = Engine.end_game(game_name)
  end

  @spec new_game(Socket.t()) :: Socket.t()
  defp new_game(socket) do
    game_name = Engine.random_game_name()
    :ok = Logger.info("Starting game #{game_name}...")
    {:ok, _game_pid} = Engine.new_game(game_name)
    %{} = tally = Engine.tally(game_name)
    message = message(tally.game_state, nil)
    assign(socket, tally) |> assign(message: message, game_name: game_name)
  end

  @spec make_move(Socket.t(), String.codepoint()) :: Socket.t()
  defp make_move(%Socket{assigns: %{game_name: game_name}} = socket, guess) do
    %{} = tally = Engine.make_move(game_name, guess)
    message = message(tally.game_state, guess)
    assign(socket, tally) |> assign(message: message)
  end

  # initializing, good guess, bad guess, already used, lost, won...
  @spec message(Game.state(), String.codepoint() | nil) ::
          String.t() | HTML.safe()
  defp message(:initializing, _guess), do: "Good luck 😊❗"
  defp message(:good_guess, _guess), do: "Good guess 😊❗"

  defp message(:bad_guess, guess),
    do: HTML.raw("Letter <span>#{guess}</span> not in the word 😟❗")

  defp message(:already_used, guess),
    do: HTML.raw("Letter <span>#{guess}</span> already used 😮❗")

  defp message(:lost, _guess), do: "Sorry, you lost 😂❗"
  defp message(:won, _guess), do: "Bravo, you won 😇❗"
end
