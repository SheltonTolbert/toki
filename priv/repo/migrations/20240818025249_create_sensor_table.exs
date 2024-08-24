defmodule HomeServer.Repo.Migrations.CreateSensorTable do
  use Ecto.Migration

  def change do
    create table(:sensors, primary_key: false) do
      add :sensor_id, :string, primary_key: true
      add :type, :text
      add :data_schema, :jsonb
      add :config_schema, :jsonb

      timestamps()
    end
  end
end
