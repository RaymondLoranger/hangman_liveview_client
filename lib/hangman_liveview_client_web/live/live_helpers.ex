defmodule Hangman.LiveView.ClientWeb.LiveHelpers do
  use Phoenix.Component

  alias Hangman.Game
  alias Hangman.LiveView.ClientWeb.HangmanView
  alias Phoenix.HTML
  alias Phoenix.LiveView.{Rendered, Socket}

  @spec word_letter(Socket.assigns()) :: Rendered.t()
  def word_letter(assigns) do
    ~H"""
    <span id={@id} class={clue_letter(@letter)}>
      <%= @letter %>
    </span>
    """
  end

  def turns_left(assigns) do
    ~H"""
    <p id="turns-left" class={if @turns_left == 1, do: "bg-red-500 text-white"}>
      Turns left: <%= @turns_left %>
    </p>
    """
  end

  def new_game_button(assigns) do
    ~H"""
    <div id="new-game">
      <button phx-click="new-game">New Game</button>
    </div>
    """
  end

  def message(assigns) do
    ~H"""
    <p id="message">
      <%= message(@game_state, @guess) %>
    </p>
    """
  end

  def guess_letter(assigns) do
    ~H"""
    <button id={@id} phx-click="click" phx-value-guess={@letter}
        disabled={@disabled} class={guess_letter(@correct, @game_over)}>
      <%= @letter %>
    </button>
    """
  end

  def drawing(assigns) do
    ~H"""
    <%= HangmanView.render("_drawing.html", assigns) %>
    """
  end

  ## Private functions

  @spec clue_letter(Game.letter() | Game.underline() | charlist) ::
          String.t() | nil
  defp clue_letter("_"), do: nil
  defp clue_letter(letter) when is_binary(letter), do: "appear"
  defp clue_letter(_charlist), do: "unveil"

  # initializing, good guess, bad guess, already used, lost, won...
  @spec message(Game.state(), Game.letter() | nil) :: String.t() | HTML.safe()
  defp message(:initializing, _guess), do: "Good luck 😊❗"
  defp message(:good_guess, _guess), do: "Good guess 😊❗"

  defp message(:bad_guess, guess),
    do: HTML.raw("Letter <span>#{guess}</span> not in the word 😟❗")

  defp message(:already_used, guess),
    do: HTML.raw("Letter <span>#{guess}</span> already used 😮❗")

  defp message(:lost, _guess), do: HTML.raw("Sorry, <span>you lost</span> 😂❗")
  defp message(:won, _guess), do: HTML.raw("Bravo, <span>you won</span> 😇❗")

  @spec guess_letter(boolean, boolean) :: String.t() | nil
  defp guess_letter(correct, game_over)
  defp guess_letter(false, false), do: nil
  defp guess_letter(false, true), do: "game-over"
  defp guess_letter(true, false), do: "correct"
  defp guess_letter(true, true), do: "correct game-over"
end
