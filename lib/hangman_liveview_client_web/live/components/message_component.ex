defmodule Hangman.LiveView.ClientWeb.MessageComponent do
  use Hangman.LiveView.ClientWeb, :live_component

  def render(assigns) do
    ~L"""
    <p id="message">
      <%= @message %>
    </p>
    """
  end
end
