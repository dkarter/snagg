defmodule Snagg.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    execute """
    create extension citext;
    """

    create table(:users) do
      add :email, :citext, null: false
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :avatar_url, :string
      add :oauth_data, :jsonb

      timestamps()
    end

    create unique_index(:users, [:email])
  end

  def down do
    drop table(:users)

    execute """
    drop extension citext;
    """
  end
end
