defmodule Hangman.LiveView.ClientWeb.HangmanLive do
  use Hangman.LiveView.ClientWeb, :live_view

  alias Hangman.Engine

  alias Hangman.LiveView.ClientWeb.{
    DrawingComponent,
    GuessLettersComponent,
    MessageComponent,
    NewGameComponent,
    TurnsLeftComponent,
    WordSoFarComponent
  }

  require Logger

  def mount(_params, _session, socket) do
    if connected?(socket) do
      game_name = Engine.random_game_name()
      :ok = Logger.info("Starting game #{game_name}...")
      {:ok, _game_pid} = Engine.new_game(game_name)
      %{} = tally = Engine.tally(game_name)
      IO.inspect(tally, label: "!!! tally !!!")

      {:ok,
       assign(socket,
         game_name: game_name,
         letters: tally.letters,
         turns_left: tally.turns_left,
         guesses: [],
         message: message(tally.game_state, nil)
       )}
    else
      {:ok,
       assign(socket,
         game_name: "",
         letters: [],
         turns_left: 0,
         guesses: [],
         message: ""
       )}
    end
  end

  def handle_event("click", %{"guess" => guess}, socket) do
    IO.inspect(guess, label: "+++ letter clicked +++")
    %{} = tally = Engine.make_move(socket.assigns.game_name, guess)

    {:noreply,
     assign(socket,
       letters: tally.letters,
       turns_left: tally.turns_left,
       guesses: tally.guesses,
       message: message(tally.game_state, guess)
     )}
  end

  def handle_event("new-game", params, socket) do
    IO.inspect(params, label: "+++ new game clicked +++")
    {:noreply, socket}
  end

  def handle_event("keyup", %{"key" => <<code>> = key}, socket)
      when code in ?a..?z do
    IO.inspect(key, label: "+++ letter keyed +++")
    %{} = tally = Engine.make_move(socket.assigns.game_name, key)

    {:noreply,
     assign(socket,
       letters: tally.letters,
       turns_left: tally.turns_left,
       guesses: tally.guesses,
       message: message(tally.game_state, key)
     )}
  end

  def handle_event("keyup", _params, socket), do: {:noreply, socket}

  ## Private functions

  # initializing, good guess, bad guess, already used, lost, won...
  defp message(:initializing, _guess), do: "Initializing..."
  defp message(:good_guess, _guess), do: "Good guess 😊!"
  defp message(:bad_guess, guess), do: "Letter '#{guess}' not in the word 😟!"
  defp message(:already_used, guess), do: "Letter '#{guess}' already used 😮!"
  defp message(:lost, _guess), do: "Sorry, you lost 😢!"
  defp message(:won, _guess), do: "Bravo, you won 😇!"
end
