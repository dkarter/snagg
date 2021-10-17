defmodule Snagg.Repo.Migrations.CreateResourceGroups do
  use Ecto.Migration

  def change do
    create table(:resource_groups) do
      add :name, :string, null: false
      add :deleted_at, :utc_datetime

      timestamps()
    end

    create unique_index(:resource_groups, :name)
  end
end
