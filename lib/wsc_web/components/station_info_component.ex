defmodule WscWeb.StationInfoComponent do
  use Phoenix.LiveComponent
  alias Wsc.Utilities

  def mount(_params, _session, socket) do
    # socket = assign(socket, key: value)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="">
      <div class="border-2 border-zinc-100 rounded mb-2">
        <div class="py-1 text-lg font-bold text-white text-center">
          <%= @stn.station_number %> - <%= @stn.station_name %>
        </div>
      </div>
      <div class="border-2 border-zinc-100 rounded mb-2">
        <div class="flex">
          <div class="w-1/5 py-1 text-lg font-bold text-white text-center">
            <span class="font-thin text-zinc-300">Watershed Area(sq.km):</span>
            <span class="font-semibold text-zinc-100">
              <%= Utilities.pretty_num(@stn.drainage_area_gross, 1) %>
            </span>
          </div>

          <div class="w-2/5 py-1 text-lg font-bold text-white text-center">
            <span class="font-thin text-zinc-300">Status:</span>
            <span class="font-semibold text-zinc-100">
              <%= @stn.hyd_status %> | <%= @stn.regulated %>
            </span>
          </div>

          <div class="w-1/5 py-1 text-lg font-bold text-white text-center">
            <span class="font-thin text-zinc-300">Time Span:</span>
            <span class="font-semibold text-zinc-100">
              <%= @stn.from_year %> - <%= @stn.to_year %>
            </span>
          </div>
          <div class="w-1/5 py-1 text-lg font-bold text-white text-center">
            <span class="font-thin text-zinc-300">Record Length(yrs):</span>
            <span class="font-semibold text-zinc-100">
              <%= @stn.record_length %>
            </span>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
