defmodule Wsc.StationsTest do
  use Wsc.DataCase

  alias Wsc.Stations

  describe "stations" do
    alias Wsc.Stations.Station

    import Wsc.StationsFixtures

    @invalid_attrs %{drainage_area_effect: nil, drainage_area_gross: nil, from_year: nil, hyd_status: nil, latitude: nil, longitude: nil, prov: nil, record_length: nil, reg_from: nil, reg_to: nil, regulated: nil, station_id: nil, station_name: nil, station_number: nil, to_year: nil}

    test "list_stations/0 returns all stations" do
      station = station_fixture()
      assert Stations.list_stations() == [station]
    end

    test "get_station!/1 returns the station with given id" do
      station = station_fixture()
      assert Stations.get_station!(station.id) == station
    end

    test "create_station/1 with valid data creates a station" do
      valid_attrs = %{drainage_area_effect: 120.5, drainage_area_gross: 120.5, from_year: 42, hyd_status: "some hyd_status", latitude: 120.5, longitude: 120.5, prov: "some prov", record_length: 42, reg_from: 42, reg_to: 42, regulated: true, station_id: 42, station_name: "some station_name", station_number: "some station_number", to_year: 42}

      assert {:ok, %Station{} = station} = Stations.create_station(valid_attrs)
      assert station.drainage_area_effect == 120.5
      assert station.drainage_area_gross == 120.5
      assert station.from_year == 42
      assert station.hyd_status == "some hyd_status"
      assert station.latitude == 120.5
      assert station.longitude == 120.5
      assert station.prov == "some prov"
      assert station.record_length == 42
      assert station.reg_from == 42
      assert station.reg_to == 42
      assert station.regulated == true
      assert station.station_id == 42
      assert station.station_name == "some station_name"
      assert station.station_number == "some station_number"
      assert station.to_year == 42
    end

    test "create_station/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stations.create_station(@invalid_attrs)
    end

    test "update_station/2 with valid data updates the station" do
      station = station_fixture()
      update_attrs = %{drainage_area_effect: 456.7, drainage_area_gross: 456.7, from_year: 43, hyd_status: "some updated hyd_status", latitude: 456.7, longitude: 456.7, prov: "some updated prov", record_length: 43, reg_from: 43, reg_to: 43, regulated: false, station_id: 43, station_name: "some updated station_name", station_number: "some updated station_number", to_year: 43}

      assert {:ok, %Station{} = station} = Stations.update_station(station, update_attrs)
      assert station.drainage_area_effect == 456.7
      assert station.drainage_area_gross == 456.7
      assert station.from_year == 43
      assert station.hyd_status == "some updated hyd_status"
      assert station.latitude == 456.7
      assert station.longitude == 456.7
      assert station.prov == "some updated prov"
      assert station.record_length == 43
      assert station.reg_from == 43
      assert station.reg_to == 43
      assert station.regulated == false
      assert station.station_id == 43
      assert station.station_name == "some updated station_name"
      assert station.station_number == "some updated station_number"
      assert station.to_year == 43
    end

    test "update_station/2 with invalid data returns error changeset" do
      station = station_fixture()
      assert {:error, %Ecto.Changeset{}} = Stations.update_station(station, @invalid_attrs)
      assert station == Stations.get_station!(station.id)
    end

    test "delete_station/1 deletes the station" do
      station = station_fixture()
      assert {:ok, %Station{}} = Stations.delete_station(station)
      assert_raise Ecto.NoResultsError, fn -> Stations.get_station!(station.id) end
    end

    test "change_station/1 returns a station changeset" do
      station = station_fixture()
      assert %Ecto.Changeset{} = Stations.change_station(station)
    end
  end
end
