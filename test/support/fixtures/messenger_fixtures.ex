defmodule Altamessengerapi.MessengerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Altamessengerapi.Messenger` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        message: "some message"
      })
      |> Altamessengerapi.Messenger.create_message()

    message
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
