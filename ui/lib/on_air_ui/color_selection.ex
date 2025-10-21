defmodule OnAirUI.ColorSelection do
  defstruct [:led_server, color: {0, 0, 0}]
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def set_color(color) do
    GenServer.call(__MODULE__, {:set_color, color})
  end

  def get_color() do
    GenServer.call(__MODULE__, :get_color)
  end

  def get_hex() do
    to_hex(get_color())
  end

  def set_hex(color) do
    case Base.decode16(color, case: :mixed) do
      {:ok, <<r, g, b>>} -> set_color({r, g, b})
      _ -> {:error, "Invalid hex color code"}
    end
  end

  def register() do
    GenServer.call(__MODULE__, {:register, self()})
  end

  def init([]) do
    {:ok, %__MODULE__{}}
  end

  def handle_call({:set_color, color}, _from, state) do
    state = %{state | color: color}
    announce_color(state)
    {:reply, :ok, state}
  end

  def handle_call(:get_color, _from, state) do
    {:reply, state.color, state}
  end

  def handle_call({:register, pid}, _from, state) do
    Process.link(pid)
    state = %{state | led_server: pid}
    announce_color(state)
    {:reply, :ok, state}
  end

  def announce_color(state) do
    OnAirUIWeb.Endpoint.broadcast("color", "change", %{color: to_hex(state.color)})
    if state.led_server do
      send(state.led_server, {:color_change, state.color})
    end

    state
  end

  defp to_hex({r, g, b}) do
    Base.encode16(<<r, g, b>>)
  end
end
