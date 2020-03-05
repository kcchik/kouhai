defmodule Kouhai.Repo.Migrations.RemoveUpvoteFromCommentVotes do
  use Ecto.Migration

  def change do
    alter table("comment_votes") do
      remove :upvote
    end
  end
end
