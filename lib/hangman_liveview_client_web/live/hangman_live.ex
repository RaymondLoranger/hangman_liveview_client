defmodule Hangman.LiveView.ClientWeb.HangmanLive do
  use Hangman.LiveView.ClientWeb, :live_view

  import Hangman.LiveView.ClientWeb.GameComp

  alias Hangman.LiveView.Client
  alias Hangman.LiveView.ClientWeb.DrawingComp
  alias Phoenix.LiveView
  alias Phoenix.LiveView.Socket

  @impl LiveView
  @spec mount(LiveView.unsigned_params(), map, Socket.t()) :: {:ok, Socket.t()}
  def mount(_params, _session, socket) do
    if connected?(socket) do
      {:ok, Client.new_game(socket)}
    else
      {:ok, Client.init_game(socket)}
    end
  end

  @impl LiveView
  @spec handle_event(event :: binary, LiveView.unsigned_params(), Socket.t()) ::
          {:noreply, Socket.t()}
  def handle_event("new-game", _params, socket) do
    :ok = Client.end_game(socket)
    {:noreply, Client.new_game(socket)}
  end

  def handle_event("click", %{"guess" => guess}, socket),
    do: {:noreply, Client.make_move(socket, guess)}

  def handle_event("keyup", %{"key" => <<code>> = key}, socket)
      when code in ?a..?z,
      do: {:noreply, Client.make_move(socket, key)}

  def handle_event("keyup", _params, socket), do: {:noreply, socket}

  @impl LiveView
  @spec terminate(term, Socket.t()) :: :ok
  def terminate(reason, socket), do: :ok = Client.terminate(reason, socket)
end
