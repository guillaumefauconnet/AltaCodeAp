defmodule Altamessengerapi.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages, primary_key: false) do
      add :id, :binary_id, primary_key: true, null: false
      add :message, :text, null: false
      add :channel_id, references(:channels, type: :binary_id), null: false
      add :user_id, references(:users, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end
  end
end
