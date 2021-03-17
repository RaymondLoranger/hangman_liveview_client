defmodule Hangman.LiveView.ClientWeb.HangmanLive do
  use Hangman.LiveView.ClientWeb, :live_view

  alias __MODULE__.Helper
  alias Phoenix.{LiveView, LiveView.Socket}
  alias Hangman.LiveView.ClientWeb.{DrawingComp, GuessLetterComp, NewGameComp}
  alias Hangman.LiveView.ClientWeb.{MessageComp, TurnsLeftComp, WordLetterComp}

  @spec mount(LiveView.unsigned_params(), map, Socket.t()) :: {:ok, Socket.t()}
  def mount(_params, _session, %Socket{connected?: false} = socket),
    do: {:ok, Helper.init_game(socket)}

  def mount(_params, _session, socket), do: {:ok, Helper.new_game(socket)}

  @spec handle_event(event :: binary, LiveView.unsigned_params(), Socket.t()) ::
          {:noreply, Socket.t()}
  def handle_event("new-game", _params, socket) do
    :ok = Helper.end_game(socket)
    {:noreply, Helper.new_game(socket)}
  end

  def handle_event("click", %{"guess" => guess}, socket),
    do: {:noreply, Helper.make_move(socket, guess)}

  def handle_event("keyup", %{"key" => <<code>> = key}, socket)
      when code in ?a..?z,
      do: {:noreply, Helper.make_move(socket, key)}

  def handle_event("keyup", _params, socket), do: {:noreply, socket}

  @spec terminate(term, Socket.t()) :: :ok
  def terminate(reason, socket), do: :ok = Helper.terminate(reason, socket)
end
