defmodule HomeServer.Sensors do
  alias HomeServer.Repo
  alias HomeServer.Sensors.{Sensor, SensorConfig}

  def register_sensor(attrs \\ %{}) do
    %Sensor{}
    |> Sensor.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, sensor} ->
        {:ok, sensor}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  defp create_sensor_config(sensor, config) do
    %SensorConfig{sensor_id: sensor.sensor_id, config: config}
    |> SensorConfig.changeset()
    |> Repo.insert()
  end
end
