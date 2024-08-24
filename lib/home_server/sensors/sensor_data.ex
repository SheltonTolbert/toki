defmodule HomeServer.Sensors.SensorData do
  use Ecto.Schema
  import Ecto.Changeset

  alias HomeServer.Sensors.Sensor

  schema "sensor_data" do
    field :sensor_id, :string, primary_key: true
    field :data, :map

    belongs_to :sensors, Sensor

    timestamps()
  end

  def changeset(sensor_data, attrs) do
    sensor_data
    |> cast(attrs, [:sensor_id, :data])
    |> validate_required([:sensor_id, :data])
  end
end
