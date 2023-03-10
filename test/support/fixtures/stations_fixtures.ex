defmodule Wsc.StationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Wsc.Stations` context.
  """

  @doc """
  Generate a station.
  """
  def station_fixture(attrs \\ %{}) do
    {:ok, station} =
      attrs
      |> Enum.into(%{
        drainage_area_effect: 120.5,
        drainage_area_gross: 120.5,
        from_year: 42,
        hyd_status: "some hyd_status",
        latitude: 120.5,
        longitude: 120.5,
        prov: "some prov",
        record_length: 42,
        reg_from: 42,
        reg_to: 42,
        regulated: true,
        station_id: 42,
        station_name: "some station_name",
        station_number: "some station_number",
        to_year: 42
      })
      |> Wsc.Stations.create_station()

    station
  end
end
