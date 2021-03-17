defmodule Hangman.LiveView.ClientWeb.GuessLetterComp do
  use Hangman.LiveView.ClientWeb, :live_component

  alias Phoenix.LiveView.{Rendered, Socket}

  @spec render(Socket.assigns()) :: Rendered.t()
  def render(assigns) do
    ~L"""
    <button id="guess-letter-<%= @id %>"
            phx-click="click" phx-value-guess="<%= @letter %>"
            <%= if @disabled, do: "disabled" %>
            class="<%= class(@correct, @game_over) %>">
      <%= @letter %>
    </button>
    """
  end

  ## Private functions

  @spec class(boolean, boolean) :: String.t() | nil
  defp class(correct, game_over)
  defp class(false, false), do: nil
  defp class(false, true), do: "game-over"
  defp class(true, false), do: "correct"
  defp class(true, true), do: "correct game-over"
end
