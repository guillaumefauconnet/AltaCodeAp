defmodule Altamessengerapi.Repo.Migrations.CreateUsersChannels do
  use Ecto.Migration

  def change do
    create table(:users_channels, primary_key: false) do
      add :user_id, references(:users, type: :binary_id)
      add :channel_id, references(:channels, type: :binary_id)
    end
  end
end
