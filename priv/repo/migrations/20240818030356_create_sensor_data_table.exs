defmodule HomeServer.Repo.Migrations.CreateSensorDataTable do
  use Ecto.Migration

  def change do
    create table(:sensor_data) do
      add :sensor_id,
          references(:sensors, type: :string, column: :sensor_id, on_delete: :delete_all)

      add :data, :jsonb

      timestamps()
    end

    create index(:sensor_data, [:sensor_id])
  end
end
