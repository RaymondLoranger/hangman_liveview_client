defmodule Hangman.LiveView.ClientWeb.GuessLettersComponent do
  use Hangman.LiveView.ClientWeb, :live_component

  def render(assigns) do
    ~L"""
    <div id="guess-letters">
      <div class="letters-grid">
        <%= for letter <- ?a..?z do %>
          <button phx-click="click" phx-value-guess="<%= <<letter>> %>"
                  <%= if <<letter>> in @guesses, do: "disabled" %>>
            <%= <<letter>> %>
          </button>
        <% end %>
      </div>
    </div>
    """
  end
end
