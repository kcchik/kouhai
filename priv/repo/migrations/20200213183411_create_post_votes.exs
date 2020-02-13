defmodule Kouhai.Repo.Migrations.CreatePostVotes do
  use Ecto.Migration

  def change do
    create table(:post_votes) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :post_id, references(:posts, on_delete: :delete_all)
      add :upvote, :boolean

      timestamps()
    end

    create index(:post_votes, [:user_id])
    create index(:post_votes, [:post_id])
  end
end
