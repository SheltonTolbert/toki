defmodule HomeServer.Sensors.SensorConfig do
  use Ecto.Schema

  import Ecto.Changeset

  schema "sensor_config" do
    field :config, :map
    field :sensor_id, :string

    timestamps()
  end

  def changeset(sensor_config) do
    sensor_config
    |> validate_required([:sensor_id, :config])
  end
end
