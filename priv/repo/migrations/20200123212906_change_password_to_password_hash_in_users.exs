defmodule Kouhai.Repo.Migrations.ChangePasswordToPasswordHashInUsers do
  use Ecto.Migration

  def change do
    rename table(:users), :password, to: :password_hash
  end
end
