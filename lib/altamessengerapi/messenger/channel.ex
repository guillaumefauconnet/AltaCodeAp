defmodule Altamessengerapi.Messenger.Channel do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "channels" do
    field :name, :string

    has_many :messages, Altamessengerapi.Messenger.Message
    many_to_many :users, Altamessengerapi.Messenger.User, join_through: "users_channels"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(channel, attrs) do
    channel
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
