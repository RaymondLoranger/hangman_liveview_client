defmodule Hangman.LiveView.ClientWeb.GuessLettersComp do
  use Hangman.LiveView.ClientWeb, :live_component

  def render(assigns) do
    ~L"""
    <div id="guess-letters">
      <%= for code <- ?a..?z do %>
        <button phx-click="click" phx-value-guess="<%= <<code>> %>"
                <%= if <<code>> in @guesses, do: "disabled" %>
                class="<%= button_class(<<code>>, @letters, @game_state) %>">
          <%= <<code>> %>
        </button>
      <% end %>
    </div>
    """
  end

  defp button_class(letter, letters, game_state)
       when game_state in [:lost, :won] do
    if letter in letters, do: "correct game-over", else: "game-over"
  end

  defp button_class(letter, letters, _game_state) do
    if letter in letters, do: "correct"
  end
end
