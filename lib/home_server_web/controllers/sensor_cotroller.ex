defmodule HomeServerWeb.SensorController do
  use HomeServerWeb, :controller

  alias HomeServer.Sensors

  def create(conn, attrs) do
    case Sensors.register_sensor(attrs) do
      {:ok, sensor} ->
        conn
        |> put_status(:created)
        |> json(%{message: "Sensor registered successfully"})

      {:error, changeset} ->
        errors =
          changeset
          |> Ecto.Changeset.traverse_errors(&translate_error/1)
          |> Enum.into(%{})

        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: errors})
    end
  end

  defp translate_error({msg, _opts}), do: msg
end
