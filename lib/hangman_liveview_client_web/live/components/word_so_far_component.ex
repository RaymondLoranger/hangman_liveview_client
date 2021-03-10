defmodule Hangman.LiveView.ClientWeb.WordSoFarComponent do
  use Hangman.LiveView.ClientWeb, :live_component

  def render(assigns) do
    ~L"""
    <p id="word-so-far">
      <span><%= Enum.join(@letters, " ") %></span>
    </p>
    """
  end
end
