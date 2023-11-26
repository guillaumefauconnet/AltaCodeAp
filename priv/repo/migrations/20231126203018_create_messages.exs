defmodule Altamessengerapi.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :message, :text
      add :channel_id, references(:channels, type: :binary_id)
      add :user_id, references(:users, type: :binary_id)

      timestamps(type: :utc_datetime)
    end
  end
end
