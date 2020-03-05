defmodule Kouhai.Repo.Migrations.AddUpvoteToCommentVotes do
  use Ecto.Migration

  def change do
    alter table(:comment_votes) do
      add :upvote, :boolean
    end
  end
end
