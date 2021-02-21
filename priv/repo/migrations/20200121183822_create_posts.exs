defmodule Kouhai.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :content, :string

      timestamps()
    end

    create index(:posts, [:user_id])
  end
end
