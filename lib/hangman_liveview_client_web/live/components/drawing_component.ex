defmodule Hangman.LiveView.ClientWeb.DrawingComponent do
  use Hangman.LiveView.ClientWeb, :live_component

  def path_class(turns_left, gate) when turns_left > gate, do: "conceal"
  def path_class(_turns_left, _gate), do: nil
end
