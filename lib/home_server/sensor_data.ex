defmodule HomeServer.SensorData do
  alias HomeServer.Repo
  alias HomeServer.Sensors.{SensorData, Sensor}

  def post_data(attrs \\ %{}) do
    %{data_schema: data_schema} =
      Repo.get!(Sensor, attrs["sensor_id"])

    %SensorData{}
    |> SensorData.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, sensor} ->
        {:ok, sensor}

      {:error, changeset} ->
        {:error, changeset}
    end
  end
end
