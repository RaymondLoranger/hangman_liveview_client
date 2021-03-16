defmodule Hangman.LiveView.ClientWeb.TurnsLeftComp do
  use Hangman.LiveView.ClientWeb, :live_component

  def render(assigns) do
    ~L"""
    <p id="turns-left">Turns left: <%= @turns_left %></p>
    """
  end
end
