defmodule Hangman.LiveView.ClientWeb.WordSoFarComponent do
  use Hangman.LiveView.ClientWeb, :live_component

  def render(assigns) do
    IO.inspect(assigns.letters, label: "+++ letters +++")
    ~L"""
    <p id="word-so-far"><%= Enum.join(@letters, " ") %></p>
    """
  end
end
