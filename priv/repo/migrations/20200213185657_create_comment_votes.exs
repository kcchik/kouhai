defmodule Kouhai.Repo.Migrations.CreateCommentVotes do
  use Ecto.Migration

  def change do
    create table(:comment_votes) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :comment_id, references(:comments, on_delete: :delete_all)
      add :is_upvote, :boolean

      timestamps()
    end

    create index(:comment_votes, [:user_id])
    create index(:comment_votes, [:comment_id])
  end
end
