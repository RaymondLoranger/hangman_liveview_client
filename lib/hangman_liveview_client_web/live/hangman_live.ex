defmodule Hangman.LiveView.ClientWeb.HangmanLive do
  use Hangman.LiveView.ClientWeb, :live_view

  alias Hangman.Engine
  alias Hangman.LiveView.ClientWeb.GallowsComponent
  alias Hangman.LiveView.ClientWeb.GuessLettersComponent
  alias Hangman.LiveView.ClientWeb.WordSoFarComponent

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
         guesses: []
       )}
    else
      {:ok,
       assign(socket, game_name: "", letters: [], turns_left: 0, guesses: [])}
    end
  end

  def handle_event("click", %{"guess" => guess}, socket) do
    IO.inspect(guess, label: "+++ letter clicked +++")
    %{} = tally = Engine.make_move(socket.assigns.game_name, guess)
    socket = update(socket, :guesses, &[guess | &1])

    {:noreply,
     assign(socket, letters: tally.letters, turns_left: tally.turns_left)}
  end

  def handle_event("keyup", %{"key" => <<code>> = key}, socket)
      when code in ?a..?z do
    IO.inspect(key, label: "+++ letter keyed +++")
    %{} = tally = Engine.make_move(socket.assigns.game_name, key)
    guesses = socket.assigns.guesses

    socket =
      if key in guesses do
        socket
      else
        update(socket, :guesses, &[key | &1])
      end

    {:noreply,
     assign(socket, letters: tally.letters, turns_left: tally.turns_left)}
  end

  def handle_event("keyup", _params, socket), do: {:noreply, socket}
end
