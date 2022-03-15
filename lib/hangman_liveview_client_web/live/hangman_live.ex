defmodule Hangman.LiveView.ClientWeb.HangmanLive do
  use Hangman.LiveView.ClientWeb, :live_view

  alias Phoenix.LiveView
  alias Phoenix.LiveView.{Rendered, Socket}

  @impl LiveView
  @spec mount(LiveView.unsigned_params(), map, Socket.t()) :: {:ok, Socket.t()}
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl LiveView
  @spec render(Socket.assigns()) :: Rendered.t()
  def render(assigns) do
    ~H"""
    <div id="hangman">
      <h1 class="bg-indigo-700 text-white">
        Welcome to Hangman!!
      </h1>
    </div>
    """
  end
end
