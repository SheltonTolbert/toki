defmodule HomeServerWeb.ConfigController do
  use HomeServerWeb, :controller

  alias HomsServer.Sensors

  def get_config(conn, %{
        "sensor_id" => sensor_id
      }) do
    # Respond with a status and message
    #
    case Sensors.get_config(sensor_id) do
      {:ok, config} ->
        conn
        |> json(%{status: :ok, config: config})

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

  def get_config(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Invalid payload"})
  end

  defp translate_error({msg, _opts}), do: msg
end
