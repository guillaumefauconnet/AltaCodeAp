defmodule Altamessengerapi.MessengerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Altamessengerapi.Messenger` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        username: "some username"
      })
      |> Altamessengerapi.Messenger.create_user()

    user
  end

  @doc """
  Generate a channel.
  """
  def channel_fixture(attrs \\ %{}) do
    {:ok, channel} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Altamessengerapi.Messenger.create_channel()

    channel
  end
end
