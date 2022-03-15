defmodule Hangman.LiveView.ClientWeb.PageController do
  use Hangman.LiveView.ClientWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
