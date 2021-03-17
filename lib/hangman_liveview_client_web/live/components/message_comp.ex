defmodule Hangman.LiveView.ClientWeb.MessageComp do
  use Hangman.LiveView.ClientWeb, :live_component

  alias Hangman.Engine.Game
  alias Phoenix.HTML
  alias Phoenix.LiveView.{Rendered, Socket}

  @spec render(Socket.assigns()) :: Rendered.t()
  def render(assigns) do
    ~L"""
    <p id="message"><%= message(@game_state, @guess) %></p>
    """
  end

  # initializing, good guess, bad guess, already used, lost, won...
  @spec message(Game.state(), Game.letter() | nil) ::
          String.t() | HTML.safe()
  defp message(:initializing, _guess), do: "Good luck 😊❗"
  defp message(:good_guess, _guess), do: "Good guess 😊❗"

  defp message(:bad_guess, guess),
    do: HTML.raw("Letter <span>#{guess}</span> not in the word 😟❗")

  defp message(:already_used, guess),
    do: HTML.raw("Letter <span>#{guess}</span> already used 😮❗")

  defp message(:lost, _guess), do: "Sorry, you lost 😂❗"
  defp message(:won, _guess), do: "Bravo, you won 😇❗"
end
