defmodule Kouhai.Repo.Migrations.RemovePostIdFromCommentVotes do
  use Ecto.Migration

  def change do
    alter table("comment_votes") do
      remove :post_id
    end
  end
end
