defmodule Hangman.LiveView.ClientWeb.HangmanView do
  use Hangman.LiveView.ClientWeb, :view

  alias Hangman.Game

  # rope, head, body, leg2, leg1, arm2, arm1
  @spec opacity(Game.turns_left(), non_neg_integer) :: String.t()
  defp opacity(turns_left, level) when turns_left > level, do: "opacity-25"
  defp opacity(_turns_left, _level), do: "opacity-100"
end
