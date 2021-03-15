defmodule Hangman.LiveView.ClientWeb.GuessLettersComp do
  use Hangman.LiveView.ClientWeb, :live_component

  def render(assigns) do
    ~L"""
    <div id="guess-letters">
      <%= for code <- ?a..?z do %>
        <button phx-click="click" phx-value-guess="<%= <<code>> %>"
                <%= if <<code>> in @guesses, do: "disabled" %>
                class="<%= button_class(<<code>>, @letters) %>">
          <%= <<code>> %>
        </button>
      <% end %>
    </div>
    """
  end

  defp button_class(letter, letters), do: if(letter in letters, do: "correct")
end
