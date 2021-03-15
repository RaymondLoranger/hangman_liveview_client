defmodule Hangman.LiveView.ClientWeb.DrawingComp do
  use Hangman.LiveView.ClientWeb, :live_component

  defp path_class(turns_left, gate) when turns_left > gate, do: "conceal"
  defp path_class(_turns_left, _gate), do: nil
end
