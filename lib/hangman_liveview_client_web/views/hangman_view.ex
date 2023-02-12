defmodule Hangman.LiveView.ClientWeb.HangmanView do
  use Hangman.LiveView.ClientWeb, :view

  # rope, head, body, leg2, leg1, arm2, arm1
  @spec dim_if(boolean) :: String.t()
  defp dim_if(_dim? = true), do: "opacity-20"
  defp dim_if(_dim?), do: "opacity-100"
end
