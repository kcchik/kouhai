defmodule Kouhai.Repo.Migrations.CreateFollows do
  use Ecto.Migration

  def change do
    create table(:follows) do
      add :followed_id, references(:users, on_delete: :delete_all)
      add :follower_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:follows, [:followed_id])
    create index(:follows, [:follower_id])
  end
end
