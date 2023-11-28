defmodule AltamessengerapiWeb.UserTokenJSON do
  alias Altamessengerapi.Accounts.UserToken

  @doc """
  Renders a single message.
  """
  def show(%{token: token}) do
    token
    |> IO.inspect()
    #%{data: data(message)}
  end

  #defp data(%Message{} = message) do
  #  %{
  #    id: message.id,
  #    message: message.message
  #  }
  #end
end
