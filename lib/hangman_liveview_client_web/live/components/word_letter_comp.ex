defmodule Hangman.LiveView.ClientWeb.WordLetterComp do
  use Hangman.LiveView.ClientWeb, :live_component

  alias Hangman.Game
  alias Phoenix.LiveView.{Rendered, Socket}

  @spec render(Socket.assigns()) :: Rendered.t()
  def render(assigns) do
    ~L"""
    <span id="word-letter-<%= @id %>" class="<%= class(@letter) %>">
      <%= @letter %>
    </span>
    """
  end

  ## Private functions

  @spec class(Game.letter() | charlist) :: String.t() | nil
  defp class("_"), do: nil
  defp class(letter) when is_binary(letter), do: "appear"
  defp class(_charlist), do: "unveil"
end
