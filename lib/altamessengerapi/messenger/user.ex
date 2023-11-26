defmodule Altamessengerapi.Messenger.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :username, :string

    has_many :messages, Altamessengerapi.Messenger.Message
    many_to_many :channels, Altamessengerapi.Messenger.Channel, join_through: "users_channels"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
  end
end
