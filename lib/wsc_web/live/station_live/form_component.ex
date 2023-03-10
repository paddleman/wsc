defmodule WscWeb.StationLive.FormComponent do
  use WscWeb, :live_component

  alias Wsc.Stations

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage station records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="station-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:station_number]} type="text" label="Station number" />
        <.input field={@form[:station_name]} type="text" label="Station name" />
        <.input field={@form[:hyd_status]} type="text" label="Hyd status" />
        <.input
          field={@form[:drainage_area_gross]}
          type="number"
          label="Drainage area gross"
          step="any"
        />
        <.input
          field={@form[:drainage_area_effect]}
          type="number"
          label="Drainage area effect"
          step="any"
        />
        <.input field={@form[:lat]} type="number" label="Latitude" step="any" />
        <.input field={@form[:lng]} type="number" label="Longitude" step="any" />
        <.input field={@form[:from_year]} type="number" label="From year" />
        <.input field={@form[:to_year]} type="number" label="To year" />
        <.input field={@form[:record_length]} type="number" label="Record length" />
        <.input field={@form[:regulated]} type="checkbox" label="Regulated" />
        <.input field={@form[:reg_from]} type="number" label="Reg from" />
        <.input field={@form[:reg_to]} type="number" label="Reg to" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Station</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{station: station} = assigns, socket) do
    changeset = Stations.change_station(station)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"station" => station_params}, socket) do
    changeset =
      socket.assigns.station
      |> Stations.change_station(station_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"station" => station_params}, socket) do
    save_station(socket, socket.assigns.action, station_params)
  end

  defp save_station(socket, :edit, station_params) do
    case Stations.update_station(socket.assigns.station, station_params) do
      {:ok, station} ->
        notify_parent({:saved, station})

        {:noreply,
         socket
         |> put_flash(:info, "Station updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_station(socket, :new, station_params) do
    case Stations.create_station(station_params) do
      {:ok, station} ->
        notify_parent({:saved, station})

        {:noreply,
         socket
         |> put_flash(:info, "Station created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
