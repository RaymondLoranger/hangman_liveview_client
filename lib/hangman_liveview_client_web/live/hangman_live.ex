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

  alias Phoenix.HTML

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
         message: message(tally.game_state)
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
    game_name = socket.assigns.game_name
    %{} = tally = Engine.make_move(game_name, guess)

    {:noreply,
     assign(socket,
       letters: tally.letters,
       turns_left: tally.turns_left,
       guesses: tally.guesses,
       message: message(tally.game_state, guess: guess, game_name: game_name)
     )}
  end

  def handle_event("new-game", params, socket) do
    IO.inspect(params, label: "+++ new game clicked +++")
    {:noreply, socket}
  end

  def handle_event("keyup", %{"key" => <<code>> = key}, socket)
      when code in ?a..?z do
    game_name = socket.assigns.game_name
    %{} = tally = Engine.make_move(game_name, key)

    {:noreply,
     assign(socket,
       letters: tally.letters,
       turns_left: tally.turns_left,
       guesses: tally.guesses,
       message: message(tally.game_state, guess: key, game_name: game_name)
     )}
  end

  def handle_event("keyup", _params, socket), do: {:noreply, socket}

  ## Private functions

  # initializing, good guess, bad guess, already used, lost, won...
  defp message(game_state, opts \\ [])
  defp message(:initializing, _opts), do: "Good luck 😊❗"
  defp message(:good_guess, _opts), do: "Good guess 😊❗"

  defp message(:bad_guess, opts),
    do: HTML.raw("Letter <span>#{opts[:guess]}</span> not in the word 😟❗")

  defp message(:already_used, opts),
    do: HTML.raw("Letter <span>#{opts[:guess]}</span> already used 😮❗")

  defp message(:lost, opts) do
    tally = Engine.guess_word(opts[:game_name])
    HTML.raw("You lost. The word was <i>#{tally.letters}</i>.")
  end

  defp message(:won, _opts), do: "Bravo, you won 😇❗"
end
