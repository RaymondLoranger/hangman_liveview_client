defmodule Hangman.LiveView.ClientWeb.HangmanLiveTest do
  use Hangman.LiveView.ClientWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, hangman_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome to Hangman!"
    assert render(hangman_live) =~ "Welcome to Hangman!"
  end
end
