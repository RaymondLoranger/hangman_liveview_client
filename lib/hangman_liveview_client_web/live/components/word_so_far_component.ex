defmodule Hangman.LiveView.ClientWeb.WordSoFarComponent do
  use Hangman.LiveView.ClientWeb, :live_component

  def render(assigns) do
    ~L"""
    <p id="word-so-far">
      <%= for letter <- @letters do %>
        <%= if is_list(letter) do %>
          <span class="reveal"><%= to_string(letter) %> </span>
        <% else %>
          <span class="letter"><%= letter %> </span>
        <% end %>
      <% end %>
    </p>
    """
  end
end
