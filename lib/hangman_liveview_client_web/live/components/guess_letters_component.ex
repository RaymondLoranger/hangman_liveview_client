defmodule Hangman.LiveView.ClientWeb.GuessLettersComponent do
  use Hangman.LiveView.ClientWeb, :live_component

  def render(assigns) do
    ~L"""
    <div id="guess-letters">
      <%= for code <- ?a..?z do %>
        <button phx-click="click" phx-value-guess="<%= <<code>> %>"
                <%= if <<code>> in @guesses, do: "disabled" %>>
          <%= <<code>> %>
        </button>
      <% end %>
    </div>
    """
  end
end
