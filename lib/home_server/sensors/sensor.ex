defmodule HomeServer.Sensors.Sensor do
  use Ecto.Schema
  import Ecto.Changeset

  alias HomeServer.Sensors.SensorData

  @primary_key false
  schema "sensors" do
    field :sensor_id, :string, primary_key: true
    field :type, :string
    field :data_schema, :map
    field :config_schema, :map

    has_many :sensor_data, SensorData, references: :sensor_id

    timestamps()
  end

  def changeset(sensor, attrs) do
    sensor
    |> cast(attrs, [:sensor_id, :type, :data_schema, :config_schema])
    |> validate_required([:sensor_id, :type, :data_schema])
    |> unique_constraint(:sensor_id)
  end
end
