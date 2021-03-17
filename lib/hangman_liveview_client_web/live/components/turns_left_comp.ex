defmodule Hangman.LiveView.ClientWeb.TurnsLeftComp do
  use Hangman.LiveView.ClientWeb, :live_component

  alias Phoenix.LiveView.{Rendered, Socket}

  @spec render(Socket.assigns()) :: Rendered.t()
  def render(assigns) do
    ~L"""
    <p id="turns-left">Turns left: <%= @turns_left %></p>
    """
  end
end
