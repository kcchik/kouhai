defmodule Kouhai.Repo.Migrations.UniqueIndexEmailInUsers do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:email])
  end
end
