defmodule Altamessengerapi.Messenger.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "messages" do
    field :message, :string
    belongs_to :channel, Altamessengerapi.Messenger.Channel
    belongs_to :user, Altamessengerapi.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message, :channel_id, :user_id])
    |> assoc_constraint(:channel)
    |> assoc_constraint(:user)
    |> validate_required([:message])
  end
end
