defmodule WscWeb.StationLive.Index do
  use WscWeb, :live_view

  alias Wsc.Stations
  alias Wsc.Stations.Station
  alias WscWeb.StationInfoComponent

  @impl true
  def mount(_params, _session, socket) do
    socket
    |> assign(stations: list_stations())
    |> assign(selected_station: nil)

    {:ok, socket}
  end

  @impl true
  def handle_event("get-stations", _, socket) do
    {:reply, %{stations: socket.assigns.stations}, socket}
  end

  @impl true
  def handle_event("marker-clicked", %{"stationId" => id}, socket) do
    station = find_station(socket, id)

    {:reply, %{station: station}, assign(socket, selected_station: station)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(stations: list_stations())
    |> assign(:page_title, "Listing Stations")
    |> assign(:selected_station, nil)
  end

  @impl true
  defp list_stations() do
    Stations.list_stations()
  end

  defp find_station(socket, id) do
    Enum.find(socket.assigns.stations, &(&1.id == id))
  end
end
