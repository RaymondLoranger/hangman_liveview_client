defmodule Hangman.LiveView.ClientWeb.DrawingComp do
  use Hangman.LiveView.ClientWeb, :live_component

  alias Hangman.Engine.Game

  @spec class(Game.turns_left(), non_neg_integer) :: String.t() | nil
  defp class(turns_left, gate) when turns_left > gate, do: "blur"
  defp class(_turns_left, _gate), do: nil
end
