defmodule Hangman.LiveView.ClientWeb.NewGameComp do
  use Hangman.LiveView.ClientWeb, :live_component

  def render(assigns) do
    ~L"""
    <div id=new-game>
      <button phx-click="new-game">
        New Game
      </button>
    </div>
    """
  end
end
