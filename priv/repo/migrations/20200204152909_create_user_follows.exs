defmodule Kouhai.Repo.Migrations.CreateFollows do
  use Ecto.Migration

  def change do
    create table(:follows) do
      add :followed_id, references(:users)
      add :follower_id, references(:users)

      timestamps()
    end
  end
end
