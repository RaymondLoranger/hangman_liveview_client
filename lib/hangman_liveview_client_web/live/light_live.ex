defmodule Hangman.LiveView.ClientWeb.LightLive do
  use Hangman.LiveView.ClientWeb, :live_view

  @brightness %{min: 0, max: 100}

  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style="width: <%= @brightness %>%">
          <%= @brightness %>%
        </span>
      </div>

      <button phx-click="off" id="off">
        <img src="images/light-off.svg">
      </button>

      <button phx-click="down" id="down">
        <img src="images/down.svg">
      </button>

      <button phx-click="up" id="up">
        <img src="images/up.svg">
      </button>

      <button phx-click="on" id="on">
        <img src="images/light-on.svg">
      </button>

      <form phx-change="update">
        <input type="range" min="0" max="100" name="brightness"
               value="<%= @brightness %>"/>
      </form>
    </div>
    """
  end

  def handle_event("update", %{"brightness" => brightness}, socket) do
    brightness = String.to_integer(brightness)
    {:noreply, assign(socket, :brightness, brightness)}
  end

  def handle_event("on", _, socket) do
    {:noreply, assign(socket, :brightness, 100)}
  end

  def handle_event("up", _, socket) do
    {:noreply, update(socket, :brightness, &min(&1 + 10, @brightness.max))}
  end

  def handle_event("down", _, socket) do
    {:noreply, update(socket, :brightness, &max(&1 - 10, @brightness.min))}
  end

  def handle_event("off", _, socket) do
    {:noreply, assign(socket, :brightness, 0)}
  end
end
