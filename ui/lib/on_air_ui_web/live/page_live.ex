defmodule OnAirUIWeb.PageLive do
  use OnAirUIWeb, :live_view
  alias OnAirUI.ColorSelection

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: OnAirUIWeb.Endpoint.subscribe("color")
    color = ColorSelection.get_hex()
    {:ok, assign(socket, color: color)}
  end

  def render(assigns) do
    ~L"""
    <form phx-change="color-change" phx-submit="color-change">
      <input type="color" name="color" value="#<%= @color %>">
    </form>

    <p>
      <a href="#" phx-click="reset">Reset</a>
    </p>
    """
  end

  def handle_event("color-change", %{"color" => "#" <> color}, socket) do
    :ok = ColorSelection.set_hex(color)
    {:noreply, socket}
  end

  def handle_event("reset", _params, socket) do
    :ok = ColorSelection.set_color({0, 0, 0})
    {:noreply, assign(socket, color: "000000")}
  end

  def handle_info(%Phoenix.Socket.Broadcast{payload: %{color: color}, event: "change", topic: "color"}, socket) do
    {:noreply, assign(socket, color: color)}
  end
end
