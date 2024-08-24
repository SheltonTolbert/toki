defmodule HomeServer.Repo.Migrations.CreateSensorConfigTable do
  use Ecto.Migration

  def change do
    create table(:sensor_config) do
      add :sensor_id, references(:sensors, type: :string, column: :sensor_id, on_delete: :delete_all)
      add :config, :jsonb

      timestamps()
    end

    create index(:sensor_config, [:sensor_id])
  end
end
