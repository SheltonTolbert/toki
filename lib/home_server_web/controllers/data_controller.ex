defmodule HomeServerWeb.DataController do
  use HomeServerWeb, :controller

  alias HomeServer.SensorData

  def create(conn, attrs) do
    case SensorData.post_data(attrs) do
      {:ok, sensor} ->
        conn
        |> put_status(:created)
        |> json(%{status: :ok, should_fetch_config: true})

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

  def create(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Invalid payload"})
  end

  defp translate_error({msg, _opts}), do: msg
end
