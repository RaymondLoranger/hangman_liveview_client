defmodule Hangman.LiveView.ClientWeb.HangmanLive do
  use Hangman.LiveView.ClientWeb, :live_view

  require Logger

  alias Hangman.Engine
  alias Phoenix.HTML
  alias Phoenix.LiveView.Socket

  alias Hangman.LiveView.ClientWeb.{
    DrawingComponent,
    GuessLettersComponent,
    MessageComponent,
    NewGameComponent,
    TurnsLeftComponent,
    WordSoFarComponent
  }

  @empty_assigns %{letters: [], guesses: [], turns_left: 0, message: ""}

  @spec mount(params :: map, session :: map, Socket.t()) :: {:ok, Socket.t()}
  def mount(_, _, %Socket{connected?: false} = socket),
    do: {:ok, assign(socket, @empty_assigns)}

  def mount(_, _, socket), do: {:ok, new_game(socket)}

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

  ## Private functions

  defp end_game(%Socket{assigns: %{game_name: game_name}} = _socket) do
    :ok = Logger.info("Ending game #{game_name}...")
    :ok = Engine.end_game(game_name)
  end

  defp new_game(socket) do
    game_name = Engine.random_game_name()
    :ok = Logger.info("Starting game #{game_name}...")
    {:ok, _game_pid} = Engine.new_game(game_name)
    %{} = tally = Engine.tally(game_name)
    message = message(tally.game_state, nil)
    assign(socket, tally) |> assign(message: message, game_name: game_name)
  end

  defp make_move(%Socket{assigns: %{game_name: game_name}} = socket, guess) do
    %{} = tally = Engine.make_move(game_name, guess)
    message = message(tally.game_state, guess)
    assign(socket, tally) |> assign(message: message)
  end

  # initializing, good guess, bad guess, already used, lost, won...
  defp message(:initializing, _guess), do: "Good luck 😊❗"
  defp message(:good_guess, _guess), do: "Good guess 😊❗"

  defp message(:bad_guess, guess),
    do: HTML.raw("Letter <span>#{guess}</span> not in the word 😟❗")

  defp message(:already_used, guess),
    do: HTML.raw("Letter <span>#{guess}</span> already used 😮❗")

  defp message(:lost, _guess), do: "Sorry, you lost 😂❗"
  defp message(:won, _guess), do: "Bravo, you won 😇❗"
end
