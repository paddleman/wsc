defmodule Wsc.Stations.Station do
  use Ecto.Schema
  import Ecto.Changeset
  alias Geo.PostGIS

  @derive {Jason.Encoder, only: [:id, :lat, :lng, :station_number]}
  schema "bc_stns" do
    field :station_number, :string
    field :station_name, :string

    field :drainage_area_effect, :float
    field :drainage_area_gross, :float
    # field :prov, :string

    field :lng, :float, source: :longitude
    field :lat, :float, source: :latitude
    field :geom, PostGIS.Geometry

    field :hyd_status, :string
    field :from_year, :integer
    field :to_year, :integer
    field :record_length, :integer

    field :regulated, :boolean, default: false
    field :reg_from, :integer
    field :reg_to, :integer

    # timestamps()
  end

  @doc false
  def changeset(station, attrs) do
    station
    |> cast(attrs, [
      :station_number,
      :station_name,
      :hyd_status,
      :drainage_area_gross,
      :drainage_area_effect,
      :lat,
      :lng,
      :from_year,
      :to_year,
      :record_length,
      :regulated,
      :reg_from,
      :reg_to
    ])
    |> validate_required([
      :station_number,
      :station_name,
      :lat,
      :lng
    ])
  end
end
